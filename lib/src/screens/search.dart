import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  Widget build(BuildContext context) {
    List<String> filtercategories = [
      'All',
      'Prints',
      'Postcard',
      'Mugs',
      'Greeting Card',
      'Notebooks',
      'Framed Prints',
    ];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pop(context);
          }),
          title: TextField(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

              },
            ),
          ],
        ),
        body: Container(
          height: 80.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
            [
              buildChips(filtercategories),
            ]
        ),
        ),
    );
  }
 Widget buildChips(List<String> filter)
  {
        return Container(
          padding: EdgeInsets.only(right: 10.0),
          height: 200.0,
          child: Chip(label: Text(filter[0])),
        );
  }
}
