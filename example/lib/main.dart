import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:matrix_plugin/matrix_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            TextButton(
              onPressed: () async {
                var resposne =
                    await MatrixPlugin.initWithHomeServer("https://matrix.org");
                print("Init resposne >>> $resposne");
              },
              child: Text("Init Home Server"),
            ),
            TextButton(
              onPressed: () async {
                var response = MatrixPlugin.loginWithTypeUsernamePwd(
                    "james668", "646724452");
                print("Login resposne >>> $response");
              },
              child: Text("Login james668"),
            ),
            TextButton(
              onPressed: () async {
                var response = MatrixPlugin.getRegisterSession();
                print("getRegisterSession resposne >>> $response");
              },
              child: Text("getRegisterSession"),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                decoration: InputDecoration(hintText: "Register Name"),
                controller: _usernameController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                decoration: InputDecoration(hintText: "Register Password"),
                controller: _pwdController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                registerAction();
              },
              child: Text("register"),
            ),
          ],
        ),
      ),
    );
  }

  registerAction() async {
    var username = _usernameController.text;
    var pwd = _pwdController.text;

    var available = await MatrixPlugin.isUsernameAvailable(username);

    print("available >>> $available");
    var register =
        await MatrixPlugin.registerWithLoginTypeUsernamePwd(username, pwd);

    print("register >>> $register");
  }
}
