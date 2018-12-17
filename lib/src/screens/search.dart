import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../utils/config.dart' as c;

class SearchState extends StatefulWidget {
  @override
  Search createState() => Search();
}

class Product {
  String id;
  String name;
  String price;

  Product({this.id, this.name, this.price});
}


class Ancor{
  final List<String>name = new List<String>();
  final List<String>initials = List<String>();
}
class Category{
  String name;
  String id;
  String imgurl;
  Category({this.name,this.id,this.imgurl});
  factory Category.fromJson(Map<String, dynamic> json)
  {
    return Category(
        name: json['name'],id:json['category_id'].toString(),imgurl: 'tes'
    );
  }

}

class Search extends State<SearchState> {
  List<Product> result = List();


  List<Category> cat = List<Category>();

  List<String> _filters = <String>[];
  Ancor filterwithid =  Ancor();

  final myquery = TextEditingController();
  bool hasloaded = true;
  void fetchData() {
    getCategories().then((res) {
      setState(() {
        cat=res;

      });
    });
  }

  @override initState(){
    fetchData();
  }
  void searchProduct(query) {

    resetSearch();
    result.clear();
    if (query.isEmpty) {
      setState(() {
        hasloaded = true;
      });
    } else {

      setState(() {
        hasloaded = false;
      });
      parseSearch(query,filterwithid.initials);
    }
  }

  void resetSearch() {
    setState() {
      result.clear();
    }
  }
  Future<List<Category>> getCategories() async {
    //logic for fetching remote data
    var response = await http
        .get(c.base_url+'/categories/all');
    var parsed =  json.decode(response.body).cast<Map<String,dynamic>> () ;
    parsed.forEach((cat){
      Category  cc = new Category(name: cat['name'],id:cat['category_id'].toString(),imgurl: 'tes');
    });
    return parsed.map<Category>((json)=> Category.fromJson(json)).toList();
  }

  Future<dynamic> _getSearch(query,List categories) async {
    //logic for fetching remote data
    Map<String, dynamic> body = new Map<String, dynamic> ();
    body['query'] = query;
    if(categories.length==0)
      {
        List<String> _cast = List<String>();
        for(int i=0; i<cat.length;i++)
          {
            _cast.add(cat[i].id);
          }

        body['categories'] = _cast;
      }else{
      body['categories'] = categories;
    }


    var jsonbody = jsonEncode(body);
    var response = await http
        .post(
        c.base_url + 'search', headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    }, body: jsonbody)
        .catchError((error) {
      return false;
    });
    return json.decode(response.body);
  }

  Future<dynamic> parseSearch(query,List categories) async {

    var dataFromResponse = await _getSearch(query,categories);
    print(dataFromResponse['data']);
    dataFromResponse = dataFromResponse['data'] as List;
    dataFromResponse.forEach((newProduct) {
      //parse new product's details
      //TODO GET PRICE FROM API
      Product product = new Product(
        id: newProduct["Product_ID"],
        name: newProduct["Product_name"],
        price: "200000",

      );

      result.add(product);

    });
    setState(() {
      hasloaded = true;
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: () {
          Navigator.pop(context);
        }),
        title: TextField(controller:myquery,onChanged: (val) {
          searchProduct(myquery.text);

        },style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
          children: <Widget>[
            Wrap(children: actorWidgets.toList()),
            Divider(),
            (hasloaded == true ? Container(child: Expanded(
              child: result.length < 1 ? Container() : ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      ListTile(title: Text(result[index].name), onTap: () {

                          Navigator.of(context)
                              .pushNamed('/products/' + result[index].id.toString());

                      },);
                    //Text(result[index].name);
                  }),
            )) : Center(child: CircularProgressIndicator())),

          ]
      ),
    );
  }

  Iterable<Widget> get actorWidgets sync* {
    for (Category actor in cat) {
      yield Padding(
        padding: const EdgeInsets.only(left:2.0),
        child: FilterChip(
          pressElevation: 3.0,
          selectedColor: Colors.grey.shade100,
          backgroundColor: Colors.white,
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value==true) {

                _filters.add(actor.name);
               filterwithid.name.add(actor.name);
                filterwithid.initials.add(actor.id);


              } else {
                int indexku = (filterwithid.name.indexOf(actor.name));
                filterwithid.name.removeAt(indexku);
                filterwithid.initials.removeAt(indexku);
                _filters.removeWhere((String name) {


                  return actor.name == name;
                });
              }

            });
            searchProduct(myquery.text);
          },
        ),
      );
    }


  }
}