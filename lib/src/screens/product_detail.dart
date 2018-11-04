import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/productDetailModel.dart';

class ProductDetail extends StatelessWidget {
  ProductDetailModel model = new ProductDetailModel();
  Widget build(BuildContext context) {

    model.parseFromResponse(1);

    return Scaffold(
      appBar: AppBar(
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
                mainAxisSize: MainAxisSize.min,
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
                            : DropdownButton<Variant>(
                                value: model.selectedVariant ??
                                    model.item.variant[0],
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
                  /* child: model.item.variant.length > 0
                        ? Text('ada')
                        : Text('tidak ada'),*/

                  SizedBox(
                    height: 20.0,
                  ),
                  ScopedModelDescendant<ProductDetailModel>(
                    builder: (context, child, model) => Row(
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
                            model.selectedspec.isEmpty?Text('loading'):Text(model.selectedspec[0].name),
                          ],
                        ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Add to Cart'),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RaisedButton(
                        child: Text('Add to Wishlist'),
                        onPressed: () {},
                      )
                    ],
                  ),
                  /*TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'qty',
                      //errorText: loginmodel.errorPass,

                    ),
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildVariant() {}
}
