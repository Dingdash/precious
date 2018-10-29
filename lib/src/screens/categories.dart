import 'package:flutter/material.dart';
class Categories extends StatelessWidget{
  List<String> categories = [
    'Prints',
    'Postcard',
    'Mugs',
    'Greeting Card',
    'Notebooks',
    'Framed Prints',
  ];
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Categories')),

        ),
        body:SafeArea(child: CategoriesTile(context)) ,
      )

    );
  }
  Widget  CategoriesTile(BuildContext context){
   return GridView.count(

     crossAxisCount: 2,
     children: categories.map((product){
        return Material(
            color:Colors.red,
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed('/categories/1');
            },
            child: Center(
              child: Text(product)
            ),
          ),
        );
     }).toList(),
   );
  }
}
