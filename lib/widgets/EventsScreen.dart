import 'package:flutter/material.dart';
import 'package:kgpapp/APIConnectors/APIConnector.dart';
import 'package:kgpapp/widgets/EventWidget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder( future: APIConnector.getEvents(),builder: (context,AsyncSnapshot  projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          !projectSnap.hasData ) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
      itemCount:projectSnap.data?.length??0,
      itemBuilder: (context, index) {
        Event event = projectSnap.data[index];

        return EventWidget(event: event, idx: index, cb: (e)=>{});
      },
    );});
  }
}

typedef func = void Function(int index);

