import 'dart:async';

import 'package:flutter/material.dart';

import '../api/CartAPI.dart';
import '../widgets/drawer.dart';
import 'package:flutter/services.dart';
class FavoriteWidget extends StatefulWidget {
  String val;

  FavoriteWidget(String value) {
    val = value;
  }

  @override
  Cart createState() => Cart(value: val.toString());
}

class Cart extends State<FavoriteWidget> {
  static String uid;
  bool load = true;
  Future<List<CartItems>> cartitems;

  Cart({value}) {
    uid = value;
  }

  @override
  void initState() {
    super.initState();

    cartitems = fetchCarts();
  }

  final CartAPI c = new CartAPI( uid);

  Future<List<CartItems>> fetchCarts() async {

    c.uid = uid;

    List <CartItems> temporari = new List<CartItems>();
    temporari = await c.getCart();
    setState((){
      load=false;
    });
    return temporari;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'),
      ),
      body: load==false?FutureBuilder<List<CartItems>>(
          future: cartitems,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text("tes");
              case ConnectionState.waiting:
                return new Text('loading...');
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else if (snapshot.hasData)
                  //return Text('ada');
                  return CartListView2(context, snapshot);
                else if (!snapshot.hasData)
                  return Center(child: Text("no item in cart"));
            }
          }):Text('loading'),
    );
  }

  Widget CartListView2(BuildContext context, AsyncSnapshot snapshot) {
    double c_width = MediaQuery
        .of(context)
        .size
        .width * 1;
    List<CartItems> values = snapshot.data;

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(left: 10.0, top: 20.0),

              width: c_width,
              child: Row(
                children: <Widget>[
                  SizedBox(
                      height: 150.0,
                      width: 100.0,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/noimage.png',
                        image: "https://www.w3schools.com/w3css/img_lights.jpg",
                        fit: BoxFit.fill,)
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    width: c_width - 140,
                    child: Column(

                      children: <Widget>[
                        Text("GET THIS PRODUCT NAMweeeeeEee",
                          textAlign: TextAlign.left,),
                        Text("GET THIS PRODUCT VARIANT"),
                        SizedBox(height: 10.0),
                        Text("SUBTOTAL PRICE"),

                        SizedBox(height: 20.0),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            RaisedButton(
                                onPressed: () {
                                  c.uid = uid;
                                  _buildchangeQty(
                                      context, int.parse(values[index].qty),
                                      int.parse(
                                          values[index].cartid.toString()));
//                                c.removeitems(values[index].cartid).then((value){
//                                  setState(() {
//                                    cartitems = fetchCarts();
//                                  });
//                                });
                                  // Navigator.of(context).pushNamed("/cart");
                                },
                                child: Text('Change Qty')),
                            SizedBox(width: 10.0,),
                            RaisedButton(
                                onPressed: () {
                                  c.uid = uid;
//                                  c.removeitems(values[index].cartid).then((
//                                      value) {
//                                    setState(() {
//                                      cartitems = fetchCarts();
//
//                                    //  Navigator.of(context).pop();
//                                    });
//                                  });
                                _buildremoveitems(context, values[index].cartid);


                                },
                                child: Text('Remove')),

                          ],
                        ),

                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                    ),
                  )


                ],
              ),

            ),
//            new ListTile(
//
//              leading: new Text(values[index].product_id+ values[index].qty),
//
//              title: new Text("get this product name"),
//              subtitle: new Text("get this product variant"),
//              trailing: RaisedButton(
//                  onPressed: () {
//                    c.uid = uid;
//                    c.removeitems(values[index].cartid).then((value){
//                      setState(() {
//                        cartitems = fetchCarts();
//                      });
//                    });
//                   // Navigator.of(context).pushNamed("/cart");
//                  },
//                  child: Text('remove')),
//            ),
            SizedBox(
                height: 10.0
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  _buildremoveitems(BuildContext context, int cartid) {
    return showDialog(context: context, builder: (BuildContext context) {
      return new AlertDialog(
        title: const Text("confirm remove"),
        content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

         Text("Are you sure you want to remove this from the cart?"),
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

                    c.uid = uid;

                    c.removeitems(cartid).then((value){

                      Future.delayed(Duration(seconds: 5),(){
                        Navigator.of(context).pushReplacementNamed("/cart");
                      });

                    }).whenComplete((){

                    });

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

  _buildchangeQty(BuildContext context, int Qty, int cartid) {
    TextEditingController controller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Change your Quantity'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("quantity: " + Qty.toString()),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(

                    hintText: 'Enter new Quantity',

                  ),
                  inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],
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
                        if (controller.text == "") {
                          Navigator.of(context).pop();
                        } else {
                          c.uid = uid;

                          c
                              .updateCart(cartid, int.parse(controller.text))
                              .then((value) {
                            setState(() {

                              //cartitems = fetchCarts();
                            });
                            Future.delayed(Duration(seconds: 4),(){
                              Navigator.of(context).pushReplacementNamed("/cart");
                            });


                          });
                        }
                      },
                      textColor: Theme
                          .of(context)
                          .primaryColor,
                      child: const Text('Change'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }


}
