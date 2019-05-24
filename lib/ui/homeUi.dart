import 'package:flutter/material.dart';
import '../model/userDB.dart';

class HomeUi extends StatefulWidget{
  final Account _account;
  HomeUi(this._account);

  @override
  State<StatefulWidget> createState() {
    return HomeScreen();
  }
}

class HomeScreen extends State<HomeUi>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: <Widget>[
          Text(widget._account.name)
        ],
      ),
    );
  }

}