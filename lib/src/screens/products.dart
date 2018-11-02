import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../widgets/product_card.dart';
class Products extends StatelessWidget {
  int categories;
  String categoryname;

  Products({this.categories, this.categoryname});

  ProductScopedModel model = new ProductScopedModel();

  Widget build(BuildContext context) {
    model.parseProductsFromResponse(categories, 0);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryname),
        leading: FlatButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              model._productsList.clear();
              model.pageindex = 0;
              model.currentProductCount = 0;
              model.parseProductsFromResponse(categories, 0);
            },
          )
        ],
      ),
      body: ScopedModel<ProductScopedModel>(
        model: model,
        child: ScopedModelDescendant<ProductScopedModel>(
            builder: (context, child, model) => ListView.builder(
                itemCount: model.getProductsCount(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == model.getProductsCount() - 1) {
                    print(index);
                    if (model.getProductsCount() < model.total) {
                      model.pageindex++;

                      model.parseProductsFromResponse(
                          categories, model.pageindex);
                    }
                  }
                  return buildSingleProduct(
                    model.productsList[index].name,
                    model.productsList[index].id,
                  );
                })),
      ),
    );
  }


  buildSingleProduct(String name,String id)
  {
    ProductCard card = ProductCard();
    card.name = name;
    card.id = id;
    return card;
  }
}

class Product {
  String id;
  String name;

  Product({this.id, this.name});
}

class ProductScopedModel extends Model {
  int pageindex = 0;
  List<Product> _productsList = [];
  int currentProductCount = 0;

  List<Product> get productsList => _productsList;

  int total = 0;

  void addToProductsList(Product product) {
    _productsList.add(product);
  }

  int getProductsCount() {
    if (!_productsList.isEmpty) {
      return _productsList.length;
    } else {
      return 0;
    }
  }

  Future<dynamic> _getProductsByCategory(categoryId, pageIndex) async {
    //logic for fetching remote data
    var response = await http
        .get(
            'http://localhost/precious/products/all/$categoryId?page=$pageIndex')
        .catchError((error) {
      return false;
    });
    var data = json.decode(response.body);

    total = data['total'];

    return json.decode(response.body);
  }

  Future parseProductsFromResponse(int categoryId, int pageIndex) async {
    var dataFromResponse = await _getProductsByCategory(categoryId, pageIndex);

    dataFromResponse = dataFromResponse['data'] as List;

    dataFromResponse.forEach((newProduct) {
      //parse new product's details
      Product product = new Product(
        id: newProduct["id"],
        name: newProduct["name"],
      );
      currentProductCount += 1;

      addToProductsList(product);
    });

    //print(currentProductCount);

    notifyListeners();
  }
}
