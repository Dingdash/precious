import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utils/config.dart' as c;

class  UserAPI {

  final url = c.base_url+"precious/user/edituser";
 Future <dynamic> changePassword(String oldpass, String newpass)

  async
  {
    //print(newpass);
      var string;
    Map<String, String> headers = Map<String, String>();

    headers['Accept'] = "application/json";
    Map<String,String> body = Map<String,String>();
    body['password']=newpass;
    var resp = await http.post(url+"/password",headers: headers,body:body).timeout(Duration(seconds: 20),onTimeout: (){
      string = "timedout";
    }).catchError((e){print(e.toString());}).then((value){
      string = jsonDecode(value.body);
       
    });
    return string;



  }
  changeFirstName(String name)
  {

  }
  changeSurName (String name)
  {

  }
  changeGender(String gender)
  {

  }
  changeAddress(String address)
  {

  }
  changePostCode(String postcode)
  {

  }
  changeCity(String city)
  {

  }

}