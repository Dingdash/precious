import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/loginModel.dart';
import '../session/singleton.dart';
import '../states/category_state.dart';
import '../utils/config.dart' as c;
class Login extends StatelessWidget {
  final CategoryModel categorymodel = CategoryModel();

  final myController = TextEditingController();
  final myController2 = TextEditingController();
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
                      children: <Widget>[
                        RaisedButton(
                          child: Text('LOGIN'),
                          onPressed: () {
                            getLogin(loginmodel.user,loginmodel.password,context,categorymodel);
                          },
                        ),
                        RaisedButton(
                          child: Text('REGISTER'),
                          onPressed: () {


                          },
                        ),
                      ],
                    ),
                  ],
                )
              ]),
            ),
          )),
    );
  }

  Widget emailField() {
    return
       ScopedModelDescendant<LoginModel>(
        builder: (context,child,model)=> TextField(

          onChanged: (newValue) {
            loginmodel.changeUser(newValue);
          },
          controller: myController2,
          decoration: InputDecoration(
            filled: true,
            labelText: 'username',
            errorText: loginmodel.errorUser,
          ),
        ),
    ) ;
  }

  Widget checkboxField() {
    return
        ScopedModelDescendant<LoginModel>(builder: (context,child,model)=> Checkbox(
          value: loginmodel.Viewpassword,
          onChanged: (newVal) {
            loginmodel.changeObscure(newVal);
          },
        ),

    );

  }

  Widget passwordField() {
    return ScopedModel<LoginModel>(
      model: loginmodel,
      child: ScopedModelDescendant<LoginModel>(
        builder: (context,child,model)=> TextField(
          controller: myController,
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
      ),
    ) ;
  }



}
Future<String> getLogin(String username, String password , BuildContext context, CategoryModel categorymodel) async {

  var response = await http
      .post(Uri.encodeFull(c.base_url+"precious/user"), headers: {
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
      if(result['exit']==false)
      {

        session.setFirstname(result['data']['first_name']??null);
        session.setLastname(result['data']['last_name']??null);
        session.setUsername(username);
        session.setPassword(password);
        session.setCity(result['data']['city']??null);
        session.setGender(result['data']['gender']??null);
        session.setAddress(result['data']['address']??null);
        session.setTelp(result['data']['telp']??null);
        session.setEmail(result['data']['email']??null);
        session.signIn();
        if(session.loggedin)
        {
          Navigator.of(context).pushNamed('/home');
          // Navigator.of(context).pushReplacementNamed('/personalinfo');
        }

      }
    }
  });
}

