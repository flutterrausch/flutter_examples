import 'package:flutter/material.dart';
import 'package:textformfield_w_riverpod/main.dart';

final myController = TextEditingController();


// There is also myController.addListener(someFunction):
// https://docs.flutter.dev/cookbook/forms/text-field-changes
//  - not clear how it's "more powerful" than onChanged()


class ControllerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextEditingController'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: myController,  // connect TextEditingController to specific TextField
            ),
            Description(),

            ElevatedButton(
              child: Text('Press me'),
              onPressed: () {
                print('textfield = ' + myController.text);  // read value of TextEditingController
              },
            )

          ],
        ),
      ),
    );
  }
}
