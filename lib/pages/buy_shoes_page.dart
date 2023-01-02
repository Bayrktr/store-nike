import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_store/fonc/mysql.dart';
import 'package:nike_store/fonc/shared_preferance.dart';
import 'package:nike_store/pages/main_page.dart';
import 'package:nike_store/pages/shoes_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:math';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

chooseColorUS(index) {
  if (index == 0) {
    return Colors.black;
  } else {
    return Colors.grey;
  }
}

chooseColorEU(index) {
  if (index == 1) {
    return Colors.black;
  } else {
    return Colors.grey;
  }
}

_launchURL(url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class buy_shoes_pages extends StatefulWidget {
  buy_shoes_pages(
      {Key,
      this.shoes_name,
      this.shoes_asset,
      this.shoes_price,
      this.category_name,
      this.background_color});

  final shoes_name;
  final shoes_asset;
  final shoes_price;
  final category_name;
  final background_color;

  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<buy_shoes_pages> {
  int _isSelectedShoes = 0;
  int _isSelectedShoeNumber = 0;

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    var shoes_type = [
      ['5', '5.5', '6', '6.5', '7', '7.5', '8', '8.5', '9'],
      ['36', '36.5', '37', '37.5', '38', '38.5', '39', '39.5', '40', '41'],
    ];

    chooseColorShoeNumber(index) {
      if (_isSelectedShoeNumber == index) {
        return [Color.fromARGB(255, 45, 45, 45), Colors.white];
      } else {
        return [Color.fromARGB(255, 226, 228, 233), Colors.black];
      }
    }

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
                color: widget.background_color),
            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.shoes_name}",
                  style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(240, 255, 255, 255)),
                ),
                Transform.rotate(
                    angle: 269.5,
                    child: Image.asset(
                      '${widget.shoes_asset}',
                      height: sizes.height / 10,
                    ))
              ],
            ),
            height: 250,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("${widget.category_name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 15)),
                  Padding(padding: EdgeInsets.only(bottom: 2)),
                  Text(
                    "${widget.shoes_name.toString().replaceAll('\n', '').toTitleCase()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "₺ ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 30,
                            color: Colors.black),
                      ],
                    ),
                  ),
                  Text(
                    "${widget.shoes_price.toString()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 30,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 40, right: 40),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Size:",
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isSelectedShoes = 0;
                            });
                          },
                          child: Text(
                            "US",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: chooseColorUS(_isSelectedShoes)),
                          )),
                      width: 36,
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isSelectedShoes = 1;
                              print(_isSelectedShoes);
                            });
                          },
                          child: Text(
                            "EU",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: chooseColorEU(_isSelectedShoes)),
                          )),
                      width: 36,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 55,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: shoes_type[_isSelectedShoes].length,
                itemBuilder: (_, index) {
                  return Container(
                    width: 50,
                    height: 55,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(3),
                    child: TextButton(
                      child: Text(
                        "${shoes_type[_isSelectedShoes][index]}",
                        style: TextStyle(
                            color: chooseColorShoeNumber(index)[1],
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        setState(() {
                          _isSelectedShoeNumber = index;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                        color: chooseColorShoeNumber(index)[0],
                        borderRadius: BorderRadius.circular(10)),
                  );
                }),
            margin: EdgeInsets.only(left: 35),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 30, right: 15),
            child: PopupMenuButton<int>(
              child: ListTile(
                title: Text(
                  "Details",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 17),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                    value: 1,
                    // row has two child icon and text.
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          launchUrl('https://www.nike.com/');
                        },
                        icon: Icon(
                          MdiIcons.web,
                          color: Colors.black,
                        ),
                        label: Text(
                          "www.nike.com",
                          style: TextStyle(color: Colors.black),
                        ))),
              ],
              offset: Offset(0, 50),
              color: widget.background_color,
              elevation: 1,
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey),
          ),
          Container(
            margin: EdgeInsets.only(left: 60, right: 60, top: 20),
            child: ProgressButton(
              stateWidgets: {
                ButtonState.idle: Text(
                  "Add to Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                ButtonState.loading: Text(
                  "Loading",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.fail: Text(
                  "Fail",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                ButtonState.success: Text(
                  "Success",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )
              },
              stateColors: {
                ButtonState.idle: Colors.black,
                ButtonState.loading: Colors.red,
                ButtonState.fail: Colors.black,
                ButtonState.success: Colors.black,
              },
              onPressed: () async {
                await save_bag_item(
                    widget.shoes_name,
                    _createId(),
                    widget.shoes_asset,
                    widget.shoes_price,
                    widget.category_name,
                    '1',
                    _isSelectedShoeNumber,
                    widget.background_color,
                    context);
              },
              state: ButtonState.idle,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}

launchUrl(url) async {
  if (await launch(url)) {
    await canLaunch(url);
  } else {
    throw 'Could not launch $url';
  }
}

int _createId() {
  Random random = Random();
  int randomNumber = random.nextInt(99999) + 10000;
  return randomNumber;
}
