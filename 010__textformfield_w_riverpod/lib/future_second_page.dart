import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/future_two_pages.dart';  // for apiFutureProvider
import 'main.dart';

class FutureSecondPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiFuture = ref.watch(apiFutureProvider);  // ref for apiFutureProvider from previous page

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future 2nd Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                //ref.read(textFieldProvider.state).state = val;
              },
            ),
            Description(),
            const SizedBox(height: 50,),

            apiFuture.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, stack) => Text('Error: $e'),
              data: (val) {
                return Text('val = $val');
              },
            ),

          ],
        ),
      ),
    );
  }
}
