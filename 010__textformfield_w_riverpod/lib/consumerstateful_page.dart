import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final helloWorldProvider = Provider((_) => 'Hello world');

class ConsumerStatefulPage extends ConsumerStatefulWidget {
  @override
  _ConsumerStatefulPageState createState() => _ConsumerStatefulPageState();
}

class _ConsumerStatefulPageState extends ConsumerState {

  @override
  void initState() {
    super.initState();

    final value1 = ref.read(helloWorldProvider);  // Hello world
    debugPrint('value1 = $value1');
  }

  @override
  Widget build(BuildContext context) {
    final value2 = ref.watch(helloWorldProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod ConsumerStateful basics'),
      ),
      body: Text(value2),  // Hello world
    );
  }
}