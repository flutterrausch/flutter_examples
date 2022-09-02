import 'package:flutter/material.dart';
import 'package:textformfield_w_riverpod/main.dart';

class WillPopScopePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {  // callback for pressing BackButton
        print('BackButton pressed');
        return false;  // pop/or not  =  enabled/disabled Backbutton  (necessary, non-null)
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WillPopScope'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 150,),
              Text('WillPopScope - try Backbutton and Button'),
              //Description(),

              const SizedBox(height: 50,),
              ElevatedButton(
                child: Text('Done'),
                onPressed: () {
                  print('Button pressed');
                  Navigator.pop(context, 'some value');
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
