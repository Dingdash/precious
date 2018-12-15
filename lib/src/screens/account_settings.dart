import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/drawer.dart';
import 'package:scoped_model/scoped_model.dart';
import '../session/singleton.dart';
import '../../main.dart';
import '../models/loginModel.dart';
import '../api/UserAPI.dart';
import '../widgets/checkbox_widget.dart';
import '../widgets/dialog.dart';
import 'package:email_validator/email_validator.dart';
class AccountSetting extends StatefulWidget{
  @override
  AccountSettings createState() => AccountSettings();
}
class AccountSettings extends State<AccountSetting> {

Dialogs d = new Dialogs();
  UserAPI api = UserAPI();
  Widget build(context) {
    return ScopedModel<UserModel>(
      model: session,
      child: Scaffold(
            body: buildList(context),
            drawer: myDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: Text('Account Settings'),
            ),
          ),
    );
  }

  Widget buildList(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        ScopedModelDescendant<UserModel>(


          builder: (builder,child,context)=>
              ListTile(
                title: Text(session.getUsername),
                subtitle: Text("${session.getEmail} \n"),
                onTap: () {},
              ),
        ),

        buildDivider(10.0),
        ScopedModelDescendant<UserModel>(


          builder: (builder,child,ctx)=>
              ListTile(
                title: Text('Change your email address'),
                onTap: (){
//                  session.setEmail("youglh@ewew.com");
//                  session.notifyListeners();
                  showDialog(
                  context: context,
                  builder: (_) => _buildChangeEmail(context));
//            }
                },
//            onTap: () {
//              showDialog(
//                  context: context,
//                  builder: (_) => _buildChangeEmail(context));
//            }
              ),
        ),

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
    TextEditingController oldpass = new TextEditingController();
    TextEditingController newpass = new TextEditingController();
    TextEditingController confirmpass = new TextEditingController();
    return AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Old password'),
              controller: oldpass,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'New password'),
              controller: newpass,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password Confirmation'),
              controller: confirmpass,
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
                    if(oldpass.text != session.getPassword){

                      oldpass.clear();
                      newpass.clear();
                      confirmpass.clear();
                      d.information(context, "Info","please insert your old password correctly");
                    }else if (confirmpass.text!= newpass.text)
                      {
                        d.information(context, "Info", "Confirmpassword and new password must have the same value");


                      }else if(confirmpass.text.length<6)
                        {
                          d.information(context, "Info", "password should be more than 6 characters");


                        }else
                          {
                            await  api.changePassword(oldpass.text, newpass.text,loginmodel.user).then((value){if(value['exit']==false){
                              Navigator.of(context).pop();
                              d.information(context, "Info", value['message']);
                              session.setPassword(newpass.text);
                            }else if (value=="timedout")
                            {
                              // timedout
                            }
                            });
                          }

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
    TextEditingController oldpass = new TextEditingController();
    TextEditingController newemail = new TextEditingController();
    TextEditingController confirmemail = new TextEditingController();
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
            controller: oldpass,
          ),
          Row(
            children: <Widget>[

            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'New Email',

              //errorText: 'enter valid email',
            ),
            controller: newemail,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Email Confirmation',

              //errorText: 'enter valid email',
            ),
            controller: confirmemail,
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
                  if(oldpass.text != session.getPassword)
                    {
                      d.information(context, "info", "Please insert your old password on passwordfield correctly");
                    }else if(newemail.text.isEmpty){
                    d.information(context, "info", "Please enter a valid email");

                  }else if(newemail.text !=confirmemail.text)
                    {
                      d.information(context, "info", "Confirm Email and New Email must have the same value");
                    }
                  else if(EmailValidator.validate(newemail.text)){

                    api.changeEmail(newemail.text,session.getUsername).then((value){
                      print(value);
                      if(value['exit']==false)
                        {
                          d.information(context, "Info", value['message']);
                          session.setEmail(newemail.text);
                          Navigator.of(context).pop();

                        }

                    });
                  }else
                    {
                      d.information(context, "info", "Please enter a valid email");
                    }
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

