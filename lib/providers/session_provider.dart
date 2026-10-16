import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'infrastructure_providers.dart';

final sessionProvider = AsyncNotifierProvider<SessionController, AppUser?>(
  SessionController.new,
);

class SessionController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final user = await ref.read(authRepositoryProvider).restoreSession();
    return user == null ? null : AppUser.fromJson(user);
  }

  Future<void> login({required String email, required String password}) async {
    final user = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    state = AsyncData(AppUser.fromJson(user));
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}
