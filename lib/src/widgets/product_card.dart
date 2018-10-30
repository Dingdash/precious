import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  String name;
  String src;
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 50.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           Container(

            padding:  EdgeInsets.all(15.0),

            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Image.network("https://www.w3schools.com/w3css/img_lights.jpg"),
                 Container(
                  height: 8.0,
                ),

                 Text(
                  'Silk Spinners',
                  style:
                   TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),

                 Text(
                  'Lorem ipsum dolor sit amet, conse Lorem ipsum dolor sit amet, conse Lorem ipsum dolor sit amet, conse'
                ),
                 Container(
                   height: 8.0,
                 ),
                 Text('Rp 20.000'),
                RawMaterialButton(child: Text('View Details'),onPressed: (){},),


              ],
            ),
          ),

        ],
      ),
    );
  }

}