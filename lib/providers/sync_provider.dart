import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'infrastructure_providers.dart';

class SyncStatus {
  const SyncStatus({
    this.syncing = false,
    this.lastSyncedAt,
    this.lastMessage,
    this.lastPushed = 0,
    this.lastFailed = 0,
  });

  final bool syncing;
  final DateTime? lastSyncedAt;
  final String? lastMessage;
  final int lastPushed;
  final int lastFailed;
}

final syncControllerProvider = NotifierProvider<SyncController, SyncStatus>(
  SyncController.new,
);

class SyncController extends Notifier<SyncStatus> {
  @override
  SyncStatus build() => const SyncStatus();

  Future<void> sync() async {
    if (state.syncing) {
      return;
    }
    state = SyncStatus(
      syncing: true,
      lastSyncedAt: state.lastSyncedAt,
      lastMessage: state.lastMessage,
    );

    var online = false;
    var pushed = 0;
    var failed = 0;
    String? message;
    try {
      final result = await ref.read(syncServiceProvider).synchronize();
      online = result.online;
      pushed = result.pushed;
      failed = result.failed;
      message = result.message;
    } catch (e) {
      failed = 1;
      message = 'Sinkronisasi gagal: $e';
    }

    state = SyncStatus(
      syncing: false,
      lastSyncedAt: online ? DateTime.now() : state.lastSyncedAt,
      lastMessage: message,
      lastPushed: pushed,
      lastFailed: failed,
    );
  }
}

/// Number of operations still waiting to be uploaded.
final pendingCountProvider = StreamProvider<int>(
  (ref) => ref.watch(databaseProvider).watchPendingCount(),
);

/// Creation time of the oldest unsynced operation.
final pendingOldestProvider = StreamProvider<DateTime?>(
  (ref) => ref.watch(databaseProvider).watchOldestPendingCreatedAt(),
);
