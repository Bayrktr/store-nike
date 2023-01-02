import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/pages/buy_shoes_page.dart';
import 'package:progress_state_button/progress_button.dart';

Future<MySqlConnection> dbConnectSystem() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      // Emulator kullanıyorsan boyle kullan
      port: 3306,
      user: 'root',
      password: '12345',
      db: 'system'));
  return conn;
}

save_bag_item(name,id,asset, price, category, number, shoe_size, background_color,
    context) async {
  try {
    final db = await dbConnectSystem();
    var result = await db.query(
        'insert into my_bag_items (name, id,asset, price,category,number,shoe_size,background_color) values (?,?, ?, ?, ? ,?,? , ?)',
        [
          '${name}',
          '${id}',
          '${asset}',
          '${price}',
          '${category}',
          '${number}',
          '${shoe_size}',
          '${background_color.toString()}'
        ]);
    return showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Color.fromARGB(255, 50, 50, 50),
          ),
          child: AlertDialog(
            title: Text(
              '${name.toString().replaceAll('\n', '').toTitleCase()}',
              style: TextStyle(
                color: background_color,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 30,
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ))
            ],
            content: Text(
              "Successfully Added to Cart",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  } catch (e) {
    print("sa");
    return showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Color.fromARGB(255, 50, 50, 50),
          ),
          child: AlertDialog(
            title: Text(
              'Operation Failed',
              style: TextStyle(
                color: background_color,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 30,
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ))
            ],
            content: Text(
              "Check Your Internet Connection and Try Again",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}

read_bage_item(table) async {
  final db = await dbConnectSystem();
  dynamic list = [];
  var results = await db.query('select * from ${table}');
  for (var row in results) {
    dynamic liste2 = [];
    liste2.add(row['name'].toString());
    liste2.add(row['id']);
    liste2.add(row['asset'].toString());
    liste2.add(row['price'].toString());
    liste2.add(row['category'].toString());
    liste2.add(row['number'].toString());
    liste2.add(row['shoe_size'].toString());
    liste2.add(row['background_color'].toString());
    list.add(liste2);
  }
  print(list);
  db.close();
  return list;
}

add_decrease_item_number(progress, number, id) async {
  final db = await dbConnectSystem();
  print(number);
  print(id);
  var list = [];
  if (progress == 'add') {
    var result = await db.query(
        'update my_bag_items set number =? where id=?',
        ['${int.parse(number) + 1}', '${id}']);
  } else {
    var result = await db.query(
        'update my_bag_items set number =? where id=?',
        ['${int.parse(number) - 1}', '${id}']);
  }
  var result = await db
      .query('select number from my_bag_items name where id = ?', [id]);
  for (var x in result) {
    list.add(x[0]);
  }
  db.close();
  return list[0];
}

delete_item_from_bage(id)async{
  print("sa");
  print(id);
  final db = await dbConnectSystem();
  var result = await db.query('delete from my_bag_items where id = ?',['${id}']);
  print("as");
  return result;
}
