import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ProductCard extends StatelessWidget {
  String name;
  String src;
  String id;
  String price;
  String cover;
  String description;

  final formatCurrency = new NumberFormat.simpleCurrency(locale: "ID",name: "Rp ");


  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 50.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 400,
                    height: 200,
                    child: SizedBox.expand(
                      child: FadeInImage.assetNetwork(placeholder:  'assets/images/noimage.jpg', image: "http://preciousx.store/images/"+cover??"https://www.w3schools.com/w3css/img_lights.jpg",fit: BoxFit.fitHeight,)
//                    child: Image(
//                      image: NetworkImage(
//                          "https://www.w3schools.com/w3css/img_lights.jpg"),
//                      fit: BoxFit.fill,
//                    ),
                    ),
                  ),
                ),
               // Image.network("https://www.w3schools.com/w3css/img_lights.jpg"),
                Container(
                  height: 8.0,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                    description,overflow: TextOverflow.ellipsis,maxLines: 3,),
                Container(
                  height: 8.0,
                ),

                Text('${formatCurrency.format(int.parse(price))}'),
                RawMaterialButton(
                  child: Text('View Details'),
                  onPressed: () {
                      String products = "/products/P0001";
                      var arr = products.split('/');

                      final productid = arr[2];

                    Navigator.of(context).pushNamed('/products/'+id);
                    //Navigator.of(context).pushNamed('/products/'+id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
