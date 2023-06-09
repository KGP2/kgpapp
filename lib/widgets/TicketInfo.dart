import 'package:flutter/material.dart';
import 'package:kgpapp/APIConnectors/APIConnector.dart';

class TicketInfo extends StatelessWidget{
  const TicketInfo(this.ticket, {super.key} );
  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    return Text(ticket.title);
  }

}