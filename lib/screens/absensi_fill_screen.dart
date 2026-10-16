import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../data/local/database.dart';
import '../providers/absensi_providers.dart';
import '../widgets/ui_kit.dart';

const _statuses = ['HADIR', 'IZIN', 'SAKIT', 'ALFA'];

class AbsensiFillScreen extends ConsumerStatefulWidget {
  const AbsensiFillScreen({super.key, required this.meeting});

  final MeetingRecord meeting;

  @override
  ConsumerState<AbsensiFillScreen> createState() => _AbsensiFillScreenState();
}

class _AbsensiFillScreenState extends ConsumerState<AbsensiFillScreen> {
  final _searchController = TextEditingController();
  final _statusOverrides = <int, String>{};
  final _noteOverrides = <int, String>{};
  final _noteControllers = <int, TextEditingController>{};
  final _saved = <int>{};
  bool _savingAll = false;

  @override
  void dispose() {
    _searchController.dispose();
    for (final controller in _noteControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _noteControllerFor(int studentId, String initial) {
    return _noteControllers.putIfAbsent(
      studentId,
      () => TextEditingController(text: initial),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final meeting = widget.meeting;
    final students = meeting.classId == null
        ? const <CachedStudent>[]
        : ref.watch(classStudentsProvider(meeting.classId!)).value ??
              const <CachedStudent>[];
    final attendances =
        ref.watch(meetingAttendancesProvider(meeting.localId)).value ??
        const <AttendanceRecord>[];

    final attendanceMap = {for (final a in attendances) a.studentId: a};
    final query = _searchController.text.trim().toLowerCase();
    final filtered = students
        .where((s) => query.isEmpty || s.name.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: palette.pageBg,
      appBar: AppBar(
        title: const Text('Isi Absensi'),
        shape: Border(bottom: BorderSide(color: palette.borderColor)),
        actions: [
          TextButton.icon(
            onPressed: _savingAll
                ? null
                : () => _saveAll(students, attendanceMap),
            icon: _savingAll
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.done_all),
            label: const Text('Selesai'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meeting.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: palette.heading,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    AppBadge(
                      label: tipeLabel(meeting.tipe),
                      tone: tipeTone(meeting.tipe),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${meeting.className ?? '-'} • ${formatTanggal(meeting.meetingDate)}',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: palette.body),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SyncBanner(),
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: 'Cari nama siswa...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 12),
          if (filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: EmptyState(
                icon: Icons.people_outline,
                title: 'Tidak ada siswa',
                subtitle: 'Belum ada data siswa untuk kelas ini.',
              ),
            )
          else
            for (final student in filtered) ...[
              _studentTile(
                context,
                meeting,
                student,
                attendanceMap[student.id],
              ),
              const SizedBox(height: 10),
            ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _studentTile(
    BuildContext context,
    MeetingRecord meeting,
    CachedStudent student,
    AttendanceRecord? existing,
  ) {
    final palette = context.palette;
    final status = _statusOverrides[student.id] ?? existing?.status ?? 'HADIR';
    final note = _noteOverrides[student.id] ?? existing?.note ?? '';
    final isSaved =
        _saved.contains(student.id) ||
        (existing != null &&
            !_statusOverrides.containsKey(student.id) &&
            !_noteOverrides.containsKey(student.id));

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: palette.heading,
                      ),
                    ),
                    if (student.nis != null)
                      Text(
                        'NIS: ${student.nis}',
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: palette.body),
                      ),
                  ],
                ),
              ),
              if (isSaved)
                AppBadge(label: 'Tersimpan', tone: BadgeTone.emerald)
              else
                AppBadge(label: 'Belum', tone: BadgeTone.amber),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final s in _statuses)
                ChoiceChip(
                  label: Text(s),
                  selected: status == s,
                  onSelected: (_) => setState(() {
                    _statusOverrides[student.id] = s;
                    _saved.remove(student.id);
                  }),
                  selectedColor: _statusColor(s, palette),
                  labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: status == s ? Colors.white : palette.body,
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor: palette.secondarySoft,
                  side: BorderSide(color: palette.borderColor),
                  showCheckmark: false,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _noteControllerFor(student.id, note),
                  onChanged: (value) {
                    _noteOverrides[student.id] = value;
                    _saved.remove(student.id);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Catatan...',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _saveOne(meeting, student, status, note),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status, AppPalette palette) {
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
        return palette.brand;
    }
  }

  Future<void> _saveOne(
    MeetingRecord meeting,
    CachedStudent student,
    String status,
    String note,
  ) async {
    try {
      await ref
          .read(absensiActionsProvider)
          .saveAttendance(
            meeting: meeting,
            studentId: student.id,
            status: status,
            note: note.isEmpty ? null : note,
          );
      if (mounted) {
        setState(() => _saved.add(student.id));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan absensi: $e')),
        );
      }
    }
  }

  Future<void> _saveAll(
    List<CachedStudent> students,
    Map<int, AttendanceRecord> attendanceMap,
  ) async {
    setState(() => _savingAll = true);
    final actions = ref.read(absensiActionsProvider);

    try {
      for (final student in students) {
        final status =
            _statusOverrides[student.id] ??
            attendanceMap[student.id]?.status ??
            'HADIR';
        final note =
            _noteOverrides[student.id] ?? attendanceMap[student.id]?.note ?? '';
        await actions.saveAttendance(
          meeting: widget.meeting,
          studentId: student.id,
          status: status,
          note: note.isEmpty ? null : note,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _savingAll = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan absensi: $e')),
        );
      }
      return;
    }

    if (mounted) {
      setState(() => _savingAll = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Absensi berhasil disimpan.')),
      );
      Navigator.of(context).pop();
    }
  }
}
