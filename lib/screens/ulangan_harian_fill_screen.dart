import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../data/local/database.dart';
import '../providers/absensi_providers.dart';
import '../providers/daily_test_providers.dart';
import '../widgets/ui_kit.dart';

class UlanganHarianFillScreen extends ConsumerStatefulWidget {
  const UlanganHarianFillScreen({super.key, required this.meeting});

  final DailyTestMeetingRecord meeting;

  @override
  ConsumerState<UlanganHarianFillScreen> createState() =>
      _UlanganHarianFillScreenState();
}

class _UlanganHarianFillScreenState
    extends ConsumerState<UlanganHarianFillScreen> {
  final _searchController = TextEditingController();
  final _scoreOverrides = <int, String>{};
  final _scoreControllers = <int, TextEditingController>{};
  final _saved = <int>{};
  bool _savingAll = false;

  @override
  void dispose() {
    _searchController.dispose();
    for (final controller in _scoreControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  static String _formatScore(double? value) {
    if (value == null) {
      return '';
    }
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  TextEditingController _scoreControllerFor(int studentId, String initial) {
    return _scoreControllers.putIfAbsent(
      studentId,
      () => TextEditingController(text: initial),
    );
  }

  /// Returns the valid score, or null when the field is empty.
  /// Throws [FormatException] when the value is not a number in 0..100.
  double? _parseScore(String raw) {
    final normalized = raw.replaceAll(',', '.').trim();
    if (normalized.isEmpty) {
      return null;
    }
    final value = double.tryParse(normalized);
    if (value == null || value < 0 || value > 100) {
      throw const FormatException('Nilai harus berupa angka antara 0 dan 100.');
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final meeting = widget.meeting;
    final students = meeting.classId == null
        ? const <CachedStudent>[]
        : ref.watch(classStudentsProvider(meeting.classId!)).value ??
              const <CachedStudent>[];
    final scores =
        ref.watch(dailyTestScoresProvider(meeting.localId)).value ??
        const <DailyTestScoreRecord>[];

    final scoreMap = {for (final s in scores) s.studentId: s};
    final query = _searchController.text.trim().toLowerCase();
    final filtered = students
        .where((s) => query.isEmpty || s.name.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: palette.pageBg,
      appBar: AppBar(
        title: const Text('Isi Nilai Ulangan'),
        shape: Border(bottom: BorderSide(color: palette.borderColor)),
        actions: [
          TextButton.icon(
            onPressed: _savingAll
                ? null
                : () => _saveAll(students, scoreMap),
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
                Text(
                  '${meeting.className ?? '-'} • ${formatTanggal(meeting.testDate)}',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: palette.body),
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
                scoreMap[student.id],
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
    DailyTestMeetingRecord meeting,
    CachedStudent student,
    DailyTestScoreRecord? existing,
  ) {
    final palette = context.palette;
    final hasOverride = _scoreOverrides.containsKey(student.id);
    final scoreText =
        _scoreOverrides[student.id] ?? _formatScore(existing?.score);
    final controller = _scoreControllerFor(student.id, scoreText);
    final isSaved =
        _saved.contains(student.id) || (existing != null && !hasOverride);

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
                const AppBadge(label: 'Tersimpan', tone: BadgeTone.emerald)
              else
                const AppBadge(label: 'Belum', tone: BadgeTone.amber),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 96,
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (value) => setState(() {
                    _scoreOverrides[student.id] = value;
                    _saved.remove(student.id);
                  }),
                  decoration: const InputDecoration(
                    hintText: '0-100',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _saveOne(meeting, student, controller),
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveOne(
    DailyTestMeetingRecord meeting,
    CachedStudent student,
    TextEditingController controller,
  ) async {
    final double? score;
    try {
      score = _parseScore(controller.text);
    } on FormatException catch (e) {
      _showMessage(e.message);
      return;
    }
    if (score == null) {
      _showMessage('Nilai ${student.name} belum diisi.');
      return;
    }

    try {
      await ref
          .read(dailyTestActionsProvider)
          .saveScore(
            meeting: meeting,
            studentId: student.id,
            score: score,
          );
      if (mounted) {
        setState(() => _saved.add(student.id));
      }
    } catch (e) {
      _showMessage('Gagal menyimpan nilai: $e');
    }
  }

  Future<void> _saveAll(
    List<CachedStudent> students,
    Map<int, DailyTestScoreRecord> scoreMap,
  ) async {
    final toSave = <int, double>{};
    for (final student in students) {
      final controller = _scoreControllerFor(
        student.id,
        _formatScore(scoreMap[student.id]?.score),
      );
      final double? score;
      try {
        score = _parseScore(controller.text);
      } on FormatException catch (e) {
        _showMessage('${student.name}: ${e.message}');
        return;
      }
      if (score != null) {
        toSave[student.id] = score;
      }
    }

    setState(() => _savingAll = true);
    final actions = ref.read(dailyTestActionsProvider);
    try {
      for (final entry in toSave.entries) {
        await actions.saveScore(
          meeting: widget.meeting,
          studentId: entry.key,
          score: entry.value,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _savingAll = false);
        _showMessage('Gagal menyimpan nilai: $e');
      }
      return;
    }

    if (mounted) {
      setState(() => _savingAll = false);
      _showMessage('Nilai ulangan berhasil disimpan.');
      Navigator.of(context).pop();
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
