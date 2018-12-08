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
                    textScaleFactor: 2.8,

                  ),
                  radius: 50.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(session.getEmail,style: drawerTextStyle(),),
              ],
            ),
            //decoration: BoxDecoration(),
          ),
          Divider(
            height: 15.0,
            color: Colors.white10,
          ),
          ListTile(
            leading: buildIcon(Icons.home),
            title: Text("Home",style: drawerTextStyle(),),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          ListTile(
            leading: buildIcon(Icons.search),
            title: Text("Search",style: drawerTextStyle(),),
            onTap: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
          ListTile(
            leading: buildIcon(Icons.shopping_cart),
            title: Text("Cart",style: drawerTextStyle(),),
            onTap: () {

              Navigator.of(context).pushReplacementNamed('/cart');
            },
          ),
          ListTile(
            leading: buildIcon(Icons.card_giftcard),
            title: Text('Wishlist',style: drawerTextStyle(),),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/wishlist');
            },
          ),
          Divider(
            height: 15.0,
            color: Colors.white10,
          ),
          ListTile(
              leading: buildIcon(Icons.settings),
              title: Text('Account Settings',style: drawerTextStyle(),),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/settings');
              }),
          ListTile(
            leading: buildIcon(Icons.stars),
            title: Text('Rate us',style: drawerTextStyle(),),
          )
        ],
      ),
    );
  }
  buildIcon(IconData I)
  {
    Color c =Colors.white70;
    return Icon(I,color: c,);
  }
  TextStyle drawerTextStyle()
  {
    return TextStyle(color: Colors.white);
  }
}
