import 'package:flutter/material.dart';
import 'package:textformfield_w_riverpod/main_screen.dart';

class OnChangedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnChanged'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (nameProvider) {
                print('TextField: $nameProvider');
              },
            ),
            Description(),
          ],
        ),
      ),
    );
  }
}
