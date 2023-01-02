import 'package:flutter/material.dart';
import 'dart:math';

import 'package:nike_store/pages/buy_shoes_page.dart';

var shoes_items = [
  [
    ' NIKE \n'
        ''
        'SPARK',
    'lib/pictures/nike_spark.png',
    '350'
  ],
  [
    'NIKE \n'
        ''
        'AIR\n'
        ''
        'FORCE',
    'lib/pictures/nike_air_force.png',
    '350'
  ]
];

choose_color(index){
  if(index/2 == 0){
    return Color.fromARGB(255, 149, 233, 86);
  }
  else{
    return Color.fromARGB(255,84, 137, 236);
  }
}

shoes_pages(size,context,category_name) {
  return Container(
    height: size / 1.3,
      child: ListView.builder(
    itemBuilder: (_, index) {
      return TextButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buy_shoes_pages(
            background_color: choose_color(index),
            category_name: category_name,
            shoes_asset: shoes_items[index][1],
            shoes_name: shoes_items[index][0],
            shoes_price: shoes_items[index][2],
          )),
        );
      }, child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: choose_color(index)),
        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${shoes_items[index][0]}",
              style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(240, 255, 255, 255)),
            ),
            Transform.rotate(
                angle: 269.5,
                child: Image.asset(
                  '${shoes_items[index][1]}',
                  height: size / 10,
                ))
          ],
        ),
        height: 300,
      ),);
    },
    itemCount: shoes_items.length,
  ));
}
