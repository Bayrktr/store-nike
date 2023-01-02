import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_store/fonc/mysql.dart';
import 'package:nike_store/pages/buy_shoes_page.dart';
import 'package:nike_store/pages/my_bag.dart';
import 'package:nike_store/pages/shoes_page.dart';

class main_page extends StatefulWidget {
  main_page({Key});

  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<main_page> {

  var categorys = ['All', 'Shoes', 'Clothes', 'Kids'];
  int _isSelectedItem = 1;


  colorChoose(index) {
    if (_isSelectedItem == index) {
      return Colors.black;
    } else {
      return Color.fromARGB(255, 209, 203, 203);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    var bodys = [
      '',
      shoes_pages(sizes.height,context,categorys[_isSelectedItem]),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: ()async{
            dynamic item = await read_bage_item('my_bag_items');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => my_bag_page(
                items: item,
              )),
            );
          }, icon: Icon(Icons.shopping_cart,color: Colors.black,))
        ],
        leading: IconButton(
          onPressed: () {},
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
              itemCount: categorys.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Padding(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isSelectedItem = index;
                          });
                        },
                        child: Text(
                          "${categorys[index]}",
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: colorChoose(index)),
                        )),
                    padding: EdgeInsets.only(left: 10, right: 10));
              },
            ),
            height: 50,
          ),
          bodys[_isSelectedItem],
        ],
      ),
    );
  }
}
