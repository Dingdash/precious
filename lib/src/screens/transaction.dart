import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../session/singleton.dart';
import '../utils/config.dart' as c;
import '../widgets/drawer.dart';

class TransactionPage extends StatefulWidget {
  @override
  TransactionState createState() => TransactionState();
}

class Transaction {}

class TransactionState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: myDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Transaction'),
        ),
        body: FutureBuilder<List<TransItems>>(
            future: getTransactionuser(session.getuID),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.none:
                  FlatButton(
                      child: Text("click here to retry"),
                      onPressed: () {
                        getTransactionuser(session.getuID);
                      });
                  break;
                default:
                  if (snapshot.hasError)
                    return Text('Error:${snapshot.error}');
                  else
                    if(!snapshot.hasData){
                      return Text("you don't have any transaction");
                    }else{
                      return ListView(
                        children: snapshot.data.map((TransItems){
                          return Container(
                            padding: EdgeInsets.only(left:10.0,right:10.0),
                            child: ListTile(
                              leading: TransItems.status!="UNPAID"?CircleAvatar(child: Text(TransItems.status,style: TextStyle(color: Colors.white),),radius: 40,backgroundColor: Colors.blue,):CircleAvatar(child: Text(TransItems.status,style: TextStyle(color: Colors.white)),radius: 40,backgroundColor: Colors.red,),
                              title: Text("Invoicenumber:\n${TransItems.invoice}",textScaleFactor: 1,),

                              subtitle: Text("total:${TransItems.total}\naddress:${TransItems.receiveraddress}\n${TransItems.receivername}"),
                              onTap: (){
                                Navigator.of(context).pushNamed("/webview/${TransItems.invoice}");

                              },
                            ),
                          );
                        }).toList(),
                      );
                    }
              }
            }));
  }

  Future<List<TransItems>> getTransactionuser(String uid) async {
    //logic for fetching remote data localhost/precious/user/wishlist
    var response =
        await http.get(c.base_url + "/trans/cust/$uid").catchError((error) {});
    var parsed =  json.decode(response.body);
   return parsed['data'].map<TransItems>((json)=>TransItems.fromJson(json)).toList();
  
   //return parsed['data'].map<TransItems>((json) => TransItems.fromJson(json)).toList();
  }
}

class TransAPI {
  Future<List<TransItems>> getTransactionuser(String uid) async {
    //logic for fetching remote data localhost/precious/user/wishlist
    var response =
        await http.get(c.base_url + "/trans/cust/$uid").catchError((error) {});
    var parsed = json.decode(response.body).cast < Map<String, dynamic>();
    return parsed.map<TransItems>((json) => TransItems.fromJson(json)).toList();


  }

  Future<dynamic> getTransaction(String transid) async {
    var string;
    await http.get(c.base_url + '/trans/$transid').then((response) {
      string = json.decode(response.body);
    });
    return string;
  }
}

class TransItems {
  String invoice;
  String status;
  String receivername;
  String receiveraddress;
  String total;

  TransItems(
      {this.invoice,
      this.status,
      this.receiveraddress,
      this.receivername,
      this.total});

  factory TransItems.fromJson(Map<String, dynamic> json) {
    return TransItems(
        invoice: json['invoice']??"",
        status: json['status'],
        receiveraddress: json['receiver_address'],
        receivername: json['receiver_name'],
        total: json['total']);
  }

}

class DTransItems {
  String transid;
  String dtransid;
  String price;
  String qty;
  String subtotal;
  String product_name;

  DTransItems(
      {this.transid,
      this.dtransid,
      this.price,
      this.subtotal,
      this.qty,
      this.product_name});

  factory DTransItems.fromJson(Map<String, dynamic> json) {
    return DTransItems(
      transid: json['transaction_id'],
      dtransid: (json["dtransaction_id"]),
      qty: json['qty'],
      price: json['price'],
      subtotal: json['subtotal'],
      product_name: json['product_name'],
    );
  }
}
