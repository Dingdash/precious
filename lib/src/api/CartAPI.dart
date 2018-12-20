import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utils/config.dart' as c;

class CartAPI {

   String uid;
  CartAPI(String uid){
    this.uid = uid;
   }

  Future<List<CartItems>> getCart() async {


    var response = await http
        .get(c.base_url + "/cart/"+uid.toString());
    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<CartItems>((json) => CartItems.fromJson(json)).toList();
  }
   Future<dynamic> getCarts(String uid) async {
     //logic for fetching remote data localhost/precious/user/wishlist
     var response = await http
         .get(c.base_url + "/cart/$uid")
         .catchError((error) {
       return false;
     });


     return json.decode(response.body);
   }
  Future<dynamic> updateCart(int cartid,int qty) async{
    var string;
    await http.get(c.base_url+'/cart/updatecart/'+cartid.toString()+"/"+qty.toString()).then((response){
      string = json.decode(response.body);
    });
    return string;
  }

  Future<dynamic> removeitems(int cartid) async{
    var string;

    await http
        .get(c.base_url + '/cart/removeitem/'+cartid.toString()).then((response){
          string = response.body;
    });
    return string;
  }
  Future<dynamic> addtoCart(String userid,String productid,String variantid)async {
    var string;

    await http
        .get(c.base_url + '/cart/addtocart/'+userid+"/"+productid+"/"+variantid).then((response){
      string = json.decode(response.body);
    });
    return string;
  }
  Future<dynamic>addtoWishlist(String productid,int userid)async{
    var string;
    await http
        .get(c.base_url + '/user/wishlist/add/'+productid+"/"+userid.toString()).then((response){
      string = json.decode(response.body);
    });
    return string;
  }

}

class CartItems{
  int cartid;
  String username;
  String product_id;
  String spec_id;
  String spec_price;
  String product_cover;
  String qty;
  String product_name;
  String spec_name;
  CartItems({this.cartid,this.username,this.product_id,this.spec_id,this.qty,this.spec_price,this.product_name,this.spec_name,this.product_cover});
  factory CartItems.fromJson(Map<String, dynamic> json)
  {
    return CartItems(
        product_cover:json['Product_cover'],cartid: json['Cart_ID'],username:(json["Username"]),product_id: json['Product_ID'],spec_id: json['Specification_ID'],qty: json['qty'],spec_price: json['Specification_price'],product_name: json['Product_name'],spec_name: json['Specification_name']
    );
  }
  getsubtotal(){
    return int.parse(200.toString()) * int.parse(qty);
  }
}