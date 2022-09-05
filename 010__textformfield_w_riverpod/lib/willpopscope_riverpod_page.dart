import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/backbutton_dialog.dart';

final savedText = StateProvider((ref) => '');

class WillPopScopeRiverpodPage extends ConsumerWidget {
  final _controller = TextEditingController();

  // TODO init   _controller.text = ref.read(savedText.state).state

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.text == ref.read(savedText.state).state) {  // no change = no data can be lost
          return true;
        } else {
          return BackButtonDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Backbutton riverpod'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, _) {
                  return Text('Saved text: ' + ref.watch(savedText.state).state);
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
