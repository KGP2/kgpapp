import 'package:flutter/material.dart';
import 'package:kgpapp/APIConnectors/APIConnector.dart';

class TicketInfo extends StatelessWidget{
  const TicketInfo(this.isValid, {super.key} );
  final bool isValid;
  @override
  Widget build(BuildContext context) {
    String text= '';
    if(isValid){
      text = 'OK :)';
    }
    else{
      text = 'Nie OK :(';
    }
    return  Scaffold(
        body: Center( child: Text(text))
    );
  }

}