import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../model/state.dart';
import '../model/userDB.dart';

import './home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreen();
  }
}

class LoginScreen extends State<LoginPage> {
  final color = const Color(0xffb71c1c);

  final _formKey = GlobalKey<FormState>();
  final user_check = TextEditingController();
  final password_check = TextEditingController();

  UserProvider user = UserProvider();

  bool isValid = false;
  int formState = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
              children: <Widget>[
                Image.asset(
                  "resource/PRIT8616.JPG",
                  height: 200,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "User ID",
                      icon: Icon(Icons.account_box),
                    ),
                    controller: user_check,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isNotEmpty) {
                        this.formState += 1;
                      }
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "User ID",
                      icon: Icon(Icons.account_box),
                    ),
                    controller: password_check,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isNotEmpty) {
                        this.formState += 1;
                      }
                    }),
                RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    _formKey.currentState.validate();

                    await user.open("user.db");
                    Future<List<User>> allUser = user.getAllUser();

                    Future isUserValid(String userid, String password) async {
                      var userList = await allUser;
                      // print(userList);
                      for (var i = 0; i < userList.length; i++) {
                        if (userid == userList[i].userid &&
                            password == userList[i].password) {
                          CurrentUser.ID = userList[i].id;
                          CurrentUser.USERID = userList[i].userid;
                          CurrentUser.NAME = userList[i].name;
                          CurrentUser.AGE = userList[i].age;
                          CurrentUser.PASSWORD = userList[i].password;
                          CurrentUser.QUOTE = userList[i].quote;
                          this.isValid = true;
                          print("this user valid");
                          break;
                        }
                      }
                    }

                    if (this.formState != 2) {
                      Toast.show("Please fill out this form", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                      this.formState = 0;
                      print(111);
                    } else {
                      print(222);
                      this.formState = 0;
                      print("${user_check.text}, ${password_check.text}");
                      await isUserValid(user_check.text, password_check.text);
                      if (!this.isValid) {
                        print(333);
                        Toast.show("Invalid user or password", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      } else {
                        print(444);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        user_check.text = "";
                        password_check.text = "";
                      }
                    }
                  },
                ),
                FlatButton(
                  child: Container(
                    child:
                        Text("register new user", textAlign: TextAlign.right),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  padding: EdgeInsets.only(left: 150.0),
                ),
              ],
            ),
          )),
    );
  }
}

// Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
