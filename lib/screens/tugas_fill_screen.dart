import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../core/api_exception.dart';
import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../data/local/database.dart';
import '../providers/absensi_providers.dart';
import '../providers/assignment_providers.dart';
import '../providers/infrastructure_providers.dart';
import '../widgets/ui_kit.dart';

class TugasFillScreen extends ConsumerStatefulWidget {
  const TugasFillScreen({super.key, required this.meeting});

  final AssignmentMeetingRecord meeting;

  @override
  ConsumerState<TugasFillScreen> createState() => _TugasFillScreenState();
}

class _TugasFillScreenState extends ConsumerState<TugasFillScreen> {
  final _searchController = TextEditingController();
  final _scoreOverrides = <int, String>{};
  final _scoreControllers = <int, TextEditingController>{};
  final _saved = <int>{};
  final _imagePicker = ImagePicker();
  bool _savingAll = false;
  bool _scanning = false;

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
    final controller = _scoreControllers.putIfAbsent(
      studentId,
      () => TextEditingController(text: initial),
    );
    // Fill in a score that arrived from the cache/server after the first build.
    if (controller.text.isEmpty && initial.isNotEmpty) {
      controller.text = initial;
    }
    return controller;
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
        ref.watch(assignmentScoresProvider(meeting.localId)).value ??
        const <AssignmentScoreRecord>[];

    final scoreMap = {for (final s in scores) s.studentId: s};
    final query = _searchController.text.trim().toLowerCase();
    final filtered = students
        .where((s) => query.isEmpty || s.name.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: palette.pageBg,
      appBar: AppBar(
        title: const Text('Isi Nilai Tugas'),
        shape: Border(bottom: BorderSide(color: palette.borderColor)),
        actions: [
          TextButton.icon(
            onPressed: _savingAll || _scanning
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
                  '${meeting.className ?? '-'} • ${formatTanggal(meeting.assignmentDate)}',
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
          OutlinedButton.icon(
            onPressed: _scanning ? null : () => _scanScores(students),
            icon: _scanning
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.photo_camera_outlined),
            label: Text(_scanning ? 'Memproses gambar...' : 'Scan Foto Nilai'),
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
              _studentTile(context, meeting, student, scoreMap[student.id]),
              const SizedBox(height: 10),
            ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _studentTile(
    BuildContext context,
    AssignmentMeetingRecord meeting,
    CachedStudent student,
    AssignmentScoreRecord? existing,
  ) {
    final palette = context.palette;
    final hasOverride = _scoreOverrides.containsKey(student.id);
    final scoreText =
        _scoreOverrides[student.id] ?? _formatScore(existing?.score);
    final controller = _scoreControllerFor(student.id, scoreText);
    final isSaved =
        _saved.contains(student.id) || (existing != null && !hasOverride);
    final isMale = student.gender == 'L';
    final genderColor = isMale
        ? const Color(0xFF0369A1)
        : const Color(0xFFBE123C);
    final genderBg = isMale ? const Color(0xFFE0F2FE) : const Color(0xFFFFE4E6);

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
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            student.name,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: palette.heading,
                                ),
                          ),
                        ),
                        if (student.gender != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: genderBg,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: genderColor.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              student.gender!,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: genderColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ],
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
                child: isSaved
                    ? OutlinedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('Disimpan'),
                      )
                    : OutlinedButton.icon(
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
    AssignmentMeetingRecord meeting,
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
          .read(assignmentActionsProvider)
          .saveScore(meeting: meeting, studentId: student.id, score: score);
      if (mounted) {
        setState(() => _saved.add(student.id));
        _showMessage('Nilai ${student.name} berhasil disimpan.');
      }
    } catch (e) {
      _showMessage('Gagal menyimpan nilai: $e');
    }
  }

  Future<void> _saveAll(
    List<CachedStudent> students,
    Map<int, AssignmentScoreRecord> scoreMap,
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
    final actions = ref.read(assignmentActionsProvider);
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
      _showMessage('Nilai tugas berhasil disimpan.');
      Navigator.of(context).pop();
    }
  }

  Future<void> _scanScores(List<CachedStudent> students) async {
    if (students.isEmpty) {
      _showMessage('Belum ada siswa untuk kelas ini.');
      return;
    }

    final XFile? photo;
    try {
      photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1600,
      );
    } catch (e) {
      _showMessage('Tidak dapat membuka kamera: $e');
      return;
    }
    if (photo == null) {
      return;
    }

    setState(() => _scanning = true);
    try {
      final result = await ref
          .read(scoreScanApiProvider)
          .scan(
            imagePath: photo.path,
            students: [for (final s in students) (id: s.id, name: s.name)],
          );
      if (!mounted) {
        return;
      }

      setState(() {
        for (final entry in result.scores.entries) {
          final text = _formatScore(entry.value);
          _scoreOverrides[entry.key] = text;
          _scoreControllers[entry.key]?.text = text;
          _saved.remove(entry.key);
        }
      });

      final detected = result.scores.length;
      _showMessage(
        'Berhasil mendeteksi nilai untuk $detected siswa. Periksa kembali sebelum menyimpan.',
      );
    } on ApiException catch (e) {
      _showMessage(e.message);
    } catch (e) {
      _showMessage('Gagal memproses gambar: $e');
    } finally {
      if (mounted) {
        setState(() => _scanning = false);
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
