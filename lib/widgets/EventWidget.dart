import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kgpapp/APIConnectors/APIConnector.dart';
import 'package:kgpapp/Util/SharedDataUtil.dart';
import 'package:kgpapp/widgets/EventsScreen.dart';

typedef func = void Function(int index);
class EventWidget extends StatelessWidget {

  EventWidget({required this.event,required this.cb, required this.idx});
  final Event event;
  final func cb;
  final int idx;
  void redirectToQRCheck(bool validate,BuildContext context){
    if(validate){
      Navigator.pushNamed(context, '/authenticated/QRScanner/Validate');
    }else{
      Navigator.pushNamed(context, '/authenticated/QRScanner/Scan');
    }
  }


  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(event.date);
    return Container(
      child: Dismissible(
          key: Key(event.name),
          background: Container(
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: AlignmentDirectional.centerStart,
            child: Text("Sprawdź"),
          ),

          secondaryBackground: Container(
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: AlignmentDirectional.centerEnd,
            child: Text("Skasuj"),
          ),

          confirmDismiss : (DismissDirection d){
            if(d == DismissDirection.startToEnd){
             redirectToQRCheck(false,context);
            }
            else{
              redirectToQRCheck(true,context);
            }
            return Future.value(false);
          },
          child: ExpansionTile(

            leading: CircleAvatar(child: Text(event.name[0]),),
            title: Text(event.name, style: TextStyle(fontWeight: FontWeight.w800)),
            children:  [
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Row(
                   children: [
                     Text('Data: '),
                     Text("${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}"),
                   ],
                 ),
               ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Miejsce: '),
                    Text(event.place),
                  ],
                ),
              ),
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){redirectToQRCheck(false, context);}, child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Skanuj"),
                    )),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){redirectToQRCheck(true, context);}, child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Skasuj"),
                    )),
                  ),
                  const Spacer(),
                ],
              ),
            )]
          )),
    );
  }
}