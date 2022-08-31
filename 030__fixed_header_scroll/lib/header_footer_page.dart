import 'package:flutter/material.dart';


class HeaderFooterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationAppBar(),
        body: HeaderFooterPageImpl()
    );
  }
}

class HeaderFooterPageImpl extends StatefulWidget {
  @override
  _HeaderFooterPageImpl createState() => _HeaderFooterPageImpl();
}

class _HeaderFooterPageImpl extends State<HeaderFooterPageImpl> {
  final Future<int> loadDataAsync = Future<int>.delayed(
    Duration(seconds: 1), () async => processDataAsync(),
  );

  static Future<int> processDataAsync() async {
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// https://pritomkumar.blogspot.com/2021/10/flutter-design-application-with.html

        /// header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Colors.amber,
          child: const Text("Fixed Header"),
        ),


        /// content
        Expanded(
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {

              return Column(
                children: [
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                ),
                                child: Center(
                                  child: Text('Child $index'),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                  )
                ],
              );
            },
            future: loadDataAsync,
          ),
        ),


        /// footer
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Colors.amber,
          child: const Text("Fixed Header"),
        ),

      ],
    );
  }
}

class ApplicationAppBar extends AppBar {
  ApplicationAppBar() : super(
    title: Text("Fixed Header & Footer"),
    actions: [
      IconButton(icon: Icon(Icons.add), onPressed: () {}),
    ],
  );
}
