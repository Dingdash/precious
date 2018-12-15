import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utils/config.dart' as c;

class CartAPI {

   int uid;
  CartAPI({this.uid});

  Future<List<CartItems>> getCart() async {
    //logic for fetching remote data

    var response = await http
        .get(c.base_url + '/cart/'+uid.toString());
    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<CartItems>((json) => CartItems.fromJson(json)).toList();
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
  Future<dynamic> addtoCart(int userid,int productid,int variantid)async {
    var string;

    await http
        .get(c.base_url + '/cart/addtocart/'+userid.toString()+"/"+productid.toString()+"/"+variantid.toString()).then((response){
      string = json.decode(response.body);
    });
    return string;
  }
  Future<dynamic>addtoWishlist(int productid,int userid)async{
    var string;
    await http
        .get(c.base_url + '/user/wishlist/add/'+productid.toString()+"/"+userid.toString()).then((response){
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
  String qty;
  CartItems({this.cartid,this.username,this.product_id,this.spec_id,this.qty});
  factory CartItems.fromJson(Map<String, dynamic> json)
  {
    return CartItems(
        cartid: json['Cart_ID'],username:(json["Username"]),product_id: json['Product_ID'],spec_id: json['Specification_ID'],qty: json['Qty']
    );
  }
}