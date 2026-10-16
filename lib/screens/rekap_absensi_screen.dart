import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api_exception.dart';
import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../providers/infrastructure_providers.dart';
import '../widgets/ui_kit.dart';

final rekapProvider = FutureProvider.family<Map<String, dynamic>, int>(
  (ref, classId) => ref.watch(absensiApiProvider).rekap(classId),
);

class RekapAbsensiScreen extends ConsumerWidget {
  const RekapAbsensiScreen({
    super.key,
    required this.classId,
    required this.className,
  });

  final int classId;
  final String className;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final async = ref.watch(rekapProvider(classId));

    return Scaffold(
      backgroundColor: palette.pageBg,
      appBar: AppBar(
        title: Text('Rekap • $className'),
        shape: Border(bottom: BorderSide(color: palette.borderColor)),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: EmptyState(
            icon: Icons.cloud_off_outlined,
            title: 'Tidak dapat memuat rekap',
            subtitle: e is ApiException
                ? e.message
                : 'Rekap absensi membutuhkan koneksi internet.',
          ),
        ),
        data: (data) => _RekapTable(data: data),
      ),
    );
  }
}

class _RekapTable extends StatelessWidget {
  const _RekapTable({required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final students = (data['students'] as List?) ?? const [];
    final meetings = (data['meetings'] as List?) ?? const [];
    final attendances = (data['attendances'] as Map?) ?? const {};

    if (students.isEmpty || meetings.isEmpty) {
      return const EmptyState(
        icon: Icons.table_chart_outlined,
        title: 'Belum ada data rekap',
        subtitle: 'Buat pertemuan dan isi absensi terlebih dahulu.',
      );
    }

    Map<String, dynamic> recordsFor(int studentId) {
      final raw = attendances[studentId.toString()];
      if (raw is List) {
        return {
          for (final r in raw.whereType<Map>())
            (r['attendance_meeting_id']).toString(): r['status'],
        };
      }
      return {};
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll(palette.secondarySoft),
          columnSpacing: 18,
          columns: [
            const DataColumn(label: Text('Nama')),
            for (var i = 0; i < meetings.length; i++)
              DataColumn(
                label: Text(
                  'P${i + 1}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                tooltip: _meetingLabel(meetings[i]),
              ),
          ],
          rows: [
            for (final s in students.whereType<Map>())
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      (s['name'] ?? '-').toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  for (final m in meetings.whereType<Map>())
                    DataCell(
                      _statusCell(
                        context,
                        recordsFor(
                          s['id'] as int,
                        )[m['id'].toString()]?.toString(),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _statusCell(BuildContext context, String? status) {
    final color = _statusColor(status, context.palette);
    return Center(
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          _shortStatus(status),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  static String _shortStatus(String? status) {
    switch (status) {
      case 'HADIR':
        return 'H';
      case 'IZIN':
        return 'I';
      case 'SAKIT':
        return 'S';
      case 'ALFA':
        return 'A';
      default:
        return '-';
    }
  }

  static Color _statusColor(String? status, AppPalette palette) {
    switch (status) {
      case 'HADIR':
        return const Color(0xFF059669);
      case 'IZIN':
        return const Color(0xFF2563EB);
      case 'SAKIT':
        return const Color(0xFFD97706);
      case 'ALFA':
        return palette.danger;
      default:
        return palette.disabled;
    }
  }

  static String _meetingLabel(dynamic meeting) {
    if (meeting is Map) {
      final title = meeting['title']?.toString() ?? '';
      final date = meeting['meeting_date']?.toString() ?? '';
      return '$title\n${formatTanggalIso(date)}';
    }
    return '';
  }
}
