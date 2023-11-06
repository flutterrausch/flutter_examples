import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/main.dart';

final textFieldProvider = StateProvider<String>((ref) => '');

class StateProviderPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                ref.read(textFieldProvider.state).state = val;
              },
            ),
            Description(),
            const SizedBox(height: 50,),

            Consumer(
              builder: (context, ref, child) {
                final inputText = ref.watch(textFieldProvider.state).state;
                return Text(inputText);
              },
            ),
          ],
        ),
      ),
    );
  }
}
