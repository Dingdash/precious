import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../session/singleton.dart';

class PersonalInfo extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
        title: 'Personal Information',
        home: Scaffold(
          body: buildList(context),
          appBar: AppBar(
            title: Center(
              child: Text('Personal Information'),
            ),
          ),
        ));
  }

  Widget buildList(BuildContext context) {
    return ScopedModel<UserModel>(
      model: session,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('First Name'),
            subtitle: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) => Text(
                    (session.getFirstname) == null
                        ? 'Enter First Name'
                        : session.getFirstname,
                    style: TextStyle(color: Colors.blue),
                  ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Surname'),
            subtitle: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) => Text(
                    (session.getLastname) == null
                        ? 'Enter Surname'
                        : session.getLastname,
                    style: TextStyle(color: Colors.blue),
                  ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('User ID'),
            subtitle: Text(session.getUsername),
          ),
          ListTile(
            title: Text('Gender'),
            subtitle: Text(
              session.getGender,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Address'),
            subtitle: Text(
              session.getAddress == null ? 'Enter Address' : session.getAddress,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Post code'),
            subtitle: Text(
              session.getPostcode == null
                  ? 'Enter Post Code'
                  : session.getPostcode,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('City'),
            subtitle: Text(
              session.getCity == null ? 'Enter City' : session.getCity,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
