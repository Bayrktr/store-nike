import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_store/fonc/mysql.dart';
import 'package:nike_store/fonc/shared_preferance.dart';
import 'package:nike_store/pages/buy_shoes_page.dart';
import 'package:nike_store/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class my_bag_page extends StatefulWidget {
  my_bag_page({Key, this.items});

  var items;

  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<my_bag_page> {
  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => main_page()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: Image.asset(
            'lib/pictures/nike_logo.png',
            width: 180,
            height: 35,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              child: ListView.builder(
                itemCount: _itemCount(widget.items),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    height: sizes.height / 6,
                    width: sizes.width,
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset('${widget.items[index][2]}',
                              width: 150, height: 100),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 233, 233),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          children: [
                            Text(
                              '${widget.items[index][0].toString().replaceAll('\n', '').toTitleCase()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 2)),
                            Text('₺ ${widget.items[index][3]}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 30,
                                        color: Colors.black),
                                  ],
                                )),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      var result =
                                          await add_decrease_item_number(
                                              'add',
                                              widget.items[index][5],
                                              widget.items[index][1]);
                                      setState(() {
                                        widget.items[index][5] =
                                            result.toString();
                                      });
                                    },
                                    splashRadius: 20,
                                    icon: Icon(
                                      Icons.add_circle_outlined,
                                      size: 30,
                                    )),
                                Text('${widget.items[index][5]}'),
                                IconButton(
                                    onPressed: () async {
                                      if (int.parse(widget.items[index][5]) <=
                                          1) {
                                      } else {
                                        var result =
                                            await add_decrease_item_number(
                                                'remove',
                                                widget.items[index][5],
                                                widget.items[index][1]);
                                        setState(() {
                                          widget.items[index][5] =
                                              result.toString();
                                        });
                                      }
                                    },
                                    splashRadius: 20,
                                    icon: Icon(Icons.remove_circle_outlined,
                                        size: 30)),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: sizes.width / 8),
                        ),
                        Align(
                          child: IconButton(
                              onPressed: () async {
                                var result = await delete_item_from_bage(
                                    widget.items[index][1]);
                                dynamic item = await read_bage_item('my_bag_items');
                                setState(() {
                                  widget.items = item;
                                });
                              },
                              splashRadius: 30,
                              icon: Icon(Icons.delete)),
                          alignment: Alignment.bottomRight,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
              ),
              height: sizes.height / 1.3,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 3)),
                      Text(
                        "TOTAL",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 3)),
                      Text(
                        "TL ${_total_price(widget.items).toString()}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      label: Text("BUY"),
                      icon: Icon(Icons.shopping_cart_rounded),
                      onPressed: () {},
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

int _itemCount(item) {
  int number = 0;
  for (var x in item) {
    number += 1;
  }
  return number;
}

_total_price(item) {
  var total_numbers = [];
  var total_prices = [];
  var add_prices = [];
  dynamic total = 0;
  for (var x in item) {
    print(x);
  }
  for (var x in item) {
    total_prices.add(x[3]);
  }
  for (var x in item) {
    total_numbers.add(x[5]);
  }
  int number = 0;
  for (var z in total_prices) {
    for (int x = 0; x < int.parse(z); x++) {
      total += int.parse(total_numbers[number]);
    }
    number += 1;
  }
  print(total_numbers);
  print(total_prices);
  print(total);
  return total;
  /*
R  for (var x in item) {
    total_prices.add(x[3]);
  }
  for (var x in item) {
    total_numbers.add(x[5]);
  }
  for (var i in total_numbers) {
    int price = 0;
    for (var z = 0; z < z; z++) {
      price += int.parse(total_prices[i]);
    }
    add_prices.add(price);
  }
  for(var t in add_prices){
    total += int.parse(t);
  }
  print(total);
  return total.toString();

   */
}
