import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const int seconds = 3;

class AuthService {
  Future<String> getToken() async {
    await Future.delayed(const Duration(seconds: seconds));
    return 'access token dummy';
  }
}


/// One provider solution:
// This simplifies the provider setup, but it also couples the AuthService creation
// and the token fetching logic together. This might reduce flexibility and testability
// compared to the two-provider setup.

final authTokenFutureProvider = FutureProvider.autoDispose<String>((ref) async {
  final authService = AuthService();
  return authService.getToken();
});


/// It does make sense to have two providers:
// The authProvider is a Provider that exposes an instance of AuthService.
// This service is responsible for fetching the authentication token, which
// is an asynchronous operation.
// The authTokenFutureProvider is a FutureProvider that depends on
// authProvider. It watches the authProvider and calls the getToken method
// from the AuthService instance. The FutureProvider will provide the future
// returned by getToken to its consumers and handle the different states of
// the future (loading, completed with data, or completed with an error).
// This separation of concerns makes the code more maintainable and testable.
// The AuthService can be tested independently of the UI logic, and the UI
// can be tested with a mock AuthService.
// This pattern also allows for better code reusability. If another part of
// the application needs to fetch the authentication token, it can consume
// the authTokenFutureProvider without having to know about the AuthService
// or how the token is fetched.
//
// final authProvider = Provider<AuthService>((ref) =>  AuthService());

// final authTokenFutureProvider = FutureProvider.autoDispose<String>((ref) async {
//   final authService = ref.watch(authProvider);
//   return authService.getToken();
// });


class WaitFutureproviderPage extends ConsumerWidget {
  const WaitFutureproviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<String> authTokenFuture = ref.watch(authTokenFutureProvider);  // instance, was always implicitely AsyncValue<String>

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider (wait)'),
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