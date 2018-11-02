import 'package:scoped_model/scoped_model.dart';




class UserModel extends Model{
  UserModel model = null;
  UserModel()
  {

  }
  String _username, _first_name,_last_name,_birthdate,_address,_email,_password,_gender,_city,_telp,_postCode;
  bool loggedin = false;
  String get getUsername => _username;
  String get getFirstname => _first_name;
  String get getLastname => _last_name;
  String get getAddress => _address;
  String get getEmail => _email;
  String get getPassword => _password;
  String get getGender => _gender;
  String get getPostcode => _postCode;
  String get getCity => _city;
  void signIn()
  {
    loggedin = true;
  }
  void setUsername(String val)
  {
    _username = val;
  }
  void setFirstname(String val)
  {
    _first_name = val;
  }
  void setLastname(String val)
  {
    _last_name = val;
  }
  void setPassword (String val)
  {
    _password = val;
  }
  void setGender (String val)
  {
    _gender = val;
  }
  void setBirthDate (String val)
  {
    _birthdate = val;
  }
  void signOut ()
  {
    loggedin = false;
  }
  bool getLoggedin()
  {
    return loggedin;
  }
  void setCity (String val)
  {
    _city = val;
  }
  void setAddress(String val)
  {
    _address = val;
  }
  void setTelp(String val)
  {
    _telp = val;
  }
  void setPostcode(String val)
  {
    _postCode = val;
  }
  void setEmail(String val)
  {
    _email = val;
  }

}
final session = UserModel();