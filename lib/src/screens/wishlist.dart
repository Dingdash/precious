import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/drawer.dart';
import '../models/wishlistModel.dart';
class Wishlist extends StatelessWidget{
String name='tes';
wishlistModel model =  wishlistModel();

  Widget build(BuildContext context){
    model.parseFromResponse();
    return Scaffold(
      drawer: myDrawer(),

        appBar: AppBar(

          centerTitle: true,
          title: Text('My wishlist'),

        ),
      body: ScopedModel(
        model: model,
        child: ScopedModelDescendant<wishlistModel>(
        builder: (context, child, model) => ListTile(
          title: model.wishlist.length<1?Text('is loading..'):Text(model.wishlist[0].Product_name),
          onTap: (){
            Navigator.of(context).pushNamed('/products/'+model.wishlist[0].Product_ID);
          },
        ),),
      ),
    );
  }

}
class ProductTile{
    String name;

}