import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/formatters.dart';
import '../core/theme/app_colors.dart';
import '../data/local/database.dart';
import '../providers/absensi_providers.dart';
import '../widgets/app_drawer.dart';
import '../widgets/ui_kit.dart';
import 'absensi_fill_screen.dart';
import 'rekap_absensi_screen.dart';

class AbsensiListScreen extends ConsumerStatefulWidget {
  const AbsensiListScreen({super.key});

  @override
  ConsumerState<AbsensiListScreen> createState() => _AbsensiListScreenState();
}

class _AbsensiListScreenState extends ConsumerState<AbsensiListScreen> {
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
    final asyncMeetings = ref.watch(meetingsProvider);
    final classes = ref.watch(classesProvider).value ?? const [];

    return MainScaffold(
      title: 'Absensi',
      route: '/absensi',
      actions: [
        IconButton(
          tooltip: 'Rekap Absensi',
          onPressed: () => _openRekap(context, classes),
          icon: const Icon(Icons.description_outlined),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openMeetingForm(context),
        backgroundColor: palette.brand,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Pertemuan'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(absensiActionsProvider).refresh(),
        child: asyncMeetings.when(
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
          data: (meetings) {
            final filtered = _applyFilters(meetings);
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
                const SyncBanner(),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Cari nama pertemuan...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 12),
                _filterRow(context, classes),
                const SizedBox(height: 16),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: EmptyState(
                      icon: Icons.event_busy_outlined,
                      title: 'Belum ada pertemuan',
                      subtitle: 'Tambahkan pertemuan baru menggunakan tombol di bawah.',
                    ),
                  )
                else
                  for (final meeting in filtered) ...[
                    _MeetingCard(meeting: meeting),
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

  List<MeetingRecord> _applyFilters(List<MeetingRecord> meetings) {
    final query = _searchController.text.trim().toLowerCase();
    return meetings.where((m) {
      final matchesQuery =
          query.isEmpty || m.title.toLowerCase().contains(query);
      final matchesClass =
          _filterClassId == null || m.classId == _filterClassId;
      final matchesDate =
          _filterDate == null ||
          (m.meetingDate != null &&
              m.meetingDate!.year == _filterDate!.year &&
              m.meetingDate!.month == _filterDate!.month &&
              m.meetingDate!.day == _filterDate!.day);
      return matchesQuery && matchesClass && matchesDate;
    }).toList();
  }

  Future<void> _openMeetingForm(
    BuildContext context, {
    MeetingRecord? meeting,
  }) async {
    final classes = ref.read(classesProvider).value ?? const <CachedClass>[];
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.palette.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MeetingFormSheet(meeting: meeting, classes: classes),
    );
  }

  Future<void> _openRekap(
    BuildContext context,
    List<CachedClass> classes,
  ) async {
    if (classes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belum ada kelas. Muat data terlebih dahulu.'),
        ),
      );
      return;
    }
    final selected = await showModalBottomSheet<CachedClass>(
      context: context,
      backgroundColor: context.palette.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Pilih Kelas untuk Rekap',
                style: Theme.of(sheetContext).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            for (final c in classes)
              ListTile(
                leading: const Icon(Icons.class_outlined),
                title: Text(c.name),
                onTap: () => Navigator.of(sheetContext).pop(c),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );

    if (selected != null && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RekapAbsensiScreen(
            classId: selected.id,
            className: selected.name,
          ),
        ),
      );
    }
  }
}

class _MeetingCard extends ConsumerWidget {
  const _MeetingCard({required this.meeting});

  final MeetingRecord meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = context.palette;
    final attendances =
        ref.watch(meetingAttendancesProvider(meeting.localId)).value ??
        const [];
    final students = meeting.classId == null
        ? const []
        : ref.watch(classStudentsProvider(meeting.classId!)).value ?? const [];

    return AppCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AbsensiFillScreen(meeting: meeting)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  meeting.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: palette.heading,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              AppBadge(
                label: tipeLabel(meeting.tipe),
                tone: tipeTone(meeting.tipe),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: palette.body, size: 20),
                onSelected: (value) async {
                  if (value == 'edit') {
                    final classes =
                        ref.read(classesProvider).value ??
                        const <CachedClass>[];
                    await showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: palette.cardBg,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) =>
                          _MeetingFormSheet(meeting: meeting, classes: classes),
                    );
                  } else if (value == 'delete') {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Hapus Pertemuan'),
                        content: const Text(
                          'Yakin ingin menghapus pertemuan ini? Absensi di dalamnya juga akan terhapus.',
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
                          .read(absensiActionsProvider)
                          .deleteMeeting(meeting);
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
                meeting.className ?? '-',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: palette.body),
              ),
              const SizedBox(width: 12),
              Icon(Icons.event_outlined, size: 14, color: palette.body),
              const SizedBox(width: 4),
              Text(
                formatTanggal(meeting.meetingDate),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: palette.body),
              ),
            ],
          ),
          if (meeting.description != null &&
              meeting.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              meeting.description!,
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
                  '${attendances.length} / ${students.length} Siswa',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: palette.brand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (meeting.syncStatus != 'synced') ...[
                const SizedBox(width: 8),
                AppBadge(label: 'Menunggu Sync', tone: BadgeTone.amber),
              ],
              const Spacer(),
              Text(
                'Isi Absensi',
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
}

class _MeetingFormSheet extends ConsumerStatefulWidget {
  const _MeetingFormSheet({required this.classes, this.meeting});

  final List<CachedClass> classes;
  final MeetingRecord? meeting;

  @override
  ConsumerState<_MeetingFormSheet> createState() => _MeetingFormSheetState();
}

class _MeetingFormSheetState extends ConsumerState<_MeetingFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  int? _classId;
  String _tipe = 'harian';
  DateTime _date = DateTime.now();
  bool _saving = false;

  bool get _isEditing => widget.meeting != null;

  @override
  void initState() {
    super.initState();
    final m = widget.meeting;
    _titleController = TextEditingController(text: m?.title ?? '');
    _descriptionController = TextEditingController(text: m?.description ?? '');
    _classId =
        m?.classId ??
        (widget.classes.isNotEmpty ? widget.classes.first.id : null);
    _tipe = m?.tipe ?? 'harian';
    _date = m?.meetingDate ?? DateTime.now();
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
    final actions = ref.read(absensiActionsProvider);

    if (_isEditing) {
      await actions.updateMeeting(
        widget.meeting!,
        classId: _classId,
        className: _classNameOf(_classId),
        title: _titleController.text.trim(),
        tipe: _tipe,
        meetingDate: _date,
        description: _descriptionController.text.trim(),
      );
    } else {
      await actions.createMeeting(
        classId: _classId,
        className: _classNameOf(_classId),
        title: _titleController.text.trim(),
        tipe: _tipe,
        meetingDate: _date,
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
                _isEditing ? 'Ubah Pertemuan' : 'Tambah Pertemuan',
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
              _label(context, 'Nama Pertemuan'),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'contoh: Pertemuan Pertama',
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Nama pertemuan wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 14),
              _label(context, 'Tipe Pertemuan'),
              DropdownButtonFormField<String>(
                initialValue: _tipe,
                decoration: const InputDecoration(),
                items: const [
                  DropdownMenuItem(value: 'harian', child: Text('Harian')),
                  DropdownMenuItem(
                    value: 'ulang harian',
                    child: Text('Ulangan Harian'),
                  ),
                  DropdownMenuItem(value: 'tugas', child: Text('Tugas')),
                  DropdownMenuItem(value: 'pts', child: Text('PTS')),
                  DropdownMenuItem(value: 'pas', child: Text('PAS')),
                ],
                onChanged: (value) => setState(() => _tipe = value ?? 'harian'),
              ),
              const SizedBox(height: 14),
              _label(context, 'Tanggal Pertemuan'),
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
                  hintText: 'contoh: Membahas bab 1...',
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
                              .read(absensiActionsProvider)
                              .deleteMeeting(widget.meeting!);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                  icon: Icon(Icons.delete_outline, color: palette.danger),
                  label: Text(
                    'Hapus Pertemuan',
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
