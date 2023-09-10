import 'package:flutter/material.dart';
import 'package:shop_app/app.dart';
import 'package:shop_app/service/db_hive.dart';


final auth = HiveUser();
void main() async {
  await HiveUser.init();
  runApp(const ShopAppp());
}