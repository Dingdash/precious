import 'dart:async';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../utils/config.dart' as global;

class Products extends StatelessWidget {

  int categories;
  Products({this.categories});
  ProductScopedModel model = new ProductScopedModel();
  int pageindex = 0;
  int total= 0;


  Widget build(BuildContext context) {

    model.parseProductsFromResponse(1, pageindex);
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
          appBar: AppBar(
            title: Text('tes'),
            leading: FlatButton(child:Icon(Icons.arrow_back),onPressed:(){Navigator.pop(context);}) ,
          ),
          body:  ScopedModel<ProductScopedModel>(
            model: model,
            child: ScopedModelDescendant<ProductScopedModel>(

              builder: (context, child, model) {

                return model.isLoading
                    ? _buildCircularProgressIndicator()
                    : _buildListView();
              },
            ),
          ),
        ));
  }
  _buildCircularProgressIndicator() {
    return CircularProgressIndicator();
  }

  _buildListView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: model.getProductsCount() == 0
          ? Center(child: Text('NO PRODUCT AVAILABLE'))
          : ListView.builder(
        itemCount: model.getProductsCount() + 1,
        itemBuilder: (context, index) {
          if (index == model.getProductsCount()) {
            if (model._hasModeProducts && index>total) {
              pageindex++;
              model.parseProductsFromResponse(categories, pageindex);//categoryid
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

          }

           else {
            if (index > model.getProductsCount()-1) {
              return Container();
            }
            return Text(model.productsList[index].name+model.productsList[index].id);

          }
        },
      ),
    );
  }}


class Product {
  String id;
  String name;
  Product({this.id,this.name});
}

class ProductScopedModel extends Model {
  List<Product> _productsList = [];
  bool _isLoading = true;
  int currentProductCount;
  List<Product> get productsList => _productsList;
  bool _hasModeProducts = true;
  bool get isLoading => _isLoading;
  int total = 0;
  void addToProductsList(Product product) {
    _productsList.add(product);
  }

  int getProductsCount() {
    return _productsList.length;
  }

  Future<dynamic> _getProductsByCategory(categoryId, pageIndex) async {
    //logic for fetching remote data
    var response = await http
        .get('http://localhost/precious/products/all/$categoryId?page=$pageIndex').catchError((error) {
      return false;
    });
      var  data = json.decode(response.body);
      total = data['total']as int;
    return json.decode(response.body);

  }


  Future parseProductsFromResponse(int categoryId, int pageIndex) async {

    if (pageIndex == 0) {
      _isLoading = true;
    }
    notifyListeners();
    currentProductCount = 0;
    var dataFromResponse = await _getProductsByCategory(categoryId, pageIndex);

    dataFromResponse = dataFromResponse['data'] as List;
    dataFromResponse.forEach((newProduct){
      currentProductCount++;

      //parse new product's details
      Product product = new Product(
        id: newProduct["id"],
        name: newProduct["name"],

      );


      addToProductsList(product);
    });



    if (pageIndex == 0) _isLoading = false;

    if (currentProductCount <10) {
      _hasModeProducts = false;
    }

    notifyListeners();
  }
}
