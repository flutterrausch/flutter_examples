import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authRepositoryProvider = Provider<AuthService>((ref) { return AuthService(); });

final authFutureProvider = FutureProvider.autoDispose<String>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getToken();
});


const int seconds = 3;

class AuthService {
  Future<String> getToken() async {
    await Future.delayed(Duration(seconds: seconds));
    return 'access token dummy';
  }
}


class FutureProviderPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiFuture = ref.watch(authFutureProvider);  // instance

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future provider page'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text('Future starts now ($seconds sec) - simulating API access'),
            const SizedBox(height: 50,),

            apiFuture.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, stack) => Text('Error: $e'),
              data: (value) {
                return Text('response = $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}