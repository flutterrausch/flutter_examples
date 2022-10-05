import 'package:flutter/material.dart';
import 'package:network_basics/http_page_manager.dart';

class HttpPage extends StatelessWidget {
  final stateManager = HttpPageManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Http'),),
        body: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Wrap(
                spacing: 50,
                alignment: WrapAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: stateManager.postAuthRequest,
                    child: Text('AUTH'),
                  ),

                  ElevatedButton(
                    onPressed: stateManager.getMonitoringValues,
                    child: Text('MonitoringVals'),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20),
            ValueListenableBuilder<RequestState>(
              valueListenable: stateManager.resultNotifier,
              builder: (context, requestState, child) {
                if (requestState is RequestLoadInProgress) {
                  return CircularProgressIndicator();
                } else if (requestState is RequestLoadSuccess) {
                  return Expanded(child: SingleChildScrollView(child: Text(requestState.body)));
                } else {
                  return Container();
                }
              },
            ),
          ],
        )
      );
    }
}
