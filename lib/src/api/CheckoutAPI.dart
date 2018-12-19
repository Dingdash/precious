import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utils/config.dart' as c;

class CheckoutAPI {

  String uid;
  CheckoutAPI(String uid){
    this.uid = uid;
  }

//  Future<List<CartItems>> getCart() async {
//
//
//    var response = await http
//        .get(c.base_url + "/cart/"+uid.toString());
//    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//
//    return parsed.map<CartItems>((json) => CartItems.fromJson(json)).toList();
//  }
  Future<dynamic> getShippers()async{
    var string;
    var response = await http.get(c.base_url+'/shipper/all').then((response){
      string = json.decode(response.body);
    });
    return string;
  }

  Future<dynamic> sendCheckout(String uid,String shipperid,String total,String receivername, String receiveraddress, String email, String description,String zipcode, String city) async {
    //logic for fetching remote data localhost/precious/user/wishlist
    var string;
    var response =
    await http.post(c.base_url+'/cart/checkout/'+uid,headers: {"Accept": "application/json"},body:{
      'shipper':shipperid,
      'customerid':uid,
      'total':total,
      'receiver_name':receivername,
      'receiver_address':receiveraddress,
      'city':city,
      'zipcode':zipcode,
      'email':email
    }).then((response){
      string = json.decode(response.body);
    });
    return string;

  }
}

class CheckoutItems{
  String Shipper_ID;
  String Customer_ID;
  String Total;
  String Receiver_name;
  String Receiver_address;
  String description;
  String zipcode;
  String city;
  CheckoutItems({this.Shipper_ID,this.Customer_ID,this.Total,this.Receiver_name,this.Receiver_address,this.description,this.zipcode,this.city});
//  factory CartItems.fromJson(Map<String, dynamic> json)
//  {
//    return CartItems(
//        cartid: json['Cart_ID'],username:(json["Username"]),product_id: json['Product_ID'],spec_id: json['Specification_ID'],qty: json['qty'],spec_price: json['Specification_price'],product_name: json['Product_name'],spec_name: json['Specification_name']
//    );
//  }
//  getsubtotal(){
//    return int.parse(200.toString()) * int.parse(qty);
//  }
}