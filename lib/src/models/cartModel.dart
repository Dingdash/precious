import 'dart:convert';

import 'package:flutter/material.dart';
import '../api/CartAPI.dart';
import 'package:scoped_model/scoped_model.dart';
class cartModel extends Model{
  List<CartItems> cart = List<CartItems>();
  static String uid;
  cartModel(String uid){
    uid = uid;
  }
  CartAPI api = new CartAPI(uid);
  Future parseFromResponse(String uid) async {

    api.uid = uid;


    var dataFromResponse = await api.getCarts(uid);

    var _wishlist = dataFromResponse as List;
    _wishlist.forEach((data){
      //print(data['Product_name']);

      CartItems w = CartItems.fromJson(data);
      cart.add(w);
    });

    notifyListeners();

  }
  Future<dynamic>removeitems(int cartid)
  async
  {
    api.uid = uid;
    cart.removeWhere((cart)=>cart.cartid==cartid);
    notifyListeners();
    return await api.removeitems(cartid);

  }
  Future<dynamic>addtoCart(String userid,String productid, String variantid)
  async
  {
    api.uid = uid;
    return await api.addtoCart(userid, productid, variantid);

  }
  Future<dynamic>addtoWishlist(String productid,userid)
  async
  { api.uid = uid;
    return await api.addtoWishlist(productid, userid);
  }
  Future<dynamic>updateCart(int cartid,int qty)
  async
  {
    var string;
    api.uid = uid;
    int index=cart.indexWhere((cart)=>cart.cartid==cartid);
    cart[index].qty = qty.toString();

     await api.updateCart(cartid, qty).then((value){
       string = (value);
      notifyListeners();
    });
     return string;

  }





}

