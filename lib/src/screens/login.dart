import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/loginModel.dart';
import '../session/singleton.dart';
import '../utils/config.dart' as c;

class Login extends StatelessWidget {


  Widget build(BuildContext context) {
    return ScopedModel<LoginModel>(
      model: loginmodel,
      child: Scaffold(
          body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            CircleAvatar(
                radius: 78.0,
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
                child: Image.asset('assets/images/preciousnobg.png')),
            SizedBox(height: 70.0),
            Column(
              children: <Widget>[
                emailField(),
                passwordField(),
                Row(
                  children: <Widget>[
                    checkboxField(),
                    Text('View Password'),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 120.0,
                      height: 45.0,
                      child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                        elevation: 5.0,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getLogin(
                              loginmodel.user, loginmodel.password, context);
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 120.0,
                      height: 45.0,
                      child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                        elevation: 5.0,
                        child: Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      )),
    );
  }

  Widget emailField() {
    return ScopedModelDescendant<LoginModel>(
      builder: (context, child, model) => TextField(
            onChanged: (newValue) {
              loginmodel.changeUser(newValue);
            },
            decoration: InputDecoration(
              filled: true,
              labelText: 'username',
              errorText: loginmodel.errorUser,
            ),
          ),
    );
  }

  Widget checkboxField() {
    return ScopedModelDescendant<LoginModel>(
      builder: (context, child, model) => Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Checkbox(
              activeColor: Colors.redAccent,
              value: loginmodel.Viewpassword,
              onChanged: (newVal) {
                loginmodel.changeObscure(newVal);
              },
            ),
          ),
    );
  }

  Widget passwordField() {
    return ScopedModelDescendant<LoginModel>(
      builder: (context, child, model) => TextField(
            obscureText: !loginmodel.Viewpassword,
            onChanged: (newValue) {
              loginmodel.changePass(newValue);
            },
            decoration: InputDecoration(
              filled: true,
              labelText: 'password',
              errorText: loginmodel.errorPass,
            ),
          ),
    );
  }
}

Future<String> getLogin(
    String username, String password, BuildContext context) async {
  var response =
      await http.post(Uri.encodeFull(c.base_url + "precious/user"), headers: {
    "Accept": "application/json"
  }, body: {
    'username': username,
    'password': password,
  }).then((http.Response response) {
    String json = response.body;
    if (json == null) {
      return;
    } else {
      JsonDecoder decoder = new JsonDecoder();
      dynamic result = decoder.convert(json);
      // print('Response: ${result['data']}');
      if (result['exit'] == false) {
        session.setFirstname(result['data']['first_name'] ?? null);
        session.setLastname(result['data']['last_name'] ?? null);
        session.setUsername(username);
        session.setPassword(password);
        session.setCity(result['data']['city'] ?? null);
        session.setGender(result['data']['gender'] ?? null);
        session.setAddress(result['data']['address'] ?? null);
        session.setTelp(result['data']['telp'] ?? null);
        session.setEmail(result['data']['email'] ?? null);
        session.signIn();
        if (session.loggedin) {
          Navigator.of(context).pushReplacementNamed('/home');
          // Navigator.of(context).pushReplacementNamed('/personalinfo');
        }
      }
    }
  });
}
