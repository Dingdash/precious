import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../session/singleton.dart';
import '../api/UserAPI.dart';
import '../widgets/dialog.dart';
import 'package:flutter/services.dart';
class PinfoState extends StatefulWidget {
  @override
  PersonalInfo createState() => PersonalInfo();
}

class PersonalInfo extends State<PinfoState> {
  Dialogs d = new Dialogs();
  UserAPI api = UserAPI();
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
            onTap: () {

              showDialog(
                  context: context,
                  builder: (_) => _buildFirstname(context));
              },
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
    TextEditingController firstname= new TextEditingController();
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
            controller: firstname,
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
                  if(firstname.text.isEmpty)
                  {
                    d.information(context, "Info", "Field required");

                  }else
                  {
                    api.changeFirstName(firstname.text,session.getUsername).then((value){

                      if(value['exit']==false)
                      {


                         session.setFirstname(firstname.text);
                        Navigator.of(context).pop();
                        d.information(context, "Info", value['message']);

                      }

                    });
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

  _buildSurname(BuildContext context) {
    TextEditingController lastname = new TextEditingController();
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
                  controller: lastname,
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
                        if(lastname.text.isNotEmpty)
                          {
                            api.changeSurName(lastname.text, session.getUsername).then((value){
                              Navigator.of(context).pop();
                              if(value['exit']==false)
                              {
                                session.setLastname(lastname.text);
                                d.information(context, "Info", value['message']);
                              }
                            });
                          }else
                            {
                              d.information(context, "Info", "Field required");
                            }

                        print(lastname.text);
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
    TextEditingController address = new TextEditingController();
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
                  controller: address,
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
                        if(address.text.isEmpty)
                          {
                            d.information(context, "Info", "Field required");
                          }else
                            {
                              api.changeAddress(address.text, session.getUsername).then((value){
                                  if(value['exit']==false)
                                    {

                                      session.setAddress(value['data']['address']);
                                      Navigator.of(context).pop();
                                      d.information(context, "Info", value['message']);
                                    }
                              });
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
    TextEditingController postcode = new TextEditingController();
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
                  inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],
                  controller: postcode,
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
                        if(postcode.text.isEmpty)
                          {
                            d.information(context, "Info", "Field is required");

                          }else
                            {

                              api.changePostCode(postcode.text, session.getUsername).then((value){
                                  session.setPostcode(value['data']['postcode']);

                                  Navigator.of(context).pop();
                              });
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
        });
  }

  _buildCity(BuildContext context) {
    TextEditingController city = new TextEditingController();
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
                      hintText: 'Enter new City',
                    ),
                    controller:  city,
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
                          if(city.text.isEmpty)
                            {
                              Navigator.of(context).pop();
                              d.information(context, "Info", "Field is required");

                            }else
                              {
                                api.changeCity(city.text, session.getUsername).then((value){
                                      session.setCity(value['data']['city']);
                                      Navigator.of(context).pop();
                                      d.information(context, "Info", value['message']);
                                });
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
            ),
          );
        });
  }
}


