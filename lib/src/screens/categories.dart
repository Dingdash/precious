import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../utils/config.dart' as c;
class Categories extends StatelessWidget{
  List<String> categories = [
    'Prints',
    'Postcard',
    'Mugs',
    'Greeting Card',
    'Notebooks',
    'Framed Prints',
  ];


  Future<String> getCategoriesfromAPI(){
    print(c.base_url);


}
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Home',
      home: Scaffold(

        drawer: myDrawer(),
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
              Navigator.pushNamed(context,'/categories/1');

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
