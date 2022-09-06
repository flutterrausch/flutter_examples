import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/backbutton_dialog.dart';

final savedText = StateProvider((ref) => 'init');

class DetailsRiverpodPage extends ConsumerStatefulWidget {

  @override
  _DetailsRiverpodPageState createState() => _DetailsRiverpodPageState();
  //ConsumerState<DetailsRiverpodPage> createState() => _DetailsRiverpodPageState();
}

class _DetailsRiverpodPageState extends ConsumerState {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //final value = ref.read(savedText);
    //_controller.text = ref.read(savedText.state).state;  // TODO init   _controller.text = ref.read(savedText.state).state  https://stackoverflow.com/a/64218048
  }

  @override
  // Widget build(BuildContext context, WidgetRef ref) {
  Widget build(BuildContext context) {
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
