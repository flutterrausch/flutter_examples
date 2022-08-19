import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/main_screen.dart';

final textFormFieldProvider = StateProvider((ref) => '');

class FormStateProviderPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form StateProvider'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,1}'))],
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Gewicht (kg)',
                hintText: '80',
              ),
              onChanged: (val) {
                ref.read(textFormFieldProvider.state).state = val;
              },
            ),
            Description(),
            Text('regex limits to decimal'),
            const SizedBox(height: 50,),

            Consumer(
              builder: (context, ref, child) {
                final inputText = ref.watch(textFormFieldProvider.state).state;
                return Text(inputText);
              },
            ),

          ],
        ),
      ),
    );
  }
}
