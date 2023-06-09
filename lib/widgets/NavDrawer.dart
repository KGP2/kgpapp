import 'package:flutter/material.dart';
import 'package:kgpapp/Util/SharedDataUtil.dart';
import 'package:kgpapp/widgets/BusinessCard.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Wydarzenia'),
            onTap: () => {Navigator.pushNamed(context, '/authenticated/')},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Skanuj'),
            onTap: () => {Navigator.pushNamed(context, '/authenticated/QRScanner/Scan', arguments: false)},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Skasuj'),
            onTap: () => {Navigator.pushNamed(context, '/authenticated/QRScanner/Validate', arguments: true)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/')},
          ),
        ],
      ),
    );
  }
}