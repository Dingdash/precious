

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import '../api/CartAPI.dart';
import '../models/cartModel.dart';
import '../widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
class Cart extends StatefulWidget {
  String val;
  Cart(String value) {
    val = value;
  }
  @override
  Mycart createState() => Mycart(val.toString());
}
class Mycart extends State<Cart> {
  static String uid;
  int total =  0;
  bool load = true;
  cartModel model = new cartModel(uid);

  Mycart(String uid) {
    uid = uid;
    model.parseFromResponse(uid);
  }

  final CartAPI c = new CartAPI( uid);
  final formatCurrency = new NumberFormat.simpleCurrency(locale: "ID",name: "Rp ");



  Widget build(BuildContext context) {


    double c_width = MediaQuery.of(context).size.width * 1;

    return ScopedModel(
      model: model,
      child: Scaffold(

        drawer: myDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cart'),
        ),
        body: ScopedModelDescendant<cartModel>(
          builder: (context, child, model) => model.cart.length < 1
              ? Center(child:Text("No items in Cart"))
              : ListView.builder(
                  itemCount: model.cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Column(
                      children: <Widget>[
                        index==0?
                        Container(padding: EdgeInsets.only(top:5.0),child:Text("Total\n"+formatCurrency.format(getTotal()).toString(),textScaleFactor: 1.2,textAlign: TextAlign.center,)):Text(''),
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
                                    image:
                                        "https://www.w3schools.com/w3css/img_lights.jpg",
                                    fit: BoxFit.fill,
                                  )),
                              SizedBox(
                                width: 7.0,
                              ),
                              Container(
                                width: c_width - 130,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      model.cart[index].product_name,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(model.cart[index].spec_name),
                                    Text("Qty: ${model.cart[index].qty}"),
                                    Text("Each: ${formatCurrency.format(int.parse(model.cart[index].spec_price))}"),
                                    SizedBox(height: 4.0),
                                    Text('${formatCurrency.format(int.parse(model.cart[index].qty)*int.parse(model.cart[index].spec_price))}'),
                                    SizedBox(height: 3.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          color: Colors.grey,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => _buildchangeQty(context,model.cart[index].qty.toString(), model.cart[index].cartid)
                                              );

                                            },
                                            child: Text('Change Qty',style: TextStyle(color: Colors.white),)),
//                                        SizedBox(
//                                          width: 10.0,
//                                        ),
                                        RaisedButton(
                                          color: Colors.black,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => _buildremoveitems(context, model.cart[index].cartid)
                                              );
                                            },
                                            child: Text('Remove',style: TextStyle(color: Colors.white))),
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
                        SizedBox(height: 10.0),

                        new Divider(
                          height: 2.0,
                          color: Colors.grey,
                        ),
                        index==model.cart.length-1?
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(color: Colors.black,
                                    child: Text('BUY NOW',
                                      style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                    print(getTotal());
                                    Navigator.of(context).pushNamed("/checkout/"+getTotal().toString());
//

                                      // addtocart(context);
                                    },),
                                )
                            ),

                          ],
                        ):SizedBox(height: 0.0,width: 0.0,)

                      ],

                    );
                  },

                ),
        ),
      ),
    );
  }

//  Widget CartListView1(BuildContext context, List<CartItems> s) {
//
//    double c_width = MediaQuery.of(context).size.width * 1;
//    List<CartItems> values = s;
//    return new ListView.builder(
//      itemCount: values.length,
//      itemBuilder: (BuildContext context, int index) {
//        return new Column(
//          children: <Widget>[
//            new Container(
//              padding: EdgeInsets.only(left: 10.0, top: 20.0),
//              width: c_width,
//              child: Row(
//                children: <Widget>[
//                  SizedBox(
//                      height: 150.0,
//                      width: 100.0,
//                      child: FadeInImage.assetNetwork(
//                        placeholder: 'assets/images/noimage.png',
//                        image: "https://www.w3schools.com/w3css/img_lights.jpg",
//                        fit: BoxFit.fill,
//                      )),
//                  SizedBox(
//                    width: 10.0,
//                  ),
//                  Container(
//                    width: c_width - 140,
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          "GET THIS PRODUCT NAMweeeeeEee",
//                          textAlign: TextAlign.left,
//                        ),
//                        Text("GET THIS PRODUCT VARIANT"),
//                        SizedBox(height: 10.0),
//                        Text("SUBTOTAL PRICE"),
//                        SizedBox(height: 20.0),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            RaisedButton(
//                                onPressed: () {
//                                  c.uid = uid;
//                                  _buildchangeQty(
//                                      context,
//                                      int.parse(values[index].qty),
//                                      int.parse(
//                                          values[index].cartid.toString()));
//                                },
//                                child: Text('Change Qty')),
//                            SizedBox(
//                              width: 10.0,
//                            ),
//                            RaisedButton(
//                                onPressed: () {
//                                  c.uid = uid;
//                                  _buildremoveitems(
//                                      context, values[index].cartid);
//                                },
//                                child: Text('Remove')),
//                          ],
//                        ),
//                      ],
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                    ),
//                  )
//                ],
//              ),
//            ),
//            SizedBox(height: 10.0),
//            new Divider(
//              height: 2.0,
//            ),
//          ],
//        );
//      },
//    );
//  }

//  Widget CartListView2(BuildContext context, AsyncSnapshot snapshot) {
//    double c_width = MediaQuery.of(context).size.width * 1;
//    List<CartItems> values = snapshot.data;
//
//    return new ListView.builder(
//      itemCount: values.length,
//      itemBuilder: (BuildContext context, int index) {
//        return new Column(
//          children: <Widget>[
//            new Container(
//              padding: EdgeInsets.only(left: 10.0, top: 20.0),
//              width: c_width,
//              child: Row(
//                children: <Widget>[
//                  SizedBox(
//                      height: 150.0,
//                      width: 100.0,
//                      child: FadeInImage.assetNetwork(
//                        placeholder: 'assets/images/noimage.png',
//                        image: "https://www.w3schools.com/w3css/img_lights.jpg",
//                        fit: BoxFit.fill,
//                      )),
//                  SizedBox(
//                    width: 10.0,
//                  ),
//                  Container(
//                    width: c_width - 140,
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          "GET THIS PRODUCT NAMweeeeeEee",
//                          textAlign: TextAlign.left,
//                        ),
//                        Text("GET THIS PRODUCT VARIANT"),
//                        SizedBox(height: 10.0),
//                        Text("SUBTOTAL PRICE"),
//                        SizedBox(height: 20.0),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            RaisedButton(
//                                onPressed: () {
//
//                                  _buildchangeQty(
//                                      context,
//                                      int.parse(model.cart[index].qty),
//                                      int.parse(
//                                          model.cart[index].cartid.toString()));
//                                },
//                                child: Text('Change Qty')),
//                            SizedBox(
//                              width: 10.0,
//                            ),
//                            RaisedButton(
//                                onPressed: () {
//                                  c.uid = uid;
//                                  _buildremoveitems(
//                                      context, values[index].cartid);
//                                },
//                                child: Text('Remove')),
//                          ],
//                        ),
//                      ],
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                    ),
//                  )
//                ],
//              ),
//            ),
//            SizedBox(height: 10.0),
//            new Divider(
//              height: 2.0,
//            ),
//          ],
//        );
//      },
//    );
//  }

  _buildremoveitems(BuildContext context, int cartid) {

          return new AlertDialog(
            title: const Text("confirm remove"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Are you sure you want to remove this from the cart?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    FlatButton(
                      onPressed: () {
                        model.removeitems(cartid);
                        Navigator.of(context).pop();
//                        c.uid = uid;
//
//                        c.removeitems(cartid).then((value) {
//                          Future.delayed(Duration(seconds: 5), () {
//                            Navigator.of(context).pushReplacementNamed("/cart");
//                          });
//                        }).whenComplete(() {});
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  getTotal()
  {int total = 0;
    if(model.cart.length>0)
      {
        for(int i=0; i<model.cart.length;i++)
          {
            int subtotal = int.parse(model.cart[i].spec_price) * int.parse(model.cart[i].qty);
            total+=subtotal;
          }

      }
      return total;
  }
  Future launchUrl(String url)async{
    if(await canLaunch(url)){
      await launch(url,forceSafariVC: true,forceWebView: true);

    }
  }
  Widget _buildchangeQty(BuildContext context, String Qty, int cartid) {
    TextEditingController controller1 = new TextEditingController();

          return new AlertDialog(
            title: const Text('Change your Quantity'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("quantity: " + Qty.toString()),
                TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    hintText: 'Enter new Quantity',
                  ),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    FlatButton(
                      onPressed: () {
                        if (controller1.text == "") {
                          Navigator.of(context).pop();
                        } else {
                          model.updateCart(cartid, int.parse(controller1.text)).then((value){

                            print(value['message']);
                            if(value['message']!=null)
                              {
                                Navigator.of(context).pop();

                              }

                          });

//                          c.uid = uid;
//
//                          c
//                              .updateCart(cartid, int.parse(controller1.text))
//                              .then((value) {
//                            Future.delayed(Duration(seconds: 4), () {
//                              Navigator.of(context)
//                                  .pushReplacementNamed("/cart");
//                            });
//                          });
                        }
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
