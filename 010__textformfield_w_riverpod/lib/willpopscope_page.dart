import 'package:flutter/material.dart';

class WillPopScopePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(  // span whole page
      onWillPop: () async {  // callback for pressed BackButton
        print('BackButton pressed');
        return false;  // pop/or not  =  enabled/disabled Backbutton  (necessary, non-null)
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Backbutton disabled'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 150,),
              const Text('Try Backbutton and Button'),
              const Text('+ check log'),

              const SizedBox(height: 50,),
              ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  print('Done pressed');
                  Navigator.pop(context);
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
