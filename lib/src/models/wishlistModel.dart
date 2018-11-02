import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../utils/config.dart' as c;
import 'dart:convert';
class wishlistModel extends Model{
  List<Wishlist> wishlist =List<Wishlist>();
  Future<dynamic> _getWishlist() async {
    //logic for fetching remote data localhost/precious/user/wishlist
    var response = await http
        .get(c.base_url + 'precious/user/wishlist')
        .catchError((error) {
      return false;
    });
    //var data = json.decode(response.body);

    return json.decode(response.body);
  }
  Future parseFromResponse() async {
    var dataFromResponse = await _getWishlist();
    var _wishlist = dataFromResponse as List;
    _wishlist.forEach((data){
      print(data['Product_name']);
      Wishlist w = Wishlist(Product_ID: data['Product_ID'].toString(),User_ID: data['User_ID'].toString(),Category_ID: data['Category_ID'],Product_name: data['Product_name']);
      wishlist.add(w);
    });
    notifyListeners();
  }

}
class Wishlist{
  String Product_ID,User_ID,Category_ID,Product_name;
  Wishlist({this.Product_ID,this.User_ID,this.Category_ID,this.Product_name});
}