const List<String> _bulanSingkat = [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

String _dua(int n) => n.toString().padLeft(2, '0');

/// Tanggal standar: "14 Okt 2026". Null-safe.
String formatTanggal(DateTime? date) {
  if (date == null) {
    return '-';
  }
  return '${date.day} ${_bulanSingkat[date.month]} ${date.year}';
}

/// Tanggal + jam: "14 Okt 2026 09:30". Null-safe.
String formatTanggalWaktu(DateTime? date) {
  if (date == null) {
    return '-';
  }
  return '${formatTanggal(date)} ${_dua(date.hour)}:${_dua(date.minute)}';
}

/// Parse string ISO dari API lalu format tanggal. "-" bila null/invalid.
String formatTanggalIso(String? raw) {
  if (raw == null || raw.isEmpty) {
    return '-';
  }
  return formatTanggal(DateTime.tryParse(raw)?.toLocal());
}
