import 'package:flutter/material.dart';
import '../session/singleton.dart';
class myDrawer extends StatelessWidget {
  int wishes = 0;


  Widget build(BuildContext context) {
    return Drawer(

        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Text(
                  session.getAvatarName(),
                  textScaleFactor: 2.0,
                ),
                radius: 50.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(session.getEmail),
            ],
          ),
          decoration: BoxDecoration(),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
          Navigator.of(context).pushReplacementNamed('/home');

          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text("Search"),
          onTap: () {
            Navigator.of(context).pushNamed('/search');
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Cart"),
          onTap: () {

          },
        ),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Wishlist'),
          onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/wishlist');

          },
        ),
        Divider(
          height: 10.0,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Account Settings'),
        ),
        ListTile(
          leading: Icon(Icons.stars),
          title: Text('Rate us'),
        )
      ],
    ));
  }
}
