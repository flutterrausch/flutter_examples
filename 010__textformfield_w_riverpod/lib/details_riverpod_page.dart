import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/backbutton_dialog.dart';

final savedText = StateProvider((ref) => 'init');

class DetailsRiverpodPage extends ConsumerStatefulWidget {

  @override
  _DetailsRiverpodPageState createState() => _DetailsRiverpodPageState();
}

class _DetailsRiverpodPageState extends ConsumerState {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // final String value1 = ref.read(savedText);  // why is this a string?
    // debugPrint('value1 = $value1');
    // _controller.text = value1;
    //
    // final String value2 = ref.read(savedText.state).state;
    // debugPrint('value2 = $value2');
    // _controller.text = value2;

    _controller.text = ref.read(savedText);  // same as  ref.read(savedText.state).state
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.text == ref.read(savedText.state).state) {
          return true;  // no change = no data can be lost, pop
        } else {
          return BackButtonDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details riverpod'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Consumer(
                builder: (context, ref, _) {
                  return Text('Saved text: ' + ref.watch(savedText));  // same as  ref.watch(savedText.state).state)
                }
              ),

              const SizedBox(height: 16),
              TextField(controller: _controller),

              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  ref.read(savedText.state).state = _controller.text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
