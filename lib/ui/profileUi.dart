import 'package:flutter/material.dart';
import '../model/share.dart';
import '../model/userDB.dart';
import './homeUi.dart';

class ProfileUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreen();
  }
}

class ProfileScreen extends State<ProfileUi> {
  final _formKey = GlobalKey<FormState>();
  TodoProvider userdb = TodoProvider();
  static String quote;
  static Account _account;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController quotefield = TextEditingController();

  void initState() {
    super.initState();
    this.userdb.open();
    print("testfuckyou");
    SharedPreferencesUtil.loadLastLogin().then((value) async {
      await userdb.open();
      await userdb.getAccountByUserId(value).then((values) {
        setState(() {
          _account = values;
          username.text = _account.userid;
          password.text = _account.password;
          name.text = _account.name;
          age.text = _account.age.toString();
        });
      });
    });
    SharedPreferencesUtil.loadQuote().then((value) {
      setState(() {
        ProfileScreen.quote = value;
        quotefield.text = quote;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("PROFILE"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "UserId",
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                    labelText: "Age",
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                TextFormField(
                  controller: quotefield,
                  decoration: InputDecoration(
                    labelText: "Quote",
                    icon: Icon(Icons.account_circle),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("SAVE"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await userdb.open();
                            await userdb.update(Account(
                                id: _account.id,
                                userid: username.text,
                                name: name.text,
                                age: int.parse(age.text),
                                password: password.text));

                            _account.userid = username.text;
                            _account.name = name.text;
                            _account.age = int.parse(age.text);
                            _account.password = password.text;

                            await SharedPreferencesUtil.saveQuote(
                                quotefield.text);
                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => HomeUi(_account)),
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("BACK"),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => HomeUi(_account)),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
