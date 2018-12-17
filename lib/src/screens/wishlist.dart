import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/wishlistModel.dart';
import '../widgets/drawer.dart';
import '../session/singleton.dart';
class Wishlist extends StatelessWidget {
  String name = 'tes';
  wishlistModel model = wishlistModel();

  Widget build(BuildContext context) {

    model.parseFromResponse(session.getuID);
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Wishlist'),
      ),
      body: ScopedModel(
        model: model,
        child: ScopedModelDescendant<wishlistModel>(
          builder: (context, child, model) =>
              model.wishlist.length<1?
              Container()
             :
            ListView.builder(itemBuilder: (context,index){
              return ListTile(
                title: model.wishlist.length < 1
                    ? Text('is loading..')
                    : Text(model.wishlist[0].Product_name),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/products/' + model.wishlist[0].Product_ID);
                },
                trailing: RaisedButton(
                    onPressed: () {
                      // c.uid = uid;
                      _buildremoveitems(context,model.wishlist[0].Wishlist_ID);
                    },
                    child: Text('Remove')),
              );
            },itemCount: model.wishlist.length,)
        ),
      ),
    );
  }
  _buildremoveitems(BuildContext context,String wishlistid) {
    return showDialog(context: context, builder: (BuildContext context) {
      return new AlertDialog(
        title: const Text("confirm remove"),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text("Are you sure you want to remove this from the wishlist?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                FlatButton(
                  onPressed: () {
                  model.removewishlist(wishlistid);
                  Navigator.of(context).pop();
                  },
                  textColor: Theme
                      .of(context)
                      .primaryColor,
                  child: const Text('Yes'),
                ),
              ],
            ),
          ],
        ),);
    });
  }
}


class ProductTile {
  String name;
}
