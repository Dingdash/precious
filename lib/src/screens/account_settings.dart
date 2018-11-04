import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class AccountSettings extends StatelessWidget {

  Widget build(context) {
    return MaterialApp(
        title: 'Account Settings',
        home: Scaffold(
          body: buildList(context),
          appBar: AppBar(
            title: Center(
              child: Text('Account Settings'),
            ),
          ),
        ));
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
                  builder: (BuildContext) => _buildChangeEmail(context));
            }),
        ListTile(
          title: Text('Change Password'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext) => _buildChangePassword(context));
            }
        ),
        ListTile(
          title: Text('Personal Information'),
        ),
        buildDivider(10.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RawMaterialButton(
                onPressed: null,
                child: Text('LOG OUT'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
              children: <Widget>[
                Checkbox(
                  value: true,
                  onChanged: (resp) {},
                ),
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
                  onPressed: () {
                    Navigator.of(context).pop();
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
              Checkbox(
                value: true,
                onChanged: (resp) {},
              ),
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
                  Navigator.of(context).pop();
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
