import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository _repo;
  AuthNotifier(this._repo) : super(AuthStatus.unknown) {
    _init();
  }

  Future<void> _init() async {
    state = (await _repo.isAuthenticated())
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> sendCode(String phoneNumber) async {
    await _repo.sendCode(phoneNumber: phoneNumber);
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await _repo.logout();
    state = AuthStatus.unauthenticated;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authNotifierProvider =
StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthNotifier(repo);
});
