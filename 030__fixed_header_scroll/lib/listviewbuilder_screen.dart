import 'package:flutter/material.dart';
import 'dart:math';

class ListViewBuilderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ListViewBuilder'),
        ),
        body: Column(
          children: [

            /// https://www.kindacode.com/article/flutter-adding-a-header-to-a-listview

            /// fixed element
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.amber,
              child: const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
            ),

            /// all the following elements
            Expanded(
              child: ListView.builder(
                  itemCount: _peopleData.length,
                  itemBuilder: (_, index) {
                    return _listItem(index);
                  }),
            ),
          ],
        )
    );
  }


  // Generate dummy data to feed the list view
  final List _peopleData = List.generate(1000, (index) {
    return {"name": "Person \#$index", "age": Random().nextInt(90) + 10};
  });

  // Item of the ListView
  Widget _listItem(index) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: Text(index.toString(), style: const TextStyle(fontSize: 18),),
        title: Text(
          _peopleData[index]['name'].toString(),
          style: const TextStyle(fontSize: 18),
        ),
        trailing: Text(_peopleData[index]['age'].toString(),
            style: const TextStyle(fontSize: 18, color: Colors.purple),
        ),
      ),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black26),),
      ),
    );
  }

}
