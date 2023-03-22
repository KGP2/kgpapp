import 'package:flutter/material.dart';
import 'package:kgpapp/DarkThemeProvider.dart';
import 'package:kgpapp/widgets/LoginScreen.dart';
import 'package:kgpapp/widgets/NavDrawer.dart';

class RoutePage extends StatefulWidget {
  RoutePage({Key? key,required  this.themeChangeProvider}) : super(key: key){
   iconData = themeChangeProvider.darkTheme?Icons.mode_night:Icons.sunny;
  }

  final DarkThemeProvider themeChangeProvider;
  IconData iconData = Icons.sunny;
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: NavDrawer(),
        appBar: AppBar(

        leading: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
              },
            child: const Icon(
              Icons.menu,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    widget.themeChangeProvider.darkTheme =! widget.themeChangeProvider.darkTheme;
                    widget.iconData = widget.themeChangeProvider.darkTheme?Icons.mode_night:Icons.sunny;
                  },
                  icon: Icon(
                      widget.iconData
                  ),
                )
            ),
          ],
        ),
        body: Container());
  }
}