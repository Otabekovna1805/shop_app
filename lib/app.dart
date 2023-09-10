import 'package:flutter/material.dart';
import 'package:shop_app/controller/cart_controlller.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screen/home.dart';
import 'package:shop_app/screen/log_in_page.dart';
import 'model/model.dart';


final cartController = CartController(Cart(id: 1, items: []));

class ShopAppp extends StatelessWidget {
  const ShopAppp({Key? key}) : super(key: key);


  Widget get page {
    final user = auth.getUser();
    if(user != null) {
      return const Homes();
    } else {
      return const LogIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: cartController.state,
      stream: cartController.stream,
      builder: (context, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: ThemeData.light(useMaterial3: true),
            home: page,
        );
      }
    );
  }
}