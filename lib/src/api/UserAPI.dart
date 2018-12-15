import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utils/config.dart' as c;

class UserAPI {

  final url = c.base_url + "user/edituser";

  Future <dynamic> changePassword(String oldpass, String newpass,String username) async
  {

    var string;
    Map<String, String> headers = Map<String, String>();

    headers['Accept'] = "application/json";
    Map<String, String> body = Map<String, String>();
    body['username'] = username;
    body['password'] = newpass;
    await http.post(url + "/password", headers: headers, body: body)
        .timeout(Duration(seconds: 20), onTimeout: () {
      string = "timedout";
    }).catchError((e) {
      print(e.toString());
    })
        .then((value) {
      string = jsonDecode(value.body);
    });
    return string;
  }

  Future <dynamic> changeFirstName(String name,String username) async {
    var string;
    Map<String, String> headers = Map<String, String>();
    headers['Accept'] = "application/json";
    Map<String, String> body = Map<String, String>();
    body['first_name'] = name;
    body['username'] = username;
    await http.post(url + "/firstname", headers: headers, body: body)
        .timeout(Duration(seconds: 20), onTimeout: () {
      string = "timedout";
    }).catchError((e) {
      print(e.toString());
    })
        .then((value) {
      string = jsonDecode(value.body);
    });
    return string;
  }
  Future <dynamic> changeEmail(String email,String username) async {
    var string;
    Map<String, String> headers = Map<String, String>();
    headers['Accept'] = "application/json";
    Map<String, String> body = Map<String, String>();
    body['username'] = username;
    body['email'] = email;
    await http.post(url + "/email", headers: headers, body: body)
        .timeout(Duration(seconds: 20), onTimeout: () {
      string = "timedout";
    }).catchError((e) {

      //print(e.toString());
    })
        .then((value) {
      string = jsonDecode(value.body);
    });
    return string;
  }




Future<dynamic> changeSurName(String name,String username) async {
  var string;
  Map<String, String> headers = Map<String, String>();
  headers['Accept'] = "application/json";
  Map<String, String> body = Map<String, String>();
  body['last_name'] = name;
  body['username'] = username;
  await http.post(url + "/lastname", headers: headers, body: body)
      .timeout(Duration(seconds: 20), onTimeout: () {
    string = "timedout";
  }).catchError((e) {
    print(e.toString());
  })
      .then((value) {
    string = jsonDecode(value.body);
  });
  return string;
}

Future<dynamic> changeGender(String gender) async {
  var string;
  Map<String, String> headers = Map<String, String>();
  headers['Accept'] = "application/json";
  Map<String, String> body = Map<String, String>();
  body['gender'] = gender;
  await http.post(url + "/gender", headers: headers, body: body)
      .timeout(Duration(seconds: 20), onTimeout: () {
    string = "timedout";
  }).catchError((e) {
    print(e.toString());
  })
      .then((value) {
    string = jsonDecode(value.body);
  });
  return string;
}



Future<dynamic> changeAddress(String address,String username) async {

  var string;
  Map<String, String> headers = Map<String, String>();
  headers['Accept'] = "application/json";
  Map<String, String> body = Map<String, String>();
  body['address'] = address;
  body['username'] = username;
   await http.post(url + "/address", headers: headers, body: body)
      .timeout(Duration(seconds: 20), onTimeout: () {
    string = "timedout";
  }).catchError((e) {
    print(e.toString());
  })
      .then((value) {
    string = jsonDecode(value.body);
  });
  return string;
}

Future<dynamic>changePostCode(String postcode,String username) async{

  var string;
  Map<String, String> headers = Map<String, String>();
  headers['Accept'] = "application/json";
  Map<String, String> body = Map<String, String>();
  body['post_code'] = postcode;
  body['username'] = username;
  await http.post(url + "/postcode", headers: headers, body: body)
      .timeout(Duration(seconds: 20), onTimeout: () {
    string = "timedout";
  }).catchError((e) {
    print(e.toString());
  })
      .then((value) {
    string = jsonDecode(value.body);
  });
  return string;
}
Future<dynamic>changePhone(String phone,String username)async{
  var string;
  Map<String, String> headers = Map<String, String>();
  headers['Accept'] = "application/json";
  Map<String, String> body = Map<String, String>();
  body['telp'] = phone;
  body['username']= username;
  await http.post(url + "/telp", headers: headers, body: body)
      .timeout(Duration(seconds: 20), onTimeout: () {
    string = "timedout";
  }).catchError((e) {
    print(e.toString());
  })
      .then((value) {
    string = jsonDecode(value.body);
  });
  return string;
}
Future<dynamic>changeCity(String city,String username)async {
  var string;
  Map<String, String> headers = Map<String, String>();
  headers['Accept'] = "application/json";
  Map<String, String> body = Map<String, String>();
  body['city'] = city;
  body['username'] = username;
  await http.post(url + "/city", headers: headers, body: body)
      .timeout(Duration(seconds: 20), onTimeout: () {
    string = "timedout";
  }).catchError((e) {
    print(e.toString());
  })
      .then((value) {
    string = jsonDecode(value.body);
  });
  return string;
}


}