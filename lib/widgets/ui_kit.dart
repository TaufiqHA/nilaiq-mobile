import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/env.dart';
import '../core/theme/app_colors.dart';
import '../providers/sync_provider.dart';

/// Rounded, bordered surface matching the website cards.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final content = Padding(padding: padding, child: child);

    return Material(
      color: palette.cardBg,
      borderRadius: BorderRadius.circular(AppPalette.radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppPalette.radius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppPalette.radius),
            border: Border.all(color: palette.borderColor),
          ),
          child: content,
        ),
      ),
    );
  }
}

/// Statistic card with a brand-tinted icon chip (dashboard top row).
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.valueSuffix,
    this.caption,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? valueSuffix;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: palette.body,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: palette.brandSoft,
                  borderRadius: BorderRadius.circular(AppPalette.radiusXs),
                ),
                child: Icon(icon, size: 16, color: palette.brand),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: palette.heading,
                  ),
                ),
                if (valueSuffix != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    valueSuffix!,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: palette.body),
                  ),
                ],
              ],
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: 8),
            Text(
              caption!,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: palette.body),
            ),
          ],
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Icon(icon, size: 18, color: palette.brand),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w800, color: palette.heading),
        ),
      ],
    );
  }
}

/// Small pill badge. [tone] controls the color family.
class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.label, required this.tone});

  final String label;
  final BadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors(Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.$3),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: colors.$2, fontWeight: FontWeight.w700),
      ),
    );
  }
}

enum BadgeTone { sky, amber, emerald, purple, rose, neutral }

extension _BadgeColors on BadgeTone {
  (Color, Color, Color) colors(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    switch (this) {
      case BadgeTone.sky:
        return dark
            ? (
                const Color(0x1F0EA5E9),
                const Color(0xFF7DD3FC),
                const Color(0x330EA5E9),
              )
            : (
                const Color(0xFFE0F2FE),
                const Color(0xFF0369A1),
                const Color(0xFFBAE6FD),
              );
      case BadgeTone.amber:
        return dark
            ? (
                const Color(0x1FF59E0B),
                const Color(0xFFFCD34D),
                const Color(0x33F59E0B),
              )
            : (
                const Color(0xFFFEF3C7),
                const Color(0xFFB45309),
                const Color(0xFFFDE68A),
              );
      case BadgeTone.emerald:
        return dark
            ? (
                const Color(0x1F10B981),
                const Color(0xFF6EE7B7),
                const Color(0x3310B981),
              )
            : (
                const Color(0xFFD1FAE5),
                const Color(0xFF047857),
                const Color(0xFFA7F3D0),
              );
      case BadgeTone.purple:
        return dark
            ? (
                const Color(0x1FA855F7),
                const Color(0xFFD8B4FE),
                const Color(0x33A855F7),
              )
            : (
                const Color(0xFFF3E8FF),
                const Color(0xFF7E22CE),
                const Color(0xFFE9D5FF),
              );
      case BadgeTone.rose:
        return dark
            ? (
                const Color(0x1FF43F5E),
                const Color(0xFFFDA4AF),
                const Color(0x33F43F5E),
              )
            : (
                const Color(0xFFFFE4E6),
                const Color(0xFFBE123C),
                const Color(0xFFFECDD3),
              );
      case BadgeTone.neutral:
        return dark
            ? (
                const Color(0x1F94A3B8),
                const Color(0xFFCBD5E1),
                const Color(0x3394A3B8),
              )
            : (
                const Color(0xFFF1F5F9),
                const Color(0xFF475569),
                const Color(0xFFE2E8F0),
              );
    }
  }
}

BadgeTone tipeTone(String tipe) {
  switch (tipe) {
    case 'harian':
      return BadgeTone.sky;
    case 'ulang harian':
      return BadgeTone.amber;
    case 'tugas':
      return BadgeTone.emerald;
    case 'pts':
      return BadgeTone.purple;
    case 'pas':
      return BadgeTone.rose;
    default:
      return BadgeTone.neutral;
  }
}

String tipeLabel(String tipe) {
  switch (tipe) {
    case 'harian':
      return 'Harian';
    case 'ulang harian':
      return 'Ulangan Harian';
    case 'tugas':
      return 'Tugas';
    case 'pts':
      return 'PTS';
    case 'pas':
      return 'PAS';
    default:
      return tipe;
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: palette.disabled),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: palette.heading,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: palette.body),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Banner that reports pending offline data and warns after 5 days.
class SyncBanner extends ConsumerWidget {
  const SyncBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final pending = ref.watch(pendingCountProvider).value ?? 0;
    final oldest = ref.watch(pendingOldestProvider).value;
    final sync = ref.watch(syncControllerProvider);
    final syncing = sync.syncing;

    final days = oldest == null ? 0 : DateTime.now().difference(oldest).inDays;
    final hasError = sync.lastFailed > 0 && sync.lastMessage != null;
    final isWarning = days >= Env.offlineWarningDays || hasError;

    if (pending == 0) {
      return const SizedBox.shrink();
    }

    final color = isWarning ? palette.danger : palette.brand;
    final label = hasError
        ? sync.lastMessage!
        : isWarning
        ? 'Ada $pending data belum ter-upload selama $days hari. Segera hubungkan internet.'
        : '$pending data menunggu disinkronkan ke server.';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWarning ? palette.dangerSoft : palette.brandSoft,
        borderRadius: BorderRadius.circular(AppPalette.radius),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isWarning ? Icons.error_outline : Icons.cloud_upload_outlined,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: palette.heading),
            ),
          ),
          if (syncing)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            TextButton(
              onPressed: () => ref.read(syncControllerProvider.notifier).sync(),
              child: const Text('Sync'),
            ),
        ],
      ),
    );
  }
}
