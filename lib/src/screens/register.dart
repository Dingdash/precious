import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/config.dart' as c;

class RegisterForm extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();

}

class RegisterPage extends State<RegisterForm> {
  final textfield1 = TextEditingController();
  final textfield2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    textfield1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('REGISTER'),),
      body: Form(
        key:_formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'enter a new username'),

            ),
            TextFormField(
              decoration: InputDecoration(hintText:'enter a new password'),
            )
          ],
        ),
      ),

    );
  }
  void submitRegister()
  {

  }

}