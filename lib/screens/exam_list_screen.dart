import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../data/local/database.dart';
import '../providers/absensi_providers.dart';
import '../providers/exam_providers.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ui_kit.dart';
import 'exam_fill_screen.dart';

/// List + form screen shared by PTS (`midterm`) and PAS (`final`).
class ExamListScreen extends ConsumerStatefulWidget {
  const ExamListScreen({super.key, required this.kind});

  final String kind;

  bool get isMidterm => kind == examKindMidterm;

  String get shortLabel => isMidterm ? 'PTS' : 'PAS';

  String get fullLabel => isMidterm
      ? 'Penilaian Tengah Semester (PTS)'
      : 'Penilaian Akhir Semester (PAS)';

  String get examNoun =>
      isMidterm ? 'Ujian Tengah Semester' : 'Ujian Akhir Semester';

  @override
  ConsumerState<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends ConsumerState<ExamListScreen> {
  final _searchController = TextEditingController();
  int? _filterClassId;
  DateTime? _filterDate;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final asyncExams = widget.isMidterm
        ? ref.watch(midtermExamsProvider)
        : ref.watch(finalExamsProvider);
    final classes = ref.watch(classesProvider).value ?? const [];

    return MainScaffold(
      title: widget.shortLabel,
      route: widget.isMidterm ? '/pts' : '/pas',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openExamForm(context),
        backgroundColor: palette.brand,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Ujian'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(examActionsProvider(widget.kind)).refresh(),
        child: asyncExams.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: 120),
              EmptyState(
                icon: Icons.error_outline,
                title: 'Gagal memuat data',
                subtitle: e.toString(),
              ),
            ],
          ),
          data: (exams) {
            final filtered = _applyFilters(exams);
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
                const SyncBanner(),
                Text(
                  widget.fullLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: palette.heading,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isMidterm
                      ? 'Kelola ujian tengah semester dan isi nilai siswa di setiap kelas.'
                      : 'Kelola ujian akhir semester dan isi nilai siswa di setiap kelas.',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: palette.body),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Cari nama ujian...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 12),
                _filterRow(context, classes),
                const SizedBox(height: 16),
                if (filtered.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: EmptyState(
                      icon: Icons.assignment_outlined,
                      title: 'Belum ada ujian ${widget.shortLabel}',
                      subtitle:
                          'Tambahkan ujian baru menggunakan tombol di bawah.',
                    ),
                  )
                else
                  for (final exam in filtered) ...[
                    _ExamCard(exam: exam),
                    const SizedBox(height: 12),
                  ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _filterRow(BuildContext context, List<CachedClass> classes) {
    final palette = context.palette;
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int?>(
            initialValue: _filterClassId,
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            hint: const Text('Semua Kelas'),
            items: [
              const DropdownMenuItem<int?>(
                value: null,
                child: Text('Semua Kelas'),
              ),
              for (final c in classes)
                DropdownMenuItem<int?>(
                  value: c.id,
                  child: Text(c.name, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (value) => setState(() => _filterClassId = value),
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _filterDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() => _filterDate = picked);
            }
          },
          icon: const Icon(Icons.calendar_today_outlined, size: 16),
          label: Text(
            _filterDate == null
                ? 'Tanggal'
                : '${_filterDate!.day}/${_filterDate!.month}/${_filterDate!.year}',
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: _filterDate == null ? palette.body : palette.brand,
          ),
        ),
        if (_filterDate != null)
          IconButton(
            tooltip: 'Hapus filter tanggal',
            onPressed: () => setState(() => _filterDate = null),
            icon: const Icon(Icons.close),
          ),
      ],
    );
  }

  List<ExamRecord> _applyFilters(List<ExamRecord> exams) {
    final query = _searchController.text.trim().toLowerCase();
    return exams.where((e) {
      final matchesQuery =
          query.isEmpty || e.title.toLowerCase().contains(query);
      final matchesClass =
          _filterClassId == null || e.classId == _filterClassId;
      final matchesDate =
          _filterDate == null ||
          (e.examDate != null &&
              e.examDate!.year == _filterDate!.year &&
              e.examDate!.month == _filterDate!.month &&
              e.examDate!.day == _filterDate!.day);
      return matchesQuery && matchesClass && matchesDate;
    }).toList();
  }

  Future<void> _openExamForm(BuildContext context, {ExamRecord? exam}) async {
    final classes = ref.read(classesProvider).value ?? const <CachedClass>[];
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.palette.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ExamFormSheet(
        kind: widget.kind,
        examNoun: widget.examNoun,
        exam: exam,
        classes: classes,
      ),
    );
  }
}

class _ExamCard extends ConsumerWidget {
  const _ExamCard({required this.exam});

  final ExamRecord exam;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final scores =
        ref.watch(examScoresProvider(exam.localId)).value ?? const [];
    final students = exam.classId == null
        ? const []
        : ref.watch(classStudentsProvider(exam.classId!)).value ?? const [];

    return AppCard(
      onTap: () => _openFill(context, exam),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exam.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: palette.heading,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: palette.body, size: 20),
                onSelected: (value) async {
                  if (value == 'edit') {
                    final classes =
                        ref.read(classesProvider).value ??
                        const <CachedClass>[];
                    final isMidterm = exam.examKind == examKindMidterm;
                    await showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: palette.cardBg,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => _ExamFormSheet(
                        kind: exam.examKind,
                        examNoun: isMidterm
                            ? 'Ujian Tengah Semester'
                            : 'Ujian Akhir Semester',
                        exam: exam,
                        classes: classes,
                      ),
                    );
                  } else if (value == 'delete') {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Hapus Ujian'),
                        content: const Text(
                          'Yakin ingin menghapus ujian ini? Semua nilai di dalamnya juga akan terhapus.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            child: Text(
                              'Hapus',
                              style: TextStyle(color: palette.danger),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await ref
                          .read(examActionsProvider(exam.examKind))
                          .deleteExam(exam);
                    }
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Ubah')),
                  PopupMenuItem(value: 'delete', child: Text('Hapus')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.class_outlined, size: 14, color: palette.body),
              const SizedBox(width: 4),
              Text(
                exam.className ?? '-',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: palette.body),
              ),
              const SizedBox(width: 12),
              Icon(Icons.event_outlined, size: 14, color: palette.body),
              const SizedBox(width: 4),
              Text(
                formatTanggal(exam.examDate),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: palette.body),
              ),
            ],
          ),
          if (exam.description != null && exam.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              exam.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: palette.body),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: palette.brandSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${scores.length} / ${students.length} Siswa',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: palette.brand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (exam.syncStatus != 'synced') ...[
                const SizedBox(width: 8),
                AppBadge(label: 'Menunggu Sync', tone: BadgeTone.amber),
              ],
              const Spacer(),
              Text(
                'Isi Nilai',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: palette.brand,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(Icons.chevron_right, color: palette.brand, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  void _openFill(BuildContext context, ExamRecord exam) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ExamFillScreen(exam: exam)));
  }
}

class _ExamFormSheet extends ConsumerStatefulWidget {
  const _ExamFormSheet({
    required this.kind,
    required this.examNoun,
    required this.classes,
    this.exam,
  });

  final String kind;
  final String examNoun;
  final List<CachedClass> classes;
  final ExamRecord? exam;

  @override
  ConsumerState<_ExamFormSheet> createState() => _ExamFormSheetState();
}

class _ExamFormSheetState extends ConsumerState<_ExamFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  int? _classId;
  DateTime _date = DateTime.now();
  bool _saving = false;

  bool get _isEditing => widget.exam != null;

  @override
  void initState() {
    super.initState();
    final exam = widget.exam;
    _titleController = TextEditingController(text: exam?.title ?? '');
    _descriptionController = TextEditingController(
      text: exam?.description ?? '',
    );
    _classId =
        exam?.classId ??
        (widget.classes.isNotEmpty ? widget.classes.first.id : null);
    _date = exam?.examDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _classNameOf(int? id) {
    if (id == null) {
      return null;
    }
    for (final c in widget.classes) {
      if (c.id == id) {
        return c.name;
      }
    }
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _saving = true);
    final actions = ref.read(examActionsProvider(widget.kind));

    if (_isEditing) {
      await actions.updateExam(
        widget.exam!,
        classId: _classId,
        className: _classNameOf(_classId),
        title: _titleController.text.trim(),
        examDate: _date,
        description: _descriptionController.text.trim(),
      );
    } else {
      await actions.createExam(
        classId: _classId,
        className: _classNameOf(_classId),
        title: _titleController.text.trim(),
        examDate: _date,
        description: _descriptionController.text.trim(),
      );
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEditing
                    ? 'Ubah ${widget.examNoun}'
                    : 'Tambah ${widget.examNoun}',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              _label(context, 'Kelas'),
              DropdownButtonFormField<int>(
                initialValue: _classId,
                decoration: const InputDecoration(),
                items: [
                  for (final c in widget.classes)
                    DropdownMenuItem(value: c.id, child: Text(c.name)),
                ],
                validator: (value) =>
                    value == null ? 'Kelas wajib dipilih.' : null,
                onChanged: (value) => setState(() => _classId = value),
              ),
              const SizedBox(height: 14),
              _label(context, 'Nama Ujian'),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: widget.kind == examKindMidterm
                      ? 'contoh: PTS Ganjil Matematika'
                      : 'contoh: PAS Ganjil Matematika',
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Nama ujian wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 14),
              _label(context, 'Tanggal Ujian'),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _date = picked);
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: Text('${_date.day}/${_date.month}/${_date.year}'),
              ),
              const SizedBox(height: 14),
              _label(context, 'Deskripsi / Keterangan'),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'contoh: Materi Bab 1 sampai Bab 3...',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _saving
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saving ? null : _save,
                      child: _saving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Simpan'),
                    ),
                  ),
                ],
              ),
              if (_isEditing) ...[
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: _saving
                      ? null
                      : () async {
                          await ref
                              .read(examActionsProvider(widget.kind))
                              .deleteExam(widget.exam!);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                  icon: Icon(Icons.delete_outline, color: palette.danger),
                  label: Text(
                    'Hapus Ujian',
                    style: TextStyle(color: palette.danger),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.palette.heading,
          ),
        ),
      ),
    );
  }
}
