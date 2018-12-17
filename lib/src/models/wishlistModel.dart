import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../utils/config.dart' as c;
import 'dart:convert';



class Wishlist{
  String Wishlist_ID,Product_ID,User_ID,Category_ID,Product_name;
  Wishlist({this.Wishlist_ID,this.Product_ID,this.User_ID,this.Category_ID,this.Product_name});
}


class wishlistModel extends Model{
  List<Wishlist> wishlist =List<Wishlist>();
  Future<dynamic> _getWishlist(String uid) async {
    //logic for fetching remote data localhost/precious/user/wishlist
    var response = await http
        .get(c.base_url + '/user/wishlist/'+uid)
        .catchError((error) {
      return false;
    });
    //var data = json.decode(response.body);

    return json.decode(response.body);
  }
  Future parseFromResponse(String uid) async {
    var dataFromResponse = await _getWishlist(uid);
    var _wishlist = dataFromResponse as List;
    _wishlist.forEach((data){
      //print(data['Product_name']);
      Wishlist w = Wishlist(Wishlist_ID: data['Wishlist_ID'].toString(),Product_ID: data['Product_ID'].toString(),User_ID: data['User_ID'].toString(),Category_ID: data['Category_ID'],Product_name: data['Product_name']);
      wishlist.add(w);
    });
    notifyListeners();
  }
  removewishlist(String wishlistid)
  async
  {


    await await http
        .get(c.base_url + '/user/wishlist/remove/'+wishlistid).then((response){
        json.decode(response.body);
        wishlist.removeWhere((wlist)=>wlist.Wishlist_ID==wishlistid);
        notifyListeners();
    });

  }
  Future<dynamic>addtoWishlist(int productid,int userid)async{
    var string;
    await http
        .get(c.base_url + '/user/wishlist/'+productid.toString()+"/"+userid.toString()).then((response){
      string = json.decode(response.body);
    });
    return string;
  }

}
