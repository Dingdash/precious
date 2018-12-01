import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/drawer.dart';
import 'package:scoped_model/scoped_model.dart';
import '../session/singleton.dart';
import '../../main.dart';
import '../models/loginModel.dart';
import '../api/UserAPI.dart';
import '../widgets/checkbox_widget.dart';
class AccountSettings extends StatelessWidget {


  UserAPI api = UserAPI();
  Widget build(context) {
    return Scaffold(
          body: buildList(context),
          drawer: myDrawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Account Settings'),
          ),
        );
  }

  Widget buildList(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        ListTile(
          title: Text('username'),
          subtitle: Text('youglh@example.com\nMale\nUser ID:2472378'),
          onTap: () {},
        ),
        buildDivider(10.0),
        ListTile(
            title: Text('Change your email address'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => _buildChangeEmail(context));
            }),
        ListTile(
          title: Text('Change Password'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => _buildChangePassword(context));
            }
        ),
        ListTile(
          title: Text('Personal Information'),
          onTap:(){
            Navigator.of(context).pushNamed('/Personalinfo');
          }
        ),
        buildDivider(10.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RawMaterialButton(
                onPressed: (){
                    session.logOut();
                    if(session.loggedin==false)
                      {
                        print(session.getEmail);
                        print(session.getFirstname);
                        loginmodel.clearData();
                        RestartWidget.restartApp(context);
                      }

                },
                child: Text('LOG OUT',style:TextStyle(color: Colors.white)),
                fillColor: Colors.red,

              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDivider(double height) {
    return Divider(
      height: height,
      color: Colors.grey,
    );
  }

  Widget _buildChangePassword(BuildContext context) {
    return AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Old password'),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'New password'),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password Confirmation'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                renderCekbox(value:false,onChanged: (value){
                  print(value);
                },),

                Text('View Password'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    child: Text('cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                FlatButton(
                  onPressed: () async{
                 await  api.changePassword("haha", "hehe").then((value){if(value['exit']==false){
                  print(value['message']);
                 }else if (value=="timedout")
                   {
                     // timedout
                   }
                 });
                  },
                  textColor: Theme.of(context).primaryColor,
                  child: const Text('Change'),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildChangeEmail(BuildContext context) {

    return new AlertDialog(
      title: const Text('Change your email address'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password',

              //errorText: 'enter valid email',
            ),
          ),
          Row(
            children: <Widget>[

              renderCekbox(value: false,onChanged: (value){

              },),
              Text('View Password'),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'New Email',

              //errorText: 'enter valid email',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Email Confirmation',

              //errorText: 'enter valid email',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  child: Text('cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                },
                textColor: Theme.of(context).primaryColor,
                child: const Text('Change'),
              ),
            ],
          ),
        ],
      ),
    );
  }


}

