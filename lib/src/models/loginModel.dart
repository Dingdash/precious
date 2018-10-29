import 'package:scoped_model/scoped_model.dart';
class LoginModel extends Model {
  String userField, passwordField, errorTextUser, errorTextPassword;
  bool obscurePassword = false;

  String get user => userField;

  String get password => passwordField;

  String get errorUser => errorTextUser;

  String get errorPass => errorTextPassword;
  bool get Viewpassword => obscurePassword;
  void changeUser(String val) {
    print(val);
    userField = val;
    if (val.length>0) {
      errorTextUser = null;
    } else {
      errorTextUser = 'Please enter a Username';
    }
    print(errorTextUser);
    notifyListeners();
  }
  void changePass(String val){
    passwordField = val;
    if(val.length>6)
    {
      errorTextPassword = null;
    }else
    {
      errorTextPassword = 'Password must greater than 6 characters';
    }
    notifyListeners();
  }
  void changeObscure(bool val)
  {
    obscurePassword = val;
    notifyListeners();
  }


}