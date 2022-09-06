import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final helloWorldProvider = Provider((ref) => 'Hello world');

class ConsumerStatefulPage extends ConsumerStatefulWidget {
  @override
  _ConsumerStatefulPageState createState() => _ConsumerStatefulPageState();
}

class _ConsumerStatefulPageState extends ConsumerState {

  @override
  void initState() {
    super.initState();

    final String value1 = ref.read(helloWorldProvider);  // why is ref.read(helloWorldProvider.state).state not working here?
    debugPrint('value1 = $value1');  // Hello world
  }

  @override
  Widget build(BuildContext context) {
    final value2 = ref.watch(helloWorldProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ConsumerStateful basics'),
      ),
      body: Text(value2),  // Hello world
    );
  }
}