import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../providers/session_provider.dart';
import '../providers/theme_provider.dart';

/// Set ke true untuk menampilkan menu yang masih berstatus "Segera".
/// Saat ini menu Dashboard, Absensi, dan Ulangan Harian sudah tersedia.
const bool _showComingSoonMenus = false;

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key, required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final user = ref.watch(sessionProvider).value;
    final themeMode = ref.watch(themeModeProvider);
    final isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return Drawer(
      backgroundColor: palette.cardBg,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  _BrandLogo(palette: palette, size: 34),
                  const SizedBox(width: 10),
                  Text(
                    'NilaiQ',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: palette.heading,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                children: [
                  _groupLabel(context, 'Menu Utama'),
                  _navItem(
                    context,
                    ref,
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    route: '/dashboard',
                  ),
                  const SizedBox(height: 16),
                  _groupLabel(context, 'Akademik'),
                  _navItem(
                    context,
                    ref,
                    icon: Icons.fact_check_outlined,
                    label: 'Absensi',
                    route: '/absensi',
                  ),
                  _navItem(
                    context,
                    ref,
                    icon: Icons.quiz_outlined,
                    label: 'Ulangan Harian',
                    route: '/ulangan-harian',
                  ),
                  if (_showComingSoonMenus) ...[
                    _comingSoon(context, Icons.assignment_outlined, 'Tugas'),
                    _comingSoon(
                      context,
                      Icons.assignment_late_outlined,
                      'PTS',
                    ),
                    _comingSoon(context, Icons.school_outlined, 'PAS'),
                    _comingSoon(
                      context,
                      Icons.grid_view_outlined,
                      'Rekap Nilai',
                    ),
                    const SizedBox(height: 16),
                    _groupLabel(context, 'Pengaturan'),
                    _comingSoon(
                      context,
                      Icons.storage_outlined,
                      'Master Data',
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: palette.brand,
                    child: Text(
                      user?.initials ?? '?',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: palette.heading,
                              ),
                        ),
                        Text(
                          user?.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: palette.body),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Ganti tema',
                    onPressed: () => ref
                        .read(themeModeProvider.notifier)
                        .setMode(isDark ? ThemeMode.light : ThemeMode.dark),
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: palette.body,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Keluar',
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await ref.read(sessionProvider.notifier).logout();
                      navigator.popUntil((route) => route.isFirst);
                    },
                    icon: Icon(Icons.logout, color: palette.body),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _groupLabel(BuildContext context, String label) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: palette.disabled,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required String label,
    required String route,
  }) {
    final palette = context.palette;
    final selected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected ? palette.tertiary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppPalette.radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppPalette.radius),
          onTap: () {
            Navigator.of(context).pop();
            if (!selected) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(route, (r) => r.isFirst);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: selected ? palette.brand : palette.body,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selected ? palette.brand : palette.body,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _comingSoon(BuildContext context, IconData icon, String label) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 22, color: palette.disabled),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: palette.disabled),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: palette.secondarySoft,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Segera',
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: palette.disabled),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  const _BrandLogo({required this.palette, this.size = 32});

  final AppPalette palette;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: palette.brand,
        borderRadius: BorderRadius.circular(size * 0.3),
        boxShadow: [
          BoxShadow(
            color: palette.brand.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.check_circle_outline,
        color: Colors.white,
        size: size * 0.62,
      ),
    );
  }
}

/// A scaffold used by every authenticated page: AppBar + [AppDrawer].
class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.title,
    required this.route,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  final String title;
  final String route;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.pageBg,
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        shape: Border(bottom: BorderSide(color: palette.borderColor)),
      ),
      drawer: AppDrawer(currentRoute: route),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
