import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/config.dart' as c;
import '../widgets/dialog.dart';
import 'package:email_validator/email_validator.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<RegisterForm> {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();
  final emailField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailField.dispose();
    passwordField.dispose();
    usernameField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'enter email'),
                controller: emailField,
                validator: (val) => emailValidator(val),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'enter a new username'),
                controller: usernameField,
                validator: (val) => usernameValidator(val),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'enter a new password'),
                obscureText: true,
                controller: passwordField,
                validator: (val) => passwordValidator(val),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Buttonregister(),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget Buttonregister (){
    return
      ButtonTheme(
        minWidth: 120.0,
        height: 45.0,
        child: RaisedButton(
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            elevation: 5.0,
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: submitRegister,
        ),
      );
  }
  passwordValidator(String val) {
    if (val.length < 6) {
      return "Password must be at least 6 characters";
    } else {
      return null;
    }
  }

  usernameValidator(String val) {
    if (val.length < 6) {
      return "Username must be at least 6 characters";
    } else {
      return null;
    }
  }

  emailValidator(String value) {
     String email = value;
    final bool isValid = EmailValidator.validate(email);
    if(isValid)
      {
        return null;
      }else
        {
          return 'Enter a valid email';
        }
    print('Email is valid? ' + (isValid ? 'yes' : 'no'));
//    final bool isValid = EmailValidator.validate(value);
//    if(isValid){
//      return null;
//    }else
//      {
//        'Enter a valid email';
//      }

  }

  void submitRegister() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

     register(usernameField.text, passwordField.text, emailField.text);
    }
  }

  Future<String> register(

      String username, String password, String email) async {
    Dialogs d = new Dialogs();
    var url = c.base_url + "/user/createuser";
    String string;

    Map<String, String> headers = Map<String, String>();
    headers['Accept'] = "application/json";
    Map<String, String> body = Map<String, String>();
    body['username'] = username;
    body['password'] = password;
    body['email'] = email;
    var resp = await http
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: 6), onTimeout: () {
      d.information(context, "Info", "request timedout");
    }).catchError((e) {
      print(e.toString());
    }).then((http.Response response) {
      JsonDecoder decoder = new JsonDecoder();
      String json = response.body;
      if (json == null) {
        return;
      } else {
        JsonDecoder decoder = new JsonDecoder();
        dynamic result = decoder.convert(json);
        if(result['message']!=null)
          {
            d.information(context, "Info", result['message']);
          }
      }
    });


    return string;
  }
}
