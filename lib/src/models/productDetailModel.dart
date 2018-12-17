import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../utils/config.dart' as c;

class ProductDetailModel extends Model {

  ProductItem item = ProductItem();
  Variant selectedVariant;
  List<Spec> selectedspec = List<Spec>();
  Future<dynamic> _getProduct(String id) async {
    //logic for fetching remote data
    var response = await http
        .get(c.base_url + '/products/$id')
        .catchError((error) {
      return false;
    });
    //var data = json.decode(response.body);

    return json.decode(response.body);
  }
  ProductDetailModel(String id)
  {
    print(id);
    parseFromResponse(id);
  }
  ChangeVariant(Variant value)
  {

    selectedVariant = value;
    notifyListeners();
    selectedspec =  selectedVariant.spec;
    notifyListeners();




  }



  loadFirst()
  {

    selectedVariant = item.variant[0];
    selectedspec = item.variant[0].spec;
    notifyListeners();
  }
  Future parseFromResponse(String id) async {

    var dataFromResponse = await _getProduct(id);
    dataFromResponse = dataFromResponse['data'];


      var variasi = dataFromResponse['variant'] as List;
    item.Product_name = dataFromResponse['Product_name'];
    item.Product_ID = dataFromResponse['Product_ID'];
    item.Product_description = dataFromResponse["Product_description"];

    variasi.forEach((varian) {
        Variant v = Variant(
            Specification_ID: varian['Specification_ID']??"a",
            Specification_name: varian['Specification_name']??"a",
            Specification_price: varian['Specification_price'])??"a";
        var spek = varian['Specifications'] as List;
        spek.forEach((spec) {
          var s = Spec(
              Specification_ID: spec['Specification_ID']??"a",
              name: spec['name']??"",
              value: spec['value']??"");
          v.spec.add(s);
        });
        item.variant.add(v);
      });


    //item = tempitem;
    loadFirst();
  }
}

class ProductItem {
  String Product_ID;
  String Product_name;
  String Product_description;
  List<Variant> variant = List<Variant>();
}

class Variant {
  String Specification_ID;
  String Specification_name;
  String Specification_price;

  Variant(
      {this.Specification_ID,
      this.Specification_name,
      this.Specification_price});

  List<Spec> spec= List<Spec>();
}

class Spec {
  String Specification_ID;
  String name;
  String value;

  Spec({this.Specification_ID, this.name, this.value});
}
