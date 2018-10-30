import 'dart:async';
import 'dart:convert';
import '../models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/loginModel.dart';
import '../session/singleton.dart';
import '../utils/config.dart' as global;
class Login extends StatelessWidget {
  final LoginModel loginmodel = LoginModel();

  Widget build(BuildContext context) {
    return Scaffold(
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
                      getLogin(loginmodel.user,loginmodel.password,context);

                    },
                  ),
                  RaisedButton(
                    child: Text('REGISTER'),
                    onPressed: () {

                      test();
                    },
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    ));
  }

  Widget emailField() {
    return ScopedModel<LoginModel>(
      model: loginmodel,
      child: ScopedModelDescendant<LoginModel>(
        builder: (context,child,model)=> TextField(
          onChanged: (newValue) {
            loginmodel.changeUser(newValue);
          },
          decoration: InputDecoration(
            filled: true,
            labelText: 'username',
            errorText: loginmodel.errorUser,
          ),
        ),
      ),
    ) ;
  }

  Widget checkboxField() {
    return ScopedModel<LoginModel>(
      model: loginmodel,
      child: ScopedModelDescendant<LoginModel>(builder: (context,child,model)=> Checkbox(
        value: loginmodel.Viewpassword,
        onChanged: (newVal) {
            loginmodel.changeObscure(newVal);
        },
       )
    )
    );

  }

  Widget passwordField() {
    return ScopedModel<LoginModel>(
      model: loginmodel,
      child: ScopedModelDescendant<LoginModel>(
        builder: (context,child,model)=> TextField(
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

  void test()
  {
    var jsonStr = """
  {
    "data": [
        {
            "Product_ID": "1",
            "Category_ID": "3",
            "Product_name": "Otamatone Glass",
            "Product_cover": "",
            "Additional_product_cover": "",
            "Product_insert_at": "2018-10-26 14:32:59",
            "Product_deleted_at": "2018-10-26 14:32:59",
            "Product_description": "",
            "created_at": "2018-10-26 23:28:00",
            "updated_at": "2018-10-26 23:28:13",
            "variant": [
                {
                    "Product_ID": "1",
                    "Specification_ID": "1",
                    "Specification_name": "LARGE",
                    "Specification_price": "20000",
                    "created_at": "2018-10-27 00:05:45",
                    "updated_at": "2018-10-27 00:05:45",
                    "Specifications": [
                        {
                            "Specification_ID": "1",
                            "name": "width",
                            "value": "10 CM",
                            "created_at": "2018-10-27 00:32:21",
                            "updated_at": "2018-10-27 00:32:21"
                        },
                        {
                            "Specification_ID": "1",
                            "name": "height",
                            "value": "18 CM",
                            "created_at": "2018-10-27 00:32:29",
                            "updated_at": "2018-10-27 00:32:29"
                        }
                    ]
                },
                {
                    "Product_ID": "1",
                    "Specification_ID": "2",
                    "Specification_name": "MEDIUM",
                    "Specification_price": "10000",
                    "created_at": "2018-10-27 00:05:45",
                    "updated_at": "2018-10-27 00:05:45",
                    "Specifications": []
                },
                {
                    "Product_ID": "1",
                    "Specification_ID": "2",
                    "Specification_name": "SMALL",
                    "Specification_price": "1000",
                    "created_at": "2018-10-27 00:05:45",
                    "updated_at": "2018-10-27 00:05:45",
                    "Specifications": []
                }
            ]
        }
    ],
    "exit": false,
    "message": "data retrieved"
}
  """;
    var result = json.decode(jsonStr);
   var  products =ProductsModel.fromJson(result['data'][0]);
   print(products.variant[0].specifications[1].value);

  }
  Future<String> getLogin(String username, String password , BuildContext context) async {

    var response = await http
        .post(Uri.encodeFull("http://localhost/precious/user"), headers: {
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
        print('Response: ${result['data']}');
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
                Navigator.of(context).pushReplacementNamed('/home');
                //Navigator.of(context).pushReplacementNamed('/personalinfo');
              }

          }
      }
    });
  }
}
