import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../screens/products.dart';
import '../screens/search.dart';
import '../states/category_state.dart';
import '../widgets/drawer.dart';

class Categories extends StatelessWidget {
  CategoryModel categorymodel = CategoryModel();
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Categories'),
        ),
        body: SafeArea(
            child: CategoriesTile(context),
          ),
      );
  }
  Widget CategoriesTile(BuildContext context) {
    return  ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) =>
            GridView.count(
              crossAxisCount: 2,
              children: categorymodel.categories.map((product) {
                return Material(
                  color: Colors.red,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).pushReplacementNamed('/home');
                      Navigator.pushNamed(
                          context, '/categories/'+product.name+'/' + product.id.toString());
                    },
                    child: Center(child: Text(product.name)),
                  ),
                );
              }).toList(),
            ),
      );
  }

}
