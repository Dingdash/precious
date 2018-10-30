import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
class ProductDetail extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('details'),),
      body: ListView(

      children: <Widget>[
        SizedBox(
          height: 300.0,
          child: Carousel(
            images:[
              NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
              NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),

            ],
            dotSize: 5.0,
            dotBgColor: Color.fromARGB(0, 255, 255, 255),
          )
      ),
        Container(
          padding: EdgeInsets.all(10.0),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('title name'),
              SizedBox(height: 20.0,),
              Text('Lorem ipsum dolor sit amet, conse Lorem ipsum dolor sit amet, conse Lorem ipsum dolor sit amet, conse'),
              SizedBox(height: 20.0,),
              Text('Rp 200.000'),
              SizedBox(height: 20.0,),
              Text('Variant'),

              Container(
               child: DropdownButton<int>(
                 isExpanded: true,
                  value: 0,
                  items:new List<DropdownMenuItem<int>>.generate(
                    50,
                        (int index) => new DropdownMenuItem<int>(
                      value: index,
                      child: new Text(index.toString()),
                    ),
                  ),
                  onChanged: (int value) {},
                ),
              ),


              SizedBox(height: 20.0,),
              Row(children: <Widget>[

                Container(
                  height:6.0,
                  width: 10.0,
                  decoration: new BoxDecoration(

                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 14.0,),
                Text('specifications'),
              ],),

              Text('specifications'),
              Text('specifications'),
              Text('specifications'),
              SizedBox(height: 20.0,),
              Row(
                children: <Widget>[
                  RaisedButton(child: Text('Add to Cart'),onPressed: (){},),
                  SizedBox(width: 20.0,),
                  RaisedButton(child: Text('Add to Wishlist'),onPressed: (){},)
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
    );
  }
}


