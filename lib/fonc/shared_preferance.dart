import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


/*
save_item(name, asset, price, category, number, background_color) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final data = await prefs.setStringList('shopping_items',
      <String>[name, asset, price, category, background_color.toString(), number]);
  print(await read_items('shopping_items'));
}


Future<List<String>> read_items(name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Future<List<String>?> datas = await prefs.getStringList(name);
  return datas;
}

 */
