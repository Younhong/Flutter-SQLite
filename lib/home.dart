import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db_helper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String itemTitle = '';
  List items = [];

  insertShoppingItems() async{
    await insertItemsToDb(itemTitle, 0);
    getItemsFromDb();
  }

  getItemsFromDb() async{
    List shoppingItems = await retreiveItemsFromDb();
    setState(() {
      items = shoppingItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    getItemsFromDb();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              // text field
              title: TextFormField(
                onChanged: (String myTitle) {
                  setState(() {
                    itemTitle = myTitle;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Title',
                    labelText: 'Title'),
                style: TextStyle(fontSize: 14),
              ),
              // add button
              trailing: RaisedButton(
                onPressed: () {// insert into the database
                  insertShoppingItems();
                },
                child: const Text('add',
                    style: TextStyle(
                        fontSize: 12)),
              ),
            ),
            // Data
            DataTable(
              columns: [
                DataColumn(
                  label: Text("Select"),
                  numeric: false,
                ),
                DataColumn(
                  label: Text("Title"),
                  numeric: false,
                ),
                DataColumn(
                  label: Text("Delete"),
                  numeric: false,
                )
              ],
              rows: items
                  .map<DataRow>((item) => DataRow(
                  cells: [
                    DataCell(
                        Checkbox(
                            value: item['BOUGHT'] == 1
                                ? true : false,
                            onChanged: (newValue) {
                              updateItemBoughtState(
                                  item["ID"],
                                  item["BOUGHT"] == 1
                                      ? 0 : 1);
                            }),
                        onTap: () {}),
                    DataCell(
                        Text(
                          item['TITLE'],
                          style: TextStyle(
                            decoration: item['BOUGHT'] == 1
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        onTap: () {}),
                    DataCell(
                        Icon(Icons.delete,
                            color: Color(0xffDB4437), size: 20),
                        onTap: () async {
                          deleteItem(item['ID']);
                        }),
                  ])).toList(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}