import 'package:flutter/material.dart';
import 'package:kgpapp/APIConnectors/APIConnector.dart';
import 'package:kgpapp/Util/SharedDataUtil.dart';

class BusinessCard extends StatelessWidget{
  const BusinessCard( {super.key} );

  @override
  Widget build(BuildContext context) {
    if(SharedDataUtil.user==null) {
      return Container();
    }
    User user = SharedDataUtil.user ?? User( id: '', name: '', surname: '', companyName: '');
    return Text(user.companyName);
  }

}