import 'package:scoped_model/scoped_model.dart';
import '../utils/config.dart' as c;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


import 'package:flutter/foundation.dart';
class CategoryModel extends Model{
   List<Category> categories = List<Category>();

    CategoryModel(){
      this.parseFromResponse();
    }
  Future<dynamic> _getCategories() async {
    //logic for fetching remote data
    var response = await http
        .get(c.base_url+'/categories/all').catchError((error) {
      return false;
    });
    return json.decode(response.body);
  }
   parseFromResponse()async{
    var dataFromResponse = await _getCategories() as List;
    print(dataFromResponse);
    dataFromResponse.forEach((cat){
        /*Category  cc = new Category(name: cat['name'],id:cat['category_id'].toString(),imgurl: 'tes');

        categories.add(cc);*/
        print(cat['name']);
    });
    notifyListeners();
    print('tes');
    return categories;
  }

}

class Category{
  String name;
  String id;
  String imgurl;
  Category({this.name,this.id,this.imgurl});

}

