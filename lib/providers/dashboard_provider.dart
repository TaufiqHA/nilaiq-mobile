import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dashboard_data.dart';
import 'infrastructure_providers.dart';

class DashboardState {
  const DashboardState({
    this.data,
    this.fetchedAt,
    this.refreshing = false,
    this.error,
  });

  final DashboardData? data;
  final DateTime? fetchedAt;
  final bool refreshing;
  final String? error;

  bool get hasData => data != null;

  DashboardState copyWith({
    DashboardData? data,
    DateTime? fetchedAt,
    bool? refreshing,
    String? error,
    bool clearError = false,
  }) {
    return DashboardState(
      data: data ?? this.data,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      refreshing: refreshing ?? this.refreshing,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

final dashboardProvider =
    AsyncNotifierProvider<DashboardController, DashboardState>(
      DashboardController.new,
    );

class DashboardController extends AsyncNotifier<DashboardState> {
  @override
  Future<DashboardState> build() async {
    final cache = await ref.read(dashboardRepositoryProvider).cached();
    return DashboardState(
      data: cache == null ? null : DashboardData.fromJson(cache.payload),
      fetchedAt: cache?.fetchedAt,
    );
  }

  Future<void> refresh() async {
    final current = state.value ?? const DashboardState();
    state = AsyncData(current.copyWith(refreshing: true, clearError: true));

    try {
      await ref.read(dashboardRepositoryProvider).refresh();
      final cache = await ref.read(dashboardRepositoryProvider).cached();
      state = AsyncData(
        DashboardState(
          data: cache == null ? null : DashboardData.fromJson(cache.payload),
          fetchedAt: cache?.fetchedAt,
        ),
      );
    } catch (e) {
      state = AsyncData(
        current.copyWith(
          refreshing: false,
          error: 'Gagal memuat dashboard. Menampilkan data tersimpan.',
        ),
      );
    }
  }
}
