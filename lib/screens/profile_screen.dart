import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/env.dart';
import '../core/theme/app_colors.dart';
import '../providers/session_provider.dart';
import '../providers/sync_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ui_kit.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final user = ref.watch(sessionProvider).value;
    final themeMode = ref.watch(themeModeProvider);
    final sync = ref.watch(syncControllerProvider);

    return MainScaffold(
      title: 'Profil',
      route: '/profile',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: palette.brand,
                  child: Text(
                    user?.initials ?? '?',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? '-',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: palette.heading,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.email ?? '-',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: palette.body),
                      ),
                      const SizedBox(height: 6),
                      AppBadge(label: 'Guru Mapel', tone: BadgeTone.sky),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SwitchListTile(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (_) =>
                      ref.read(themeModeProvider.notifier).toggle(),
                  title: const Text('Mode Gelap'),
                  subtitle: const Text('Sesuaikan tampilan aplikasi'),
                  secondary: Icon(
                    Icons.dark_mode_outlined,
                    color: palette.body,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.sync, color: palette.body),
                  title: const Text('Sinkronkan Sekarang'),
                  subtitle: Text(
                    sync.lastSyncedAt == null
                        ? 'Belum pernah sinkron'
                        : 'Terakhir: ${_format(sync.lastSyncedAt!)}',
                  ),
                  trailing: sync.syncing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.chevron_right),
                  onTap: sync.syncing
                      ? null
                      : () => ref.read(syncControllerProvider.notifier).sync(),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.logout, color: palette.danger),
                  title: Text(
                    'Keluar',
                    style: TextStyle(color: palette.danger),
                  ),
                  onTap: () => ref.read(sessionProvider.notifier).logout(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  icon: Icons.info_outline,
                  title: 'Tentang Aplikasi',
                ),
                const SizedBox(height: 12),
                Text(
                  '${Env.appName} Mobile',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: palette.heading,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Server: ${Env.apiBaseUrl}',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: palette.body),
                ),
                const SizedBox(height: 4),
                Text(
                  'Peringatan data offline setelah ${Env.offlineWarningDays} hari.',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: palette.body),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _format(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}/${two(dt.month)}/${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }
}
