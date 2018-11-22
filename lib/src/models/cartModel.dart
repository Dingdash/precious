import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class cartModel extends Model{
  List<productItem> cart = List<productItem>();

  addtoCart(int id,int variant){

  }

 removeItem(){

 }
 decreaseItem(int id){
  
  notifyListeners();
 }
 clearCart(){
    cart.clear();
    notifyListeners();
 }





}

class productItem {
  int price;
  int qty;
  String name;
  String src;
  int product_id;
  int specification_id;
  String varian;
  int subtotal;
}


final cart = cartModel();