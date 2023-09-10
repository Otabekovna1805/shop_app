// import 'package:flutter/material.dart';
//
// import 'cart_controlller.dart';
//
// class Provider extends InheritedWidget {
//   final CartController controller;
//
//   const Provider({required this.controller, super.key, required super.child});
//
//   static CartController of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<Provider>()!.controller;
//   }
//
//   @override
//   bool updateShouldNotify(Provider oldWidget) {
//     return oldWidget.controller.cart != controller.cart;
//   }
// }
