import 'package:flutter/material.dart';

import 'screens/categories.dart';
import 'screens/login.dart';
import 'screens/personal_info.dart';
import 'screens/products.dart';
import 'screens/search.dart';
import 'screens/temp.dart';
import 'screens/product_detail.dart';
class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(title: 'News!', onGenerateRoute: routes);
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        //return Login();
        //return Search();
        return ProductDetail();
      });
    } else if (settings.name == '/home') {
      return MaterialPageRoute(builder: (context) {
        return Categories();
      });
    } else if (settings.name == '/personalinfo') {
      return MaterialPageRoute(builder: (context) {
        return PersonalInfo();
      });
    } else if (settings.name.contains('/categories')) {
      return MaterialPageRoute(builder: (context) {
        final categoryID =
            int.parse(settings.name.replaceFirst('/categories/', ''));
        return Products(
          categories: categoryID,
        );
      });
    }else if (settings.name == '/search'){
        return MaterialPageRoute(builder: (context){
          return Search();
        });
    }
  }
}
