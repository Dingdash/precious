import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/productDetailModel.dart';

class ProductDetail extends StatelessWidget {
  ProductDetailModel model = new ProductDetailModel();
  TextStyle white = new TextStyle(
      inherit: false, color: Colors.white, decorationColor: Colors.white);

  Widget build(BuildContext context) {
    model.parseFromResponse(1);
    return Scaffold(

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
                        ? Text('is loading')
                        : Text(model.item.Product_name),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                      'Lorem ipsum dolor sit amet, conse Lorem ipsum dolor sit amet, conse Lorem ipsum dolor sit amet, conse'),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Rp 200.000'),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Variant'),
                  ScopedModelDescendant<ProductDetailModel>(
                    builder: (context, child, model) =>
                    model.item.variant.length < 1
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
                    onPressed: () {},
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
                        onPressed: () {},),
                    )


                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildSpec() {


    return  ScopedModelDescendant<ProductDetailModel>(
        builder: (context, child, model) =>
        model.selectedVariant==null?Text('IS LOADING'):
            Column(
                children:
                    model.selectedVariant.spec==null?Text("LOADING"):
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


    /* Row(
                          children: <Widget>[

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
                              child: model.selectedspec.isEmpty
                                  ? Text('loading')
                                  : Text(model.selectedspec[0].value+"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"),
                            ),
                          ],
                        ),*/


  }
}
