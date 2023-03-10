import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final counterProvider = StateProvider<int>((ref) => 0);  // init to 0

class CounterStateproviderPage extends ConsumerWidget {
  const CounterStateproviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);  // watch to notify UI updates of 'counter'

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider (counter)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $counter'),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;  // increment
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
