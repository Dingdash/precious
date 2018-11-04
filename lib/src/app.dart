import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/categories.dart';
import 'screens/login.dart';
import 'screens/personal_info.dart';
import 'screens/products.dart';
import 'screens/search.dart';
import 'screens/product_detail.dart';
import 'screens/wishlist.dart';
import 'screens/account_settings.dart';
import 'states/category_state.dart';
class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(title: 'News!', onGenerateRoute: routes);
  }
  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return Login();
      });
    } else if (settings.name == '/home') {
      return MaterialPageRoute(builder: (context) {
        return ScopedModel<CategoryModel>(
          model: CategoryModel(),
          child: Categories(),
        );
      });
    } else if (settings.name == '/personalinfo') {
      return MaterialPageRoute(builder: (context) {
        return PersonalInfo();
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
        return Search();
      });
    } else if (settings.name.contains('/product')) {
      return MaterialPageRoute(builder: (context) {
        return ProductDetail();
      });
    } else if (settings.name == '/wishlist') {
      return MaterialPageRoute(builder: (context) {
        return Wishlist();
      });
    } else if (settings.name == '/settings') {
      return MaterialPageRoute(builder: (context) {
        return AccountSettings();
      });
    }
  }
}
