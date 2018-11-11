import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../utils/config.dart' as c;

class ProductDetailModel extends Model {

  ProductItem item = ProductItem();
  Variant selectedVariant;
  List<Spec> selectedspec = List<Spec>();
  Future<dynamic> _getProduct(int id) async {
    //logic for fetching remote data
    var response = await http
        .get(c.base_url + 'precious/products/$id')
        .catchError((error) {
      return false;
    });
    //var data = json.decode(response.body);

    return json.decode(response.body);
  }
  ChangeVariant(Variant value)
  {

    selectedVariant = value;
    notifyListeners();
    //selectedspec =  selectedVariant.spec;
    //notifyListeners();




  }
  getSpec()
  {
    print(selectedspec);
  }


  loadFirst()
  {

    selectedspec = item.variant[0].spec;
    notifyListeners();
  }

  Future parseFromResponse(int id) async {

    var dataFromResponse = await _getProduct(id);
    dataFromResponse = dataFromResponse['data'];
      ProductItem tempitem = ProductItem();
      var variasi = dataFromResponse['variant'] as List;
      variasi.forEach((varian) {
        Variant v = Variant(
            Specification_ID: varian['Specification_ID'],
            Specification_name: varian['Specification_name'],
            Specification_price: varian['Specification_price']);
        var spek = varian['Specifications'] as List;
        spek.forEach((spec) {
          var s = Spec(
              Specification_ID: spec['Specification_ID']??null,
              name: spec['name']??null,
              value: spec['value']??null);
          v.spec.add(s);
        });
        tempitem.variant.add(v);
      });
      tempitem.Product_name = dataFromResponse['Product_name'];
      tempitem.Product_ID = dataFromResponse['Product_ID'];
      item = tempitem;
    notifyListeners();
    loadFirst();
  }
}

class ProductItem {
  String Product_ID;
  String Product_name;
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
