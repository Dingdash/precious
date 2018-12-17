import 'package:flutter/material.dart';

import 'colors.dart';
import 'screens/account_settings.dart';
import 'screens/categories2.dart';
import 'screens/login.dart';
import 'screens/personal_info.dart';
import 'screens/product_detail.dart';
import 'screens/products.dart';
import 'screens/register.dart';
import 'screens/search.dart';
import 'screens/wishlist.dart';
import 'session/singleton.dart';
import 'screens/cart2.dart';
ThemeData _buildPreciousTheme(context) {
  final ThemeData base = ThemeData(fontFamily: 'sjsecret');
  return base.copyWith(
    canvasColor: canvasColor,

    primaryColor: primaryColor,
    buttonColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: Colors.white70,
    textSelectionColor: primaryColor,
    textSelectionHandleColor: Colors.black.withOpacity(0.3),
    errorColor: Colors.black,
    highlightColor: primaryColor,
    splashColor: primaryColor,

    // TODO: Add the text themes (103)
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Preciousx',
      onGenerateRoute: routes,
      theme: _buildPreciousTheme(context),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return Login();
      });
    } else if (settings.name == '/home') {
      return MaterialPageRoute(builder: (context) {
        return Categories();
      });
    } else if (settings.name == '/personalinfo') {
      return MaterialPageRoute(builder: (context) {
        return PinfoState();
      });
    } else if (settings.name.contains('/categories')) {
      return MaterialPageRoute(builder: (context) {
        // /categories/posts/1
        var arr = settings.name.split('/');

        final categoryID = int.parse(arr[3]);
        final categoryName = arr[2];

        return Products(
          categories: categoryID,
          categoryname: categoryName,
        );
      });
    } else if (settings.name == '/search') {
      return MaterialPageRoute(builder: (context) {
        return SearchState();
      });
    } else if (settings.name.contains('/product')) {
      var arr = settings.name.split('/');

      final productid = arr[2];
      return MaterialPageRoute(builder: (context) {
        return ProductDetail( productid);
      });
    } else if (settings.name == '/wishlist') {
      return MaterialPageRoute(builder: (context) {
        return Wishlist();
      });
    } else if (settings.name == '/settings') {
      return MaterialPageRoute(builder: (context) {
        return AccountSetting();
      });
    } else if (settings.name == '/Personalinfo') {
      return MaterialPageRoute(builder: (context) {
        return PinfoState();
      });
    } else if (settings.name == '/register') {
      return MaterialPageRoute(builder: (context) {
        return RegisterForm();
      });
    }else if (settings.name.contains('/cart')){
      return MaterialPageRoute(builder:(context){
        String uid = (session.getuID);

        return Cart(uid);
      });
    } else {
      return null;
    }
  }
}
