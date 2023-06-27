import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:kgpapp/Util/SharedDataUtil.dart';
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';


class Event{
  final String id;
  final String name;
  final String date;
  final String place;
  final String? photo;
  Event(this.id,this.name, this.date, this.place, this.photo);
  factory Event.fromJson(Map<String, dynamic> json){
    return Event(json['id'] as String,json['name'] as String,json['date'] as String,json['place'] as String,json['photo'] as String?);
  }
}

class  User{
  final String id;
  final String name;
  final String surname;
  final String companyName;

  User({required this.id,required this.name,required this.surname,required  this.companyName});
  factory User.fromJson(Map<String, dynamic> json){
    return User(id:json['user']['id'],name:json['user']['name'],surname:json['user']['surname'],companyName:json['user']['companyName']);
  }
}

class Ticket{
  final String id;
  final String url;

  Ticket(this.id,this.url);
  factory Ticket.fromJson(Map<String, dynamic> json){
    return Ticket(json['ticketId'],json['ticketPdfUrl']);
  }
}


class APIConnector{

   static final Dio dio = Dio();
   static String token = "";
    static const apiPath = "https://kgp-ticketapp.azurewebsites.net";
   static final client = RetryClient(http.Client());
    static login(String email,String password) async {

        final response = await client.post(Uri.parse("$apiPath/users/organizers/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password
          }),
       );
      if (response.statusCode == 200) {
        SweetCookieJar sweetCookieJar = SweetCookieJar.from(response: response);
        Cookie cookie = sweetCookieJar.find(name: 'Token');
        token = cookie.value;
        return User.fromJson(jsonDecode(response.body));

      } else if (response.statusCode == 400){
        throw Exception('Złe dane logowania.');
      }
      else{
          throw Exception('Coś poszło nie tak skontaktuj się z obsługą klienta');
        }

  }
  static Future<bool> validateTicket(String id) async {

    final response = await client.post(Uri.parse("$apiPath/tickets/validate/"+ id),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer ' + token
    },);
    if (response.statusCode == 200) {


      return true;

    }
    else{
      throw Exception('Coś poszło nie tak skontaktuj się z obsługą klienta');
    }
  }
   static Future<Ticket> getTicketInfo(String id) async {
     final response = await client.get(Uri.parse("$apiPath/tickets/"+ id),headers: <String, String>{
     'Content-Type': 'application/json; charset=UTF-8',
     'Authorization':'Bearer ' + token
     },);
     if (response.statusCode == 200) {
       return Ticket.fromJson(jsonDecode(response.body));

     }
     else{
       throw Exception('Coś poszło nie tak skontaktuj się z obsługą klienta');
     }
   }
   static Future getEvents() async {
       final response = await client.get(Uri.parse("$apiPath/eventsByOrganizer/"+ SharedDataUtil.user!.id));
      if (response.statusCode == 200) {
        List<Event> l = [];
        for(var i in jsonDecode(response.body)){
          l.add(Event.fromJson(i));
        }
        return l;

      }
      else{
        throw Exception('Coś poszło nie tak skontaktuj się z obsługą klienta');
      }
    }
}