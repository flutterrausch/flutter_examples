import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


// official example  https://riverpod.dev/docs/essentials/first_request

const String baseUrl = 'boredapi.com';
const String endpoint = '/api/activity';


/// Model
class Activity {  // GET endpoint
  final String key;
  final String activity;
  final String type;
  final int participants;
  final double price;

  Activity({
    required this.key,
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    });

  // Convert a JSON object into an [Activity] instance for type-safe reading of the API response
  factory Activity.fromJson(Map<String, dynamic> json) {
    try {
      return Activity(  // convert manually - freezed or json_serializable recommended
        key: json['key'] as String,
        activity: json['activity'] as String,
        type: json['type'] as String,
        participants: json['participants'] as int,
        price: (json['price'] as num).toDouble(),  // as double throws exception
      );
    } catch (e) {
      debugPrint('Failed to convert Activity: $e');
      throw Exception('Failed to convert Activity: $e');
    }
  }
}


/// Provider
final activityProvider = FutureProvider.autoDispose((ref) async {
  final response = await http.get(Uri.https(baseUrl, endpoint));
  final json = jsonDecode(response.body) as Map<String, dynamic>;  // dart:convert decodes JSON payload into a Map
  return Activity.fromJson(json);  // convert the Map into an Activity instance
});


/// UI
class NetworkFutureproviderPage extends ConsumerWidget {
  const NetworkFutureproviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Activity> activity = ref.watch(activityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider (network)'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            activity.when(
              loading: () => const CircularProgressIndicator(),
              data: (value) {
                String msg = '${value.activity}\n\n';
                msg += '${value.type}  ${value.key}\n';
                msg += 'participants = ${value.participants}\n';
                msg += 'price = ${value.price}\n';
                return Text(msg);
              },
              error: (e, stack) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}