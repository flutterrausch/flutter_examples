import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/main.dart';

const seconds = 2;
Future<int> readApiValue() async {
  await Future.delayed(Duration(seconds: seconds));
  return 42;
}
void writeApiValue(val) async {
  debugPrint('API writing $val for $seconds sec..');
  await Future.delayed(Duration(seconds: seconds));
  debugPrint('..done');
  return;
}
final apiFutureProvider = FutureProvider.autoDispose<int>((ref) => readApiValue());  // autoDispose = restart on each visit

final txtEditCtrl = TextEditingController();


class FutureOnePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiFuture = ref.watch(apiFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future 1p push, back=cancel'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text('Future starts now ($seconds sec) - simulating API access'),
            const SizedBox(height: 50,),
            TextField(
              controller: txtEditCtrl,
              //  onChanged: (val) {},  // use controller
            ),
            Description(),

            apiFuture.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, stack) => Text('Error: $e'),
              data: (value) {
                txtEditCtrl.text = value.toString();  // init TextField text from readApi  TODO block Textfield until API value gets set
                return SizedBox.shrink();  // empty widget
              },
            ),

            const SizedBox(height: 50,),
            ElevatedButton(
              child: Text('Done'),
              onPressed: () {
                writeApiValue(txtEditCtrl.text);  // pop thru BackButton is not caught - cancels value changes
                Navigator.pop(context, txtEditCtrl.text);  // return data to MainScreen (which pushed to here)
              },
            )

          ],
        ),
      ),
    );
  }
}
