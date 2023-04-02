import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class  User{
  final String id;
  final String name;
  final String surname;
  final String companyName;

  User({required this.id,required this.name,required this.surname,required  this.companyName});
  factory User.fromJson(Map<String, dynamic> json){
    return User(id:json['id'],name:json['name'],surname:json['surname'],companyName:json['companyName']);
  }
}

class APIConnector{

    static const apiPath = "https://kgp-ticketapp.azurewebsites.net/";
    final client = RetryClient(http.Client());
     login(String email,String password) async {
      final response = await http.post(Uri.parse("$apiPath/users/organizers/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      }),
      );
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400){
        throw Exception('Złe dane logowania.');
      }
      else{
          throw Exception('Coś poszło nie tak skontaktuj się z obsługą klienta');
        }
  }
}