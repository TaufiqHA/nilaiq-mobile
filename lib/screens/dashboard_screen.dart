import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../models/dashboard_data.dart';
import '../providers/dashboard_provider.dart';
import '../providers/sync_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ui_kit.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final asyncState = ref.watch(dashboardProvider);
    final syncStatus = ref.watch(syncControllerProvider);

    return MainScaffold(
      title: 'Dashboard',
      route: '/dashboard',
      actions: [
        IconButton(
          tooltip: 'Sinkronkan',
          onPressed: syncStatus.syncing
              ? null
              : () => ref.read(syncControllerProvider.notifier).sync(),
          icon: syncStatus.syncing
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.sync),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () => ref.read(dashboardProvider.notifier).refresh(),
        child: asyncState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: 120),
              EmptyState(
                icon: Icons.error_outline,
                title: 'Gagal memuat dashboard',
                subtitle: e.toString(),
              ),
            ],
          ),
          data: (state) {
            final data = state.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SyncBanner(),
                if (data == null)
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: EmptyState(
                      icon: Icons.cloud_off_outlined,
                      title: 'Belum ada data tersimpan',
                      subtitle:
                          'Hubungkan ke internet lalu tarik untuk memuat data.',
                    ),
                  )
                else ...[
                  _StatGrid(data: data),
                  const SizedBox(height: 16),
                  _LearningInfoCard(state: state),
                  const SizedBox(height: 16),
                  _AssessmentSummaryCard(state: state),
                  const SizedBox(height: 16),
                  _LatestStudentsCard(state: state),
                  const SizedBox(height: 16),
                  _RecentActivitiesCard(state: state),
                  if (state.fetchedAt != null) ...[
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Data per ${formatTanggalWaktu(state.fetchedAt!)}',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: palette.disabled),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.sizeOf(context).width >= 600 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        StatCard(
          label: 'Siswa Aktif',
          value: '${data.totalStudents}',
          valueSuffix: 'siswa',
          icon: Icons.groups_outlined,
        ),
        StatCard(
          label: 'Jumlah Kelas',
          value: '${data.totalClasses}',
          valueSuffix: 'kelas',
          icon: Icons.meeting_room_outlined,
        ),
        StatCard(
          label: 'Tahun Ajaran',
          value: data.hasActiveYear ? data.academicYearLabel : 'Belum Aktif',
          caption: data.hasActiveYear
              ? 'Semester ${_titleCase(data.semesterLabel)}'
              : null,
          icon: Icons.calendar_today_outlined,
        ),
        StatCard(
          label: 'Rata-rata Kehadiran',
          value: '${data.attendanceRate}%',
          icon: Icons.check_circle_outline,
        ),
      ],
    );
  }
}

class _LearningInfoCard extends StatelessWidget {
  const _LearningInfoCard({required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final data = state.data!;
    final score = data.minimumScore;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            icon: Icons.menu_book_outlined,
            title: 'Informasi Pembelajaran',
          ),
          const SizedBox(height: 14),
          _field(
            context,
            'MATA PELAJARAN',
            data.subjectName ?? 'Belum Diatur',
            brand: false,
          ),
          const Divider(height: 22),
          _field(
            context,
            'KKM (BATAS MINIMAL)',
            score == null ? 'Belum Diatur' : '${score.round()}',
            brand: true,
          ),
          const Divider(height: 22),
          _field(
            context,
            'GURU PENGAMPU',
            data.teacherName ?? 'Belum Diatur',
            brand: false,
          ),
          const SizedBox(height: 12),
          Text(
            'Dapat diubah melalui website.',
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: palette.body, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _field(
    BuildContext context,
    String label,
    String value, {
    required bool brand,
  }) {
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: palette.body,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: brand ? palette.brand : palette.heading,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _AssessmentSummaryCard extends StatelessWidget {
  const _AssessmentSummaryCard({required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final data = state.data!;
    final items = [
      ('Ulangan Harian', data.dailyTestCount),
      ('Tugas Mandiri', data.assignmentCount),
      ('Ujian Tengah Sem.', data.midtermCount),
      ('Ujian Akhir Sem.', data.finalCount),
    ];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            icon: Icons.assignment_outlined,
            title: 'Ringkasan Agenda Penilaian',
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.6,
            children: [
              for (final item in items)
                Container(
                  decoration: BoxDecoration(
                    color: palette.secondarySoft,
                    borderRadius: BorderRadius.circular(AppPalette.radius),
                    border: Border.all(color: palette.borderColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${item.$2}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: palette.heading,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        item.$1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: palette.body),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: palette.brandSoft,
              borderRadius: BorderRadius.circular(AppPalette.radius),
              border: Border.all(color: palette.brand.withValues(alpha: 0.2)),
            ),
            child: Text(
              'Bobot penilaian aktif — Ulangan Harian (${data.weights.dailyTest}%), '
              'Tugas (${data.weights.assignment}%), UTS (${data.weights.midterm}%), '
              'UAS (${data.weights.finalExam}%).',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: palette.heading),
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestStudentsCard extends StatelessWidget {
  const _LatestStudentsCard({required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final students = state.data!.latestStudents;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            icon: Icons.person_add_alt_outlined,
            title: 'Siswa Terbaru',
          ),
          const SizedBox(height: 8),
          if (students.isEmpty)
            Text(
              'Belum ada data siswa.',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: palette.body),
            )
          else
            for (final s in students)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.name,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: palette.heading,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            'NIS: ${s.nis} | Kelas: ${s.className ?? 'N/A'}',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: palette.body),
                          ),
                        ],
                      ),
                    ),
                    AppBadge(
                      label: s.status,
                      tone: s.status == 'ACTIVE'
                          ? BadgeTone.emerald
                          : BadgeTone.rose,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class _RecentActivitiesCard extends StatelessWidget {
  const _RecentActivitiesCard({required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final activities = state.data!.recentActivities;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            icon: Icons.schedule_outlined,
            title: 'Agenda Penilaian Terbaru',
          ),
          const SizedBox(height: 8),
          if (activities.isEmpty)
            Text(
              'Belum ada agenda penilaian.',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: palette.body),
            )
          else
            for (final a in activities)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.title,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: palette.heading,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            '${a.type} | Kelas: ${a.className ?? '-'}',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: palette.body),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatTanggalIso(a.date),
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: palette.disabled),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

/// Turns an ALL-CAPS value like `GANJIL` into `Ganjil`.
String _titleCase(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value
      .toLowerCase()
      .split(' ')
      .map(
        (word) => word.isEmpty
            ? word
            : '${word[0].toUpperCase()}${word.substring(1)}',
      )
      .join(' ');
}
