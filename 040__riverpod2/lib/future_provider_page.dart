import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const int seconds = 3;

final authProvider = Provider<AuthService>((ref) =>  AuthService());

final authTokenFutureProvider = FutureProvider.autoDispose<String>((ref) {
  final authService = ref.watch(authProvider);
  return authService.getToken();
});

class AuthService {
  Future<String> getToken() async {
    await Future.delayed(const Duration(seconds: seconds));
    return 'access token dummy';
  }
}


class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokenFuture = ref.watch(authTokenFutureProvider);  // instance

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future provider page'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text('Future starts now ($seconds sec) - simulating API access'),
            const SizedBox(height: 50,),

            authTokenFuture.when(
              loading: () => const CircularProgressIndicator(),
              data: (value) => Text('response = $value'),
              error: (e, stack) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}