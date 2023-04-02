import 'package:flutter/material.dart';

class TicketInfo extends StatelessWidget{
  const TicketInfo(this.text, {super.key} );
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }

}