import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utils/config.dart' as c;

class TransAPI {




//  Future<List<CartItems>> getCart() async {
//
//
//    var response = await http
//        .get(c.base_url + "/cart/"+uid.toString());
//    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//
//    return parsed.map<CartItems>((json) => CartItems.fromJson(json)).toList();
//  }
//  Future<List<Category>> getCategories() async {
//    //logic for fetching remote data
//    var response = await http
//        .get(c.base_url+'/categories/all');
//    var parsed =  json.decode(response.body).cast<Map<String,dynamic>> () ;
//    return parsed.map<Category>((json)=> Category.fromJson(json)).toList();
//  }
  Future<List<TransItems>> getTransactionuser(String uid) async {
    //logic for fetching remote data localhost/precious/user/wishlist
    var response = await http
        .get(c.base_url + "/trans/cust/$uid")
        .catchError((error) {
    });
    var parsed = json.decode(response.body).cast<Map<String,dynamic>();
    return parsed.map<TransItems>((json)=>TransItems.fromJson(json)).toList();
    //return json.decode(response.body);
  }
  Future<dynamic> getTransaction(String transid) async{
    var string;
    await http.get(c.base_url+'/trans/$transid').then((response){
      string = json.decode(response.body);
    });
    return string;
  }

}

class TransItems{
  String invoice;
  String status;
  String receivername;
  String receiveraddress;
  String total;
  TransItems({this.invoice,this.status,this.receiveraddress,this.receivername,this.total});
  factory TransItems.fromJson(Map<String,dynamic>json){
    return TransItems(invoice: json['data']['invoice'],
      status: json['data']['status'],
      receiveraddress: json['data']['receiver_address'],
      receivername: json['data']['receiver_name'],
      total: json['data']['total']
    );
  }
}
class DTransItems{
  String transid;
  String dtransid;
  String price;
  String qty;
  String subtotal;
  String product_name;
  DTransItems({this.transid,this.dtransid,this.price,this.subtotal,this.qty,this.product_name});
  factory DTransItems.fromJson(Map<String, dynamic> json)
  {
    return DTransItems(
        transid: json['transaction_id'],dtransid:(json["dtransaction_id"]),qty: json['qty'],price: json['price'],subtotal: json['subtotal'],product_name: json['product_name'],
    );
  }

}