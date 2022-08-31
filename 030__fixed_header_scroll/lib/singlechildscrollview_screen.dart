import 'package:flutter/material.dart';

class SingleChildScrollViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SingleChildScrollView'),
        ),
        body:
        Column(
            children: [
              /// fixed element
              Container(
                color: Colors.amber,
                child: const ListTile(leading: Text('#'), title: Text('Header'), trailing: Text('#'),),
              ),

              /// all the following elements
              Expanded(  // make it scrollable
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[

                      // any widget, not just ListTiles (ListViewBuilder)
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      const Text('Some text'),
                      const ListTile(leading: Text('ID'), title: Text('Name'), trailing: Text('Age'),),
                      ElevatedButton(onPressed: () {}, child: const Text('Button'),),

                    ],
                  ),
                ),
              )
            ]
        )

    );
  }
}
