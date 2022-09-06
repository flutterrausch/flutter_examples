import 'package:flutter/material.dart';

class DetailsSetstatePage extends StatefulWidget {
  const DetailsSetstatePage({Key? key}) : super(key: key);

  @override
  _DetailsSetstatePageState createState() => _DetailsSetstatePageState();
}

class _DetailsSetstatePageState extends State<DetailsSetstatePage> {
  final TextEditingController _controller = TextEditingController();

  String savedText = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.text == savedText) {
          return true;
        }
        final Future<bool> result = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("All unsaved changes would be lost"),
            actions: [
              ElevatedButton(
                child: const Text('No'),
                onPressed: () {Navigator.pop(context, false);},
              ),
              ElevatedButton(
                child: const Text('Yes', style: TextStyle(color: Colors.red)),
                onPressed: () {Navigator.pop(context, true);},
              ),
            ],
          ),
        );
        return result;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Details setState'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Saved text: $savedText"),
              const SizedBox(height: 16),
              TextField(controller: _controller),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  setState(() {
                    savedText = _controller.text;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
