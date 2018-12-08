import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/loginModel.dart';
import '../session/singleton.dart';
import '../utils/config.dart' as c;
import '../widgets/dialog.dart';
import '../widgets/checkbox_widget.dart';
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
                radius: 74.0,
               //backgroundColor: Colors.redAccent,
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
                child: Image.asset('assets/images/preciousnobg.png')),
            SizedBox(height: 70.0),
            Column(

              children: <Widget>[
                emailField(),
                passwordField(),
              SizedBox(height:13.0),

                Row(


                  children: <Widget>[
                    checkboxField(),
                    Text('View Password'),
                  ],
                ),
                SizedBox(height:10.0),

                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getLogin(loginmodel.user, loginmodel.password, context);
                        },
                      ),
                    ),
                    FlatButton(
                      child: Text("Forgot your Password?"),
                      onPressed: (){},

                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: ButtonTheme(
                          minWidth: 120.0,
                          height: 25.0,
                          child: FlatButton(
                            //color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: Text(
                              'Create New Account here',
                              style: TextStyle(color: Colors.black),
                              textScaleFactor: 1.0,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                          ),
                        )


                    ),

                  ],
                )

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
              child: renderCekbox(value: loginmodel.Viewpassword,onChanged: (value){

                loginmodel.changeObscure(value);
              },)
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

Future<String> getSearch() async {
  List categories = List<String>();
  categories.add("1");

  Map map = {
    'query': "green red",
    'categories': ['1,2,3']
  };
  Map<String, dynamic> body = new Map<String, dynamic>();
  body['query'] = "green red";
  body['categories'] = categories;
  var jsonbody = jsonEncode(body);
  print(jsonbody);
  var response = await http
      .post(Uri.encodeFull(c.base_url + "search"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonbody)
      .then((http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);

    print(result['data']);
  });
}

Future<String> getLogin(
    String username, String password, BuildContext context) async {
  Dialogs d = new Dialogs();

  var response =
      await http.post(Uri.encodeFull(c.base_url + "/user"), headers: {
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

      if (result['exit'] == false) {
        String id = result['data']['id'].toString();

        session.setUID(id);
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
      } else {
        d.information(context, "Login Failed", result['message']);
      }
    }
  });
}
