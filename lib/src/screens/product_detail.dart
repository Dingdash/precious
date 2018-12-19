import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import'package:intl/intl.dart';
import '../models/productDetailModel.dart';
import '../api/CartAPI.dart';
import '../session/singleton.dart';
import '../widgets/dialog.dart';
class ProductDetail extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  CartAPI mycart = new CartAPI(session.getuID);
  static String productid;
  ProductDetailModel model;
  ProductDetail(String id){
    productid = id;
   model = new ProductDetailModel(id);
  }
  final formatCurrency = new NumberFormat.simpleCurrency(locale: "ID",name: "Rp ");
  TextStyle white = new TextStyle(
      inherit: false, color: Colors.white, decorationColor: Colors.white);
  Widget build(BuildContext context) {
    //model.parseFromResponse(productid);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {},),
        ],
        title: Text('Details'),
      ),
      body: ScopedModel<ProductDetailModel>(
        model: model,
        child: ListView(
          children: <Widget>[
            SizedBox(
                height: 300.0,
                child: Carousel(
                  images: [

                    NetworkImage(
                        'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                    NetworkImage(
                        'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                  ],
                  dotSize: 5.0,
                  dotBgColor: Color.fromARGB(0, 255, 255, 255),
                )),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScopedModelDescendant<ProductDetailModel>(
                    builder: (context, child, model) =>
                    model.item.Product_name == null
                        ? Text("")
                        : Text(model.item.Product_name,style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  ScopedModelDescendant<ProductDetailModel>(
                    builder: (context, child, model) =>
                    model.item.Product_description == null
                        ? Text("")
                        : Text(model.item.Product_description),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ScopedModelDescendant<ProductDetailModel>(
                    builder:(context,child,model)=>
                        model.selectedVariant!=null?Text('${formatCurrency.format(int.parse(model.selectedVariant.Specification_price))}'):Text('')
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Variant'),
                  ScopedModelDescendant<ProductDetailModel>(
                    builder: (context, child, model) =>
                    model.item.variant.isEmpty
                        ? Text('is loading ..')
                        : Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                      ),
                      child: DropdownButton<Variant>(
                        hint: Text('Select One'),
                        value: model.selectedVariant,
                        items: model.item.variant.map((value) {
                          return DropdownMenuItem<Variant>(
                            value: value,
                            child: Text(value.Specification_name),
                          );
                        }).toList(),
                        onChanged: (value) {

                          model.ChangeVariant(value);
                        },
                      ),
                    ),
                  ),
                  /* child: model.item.variant.length > 0
                        ? Text('ada')
                        : Text('tidak ada'),*/
                  SizedBox(
                    height: 20.0,
                  ),
                  // TO DO PRINT SPEC
                  buildSpec(),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(125, 17, 14, 1.0),
                    child: Text('Add to wishlist',
                      style: TextStyle(color: Colors.white),),
                    onPressed: () {

                      addtowishlist(context);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(color: Colors.black,
                        child: Text('ADD TO CART',
                          style: TextStyle(color: Colors.white),),
                        onPressed: () {
                        addtocart(context);
                        },),
                    )
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
  addtocart(context){
   mycart.uid = (session.getuID);
   mycart.addtoCart((session.getuID), productid, (model.selectedVariant.Specification_ID)??"as").then((value){
     Dialogs d = new Dialogs();
     d.information(context, "Info", value['message']);

   });
  }
  addtowishlist(context){
    mycart.uid = (session.getuID);
    mycart.addtoWishlist( productid, int.parse(session.getuID)).then((value){
      Dialogs d = new Dialogs();
      d.information(context, "Info", value['message']);

    });
  }
  showSnackBar(String value){
    final snackBar = new SnackBar(content: Text(value),duration: Duration(seconds: 2),);
  }
  Widget buildSpec() {


    return  ScopedModelDescendant<ProductDetailModel>(
        builder: (context, child, model) =>
        model.selectedVariant==null?Text(''):
            Column(
                children:
                    model.selectedVariant.spec==null?Text(""):
                model.selectedVariant.spec.map((spec) {
                  return Row(children:<Widget>[
                    Container(
                      height: 6.0,
                      width: 10.0,
                      decoration: new BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 14.0,
                    ),

                    Expanded(
                      child: spec.value.isEmpty
                          ? Text('loading')
                          : Text(spec.value),
                    ),
                  ],);
                }).toList()
            ));
    //model.selectedVariant.spec.isEmpty? Text('loading')



  }
}
