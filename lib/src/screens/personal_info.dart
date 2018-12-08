import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../session/singleton.dart';

class PinfoState extends StatefulWidget {
  @override
  PersonalInfo createState() => PersonalInfo();
}

class PersonalInfo extends State<PinfoState> {
  int radiovalue = 0;
  onChangeradio(int value){
    setState(() {
      print(value);
      radiovalue= value;


    });
  }

  Widget build(context) {
    return Scaffold(
      body: buildList(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Personal Information'),
      ),
    );
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
            onTap: () => _buildFirstname(context),
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
            onTap: () => _buildSurname(context),
          ),
          ListTile(
            title: Text('User ID'),
            subtitle: Text(session.getUsername),
          ),
//          ListTile(
//            title: Text('Gender'),
//            subtitle: ScopedModelDescendant<UserModel>(
//              builder: (context, child, model) => Text(
//                    (session.getGender) == null
//                        ? "Pick a gender"
//                        : session.getGender,
//                    style: TextStyle(color: Colors.blue),
//                  ),
//            ),
//            onTap: () {
//              _buildGender(context);
//            },
//          ),
          ListTile(
            title: Text('Address'),
            subtitle: Text(
              session.getAddress == null ? 'Enter Address' : session.getAddress,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => _buildAddress(context),
          ),
          ListTile(
            title: Text('Post code'),
            subtitle: Text(
              session.getPostcode == null
                  ? 'Enter Post Code'
                  : session.getPostcode,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => _buildPostCode(context),
          ),
          ListTile(
            title: Text('City'),
            subtitle: Text(
              session.getCity == null ? 'Enter City' : session.getCity,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => _buildCity(context),
          )
        ],
      ),
    );
  }

  _buildFirstname(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change your First name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter first name',
                  ),
                  onChanged: (value) {
                    if (value.length > 0) {

                    }
                  },
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
        });
  }

  _buildSurname(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Change your Surname'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Surname',
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
        });
  }

  _buildAddress(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Change your Address'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter new Address',
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
        });
  }

  _buildGender(BuildContext context) {



    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pick a Gender"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Radio(
                  value: 0,
                  groupValue: radiovalue,
                  onChanged: onChangeradio,
                ),
                 Radio(
                  value: 1,
                  groupValue: radiovalue,
                  onChanged: onChangeradio,),
              ],
            ),
          );
        });
  }

  _buildPostCode(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Change your Post Code'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: 'Enter new Post Code',
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
        });
  }

  _buildCity(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Change your City'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter new Post Code',
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
            ),
          );
        });
  }
}


