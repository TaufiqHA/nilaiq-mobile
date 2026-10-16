/// Typed view over the dashboard payload returned by `/api/dashboard`.
class DashboardData {
  const DashboardData({
    required this.totalStudents,
    required this.totalClasses,
    required this.academicYearLabel,
    required this.semesterLabel,
    required this.hasActiveYear,
    required this.attendanceRate,
    required this.subjectName,
    required this.minimumScore,
    required this.teacherName,
    required this.dailyTestCount,
    required this.assignmentCount,
    required this.midtermCount,
    required this.finalCount,
    required this.weights,
    required this.latestStudents,
    required this.recentActivities,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    final year = json['activeAcademicYear'];
    final settings = (json['settings'] as Map?)?.cast<String, dynamic>();

    return DashboardData(
      totalStudents: _int(json['totalStudents']),
      totalClasses: _int(json['totalClasses']),
      academicYearLabel: year is Map ? (year['year']?.toString() ?? '') : '',
      semesterLabel: year is Map ? (year['semester']?.toString() ?? '') : '',
      hasActiveYear: year is Map,
      attendanceRate: _num(json['attendanceRate']),
      subjectName: settings?['subject_name']?.toString(),
      minimumScore: settings?['minimum_score'] == null
          ? null
          : _num(settings!['minimum_score']),
      teacherName: settings?['teacher_name']?.toString(),
      dailyTestCount: _int(json['dailyTestCount']),
      assignmentCount: _int(json['assignmentCount']),
      midtermCount: _int(json['midtermCount']),
      finalCount: _int(json['finalCount']),
      weights: _parseWeights(settings),
      latestStudents: _parseStudents(json['latestStudents']),
      recentActivities: _parseActivities(json['recentActivities']),
    );
  }

  final int totalStudents;
  final int totalClasses;
  final String academicYearLabel;
  final String semesterLabel;
  final bool hasActiveYear;
  final num attendanceRate;
  final String? subjectName;
  final num? minimumScore;
  final String? teacherName;
  final int dailyTestCount;
  final int assignmentCount;
  final int midtermCount;
  final int finalCount;
  final AssessmentWeights weights;
  final List<DashboardStudent> latestStudents;
  final List<DashboardActivity> recentActivities;

  static int _int(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static num _num(dynamic value) {
    if (value is num) {
      return value;
    }
    return num.tryParse(value?.toString() ?? '') ?? 0;
  }

  static AssessmentWeights _parseWeights(Map<String, dynamic>? s) {
    int pct(dynamic raw) {
      final value = _num(raw);
      final scaled = value <= 1.0 ? value * 100 : value;
      return scaled.round();
    }

    return AssessmentWeights(
      dailyTest: s == null ? 0 : pct(s['daily_test_weight']),
      assignment: s == null ? 0 : pct(s['assignment_weight']),
      midterm: s == null ? 0 : pct(s['midterm_weight']),
      finalExam: s == null ? 0 : pct(s['final_weight']),
    );
  }

  static List<DashboardStudent> _parseStudents(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw.whereType<Map>().map((item) {
      final map = item.cast<String, dynamic>();
      final klass = map['class'];
      return DashboardStudent(
        name: map['name']?.toString() ?? '-',
        nis: map['nis']?.toString() ?? '-',
        className: klass is Map ? klass['name']?.toString() : null,
        status: map['status']?.toString() ?? '-',
      );
    }).toList();
  }

  static List<DashboardActivity> _parseActivities(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw.whereType<Map>().map((item) {
      final map = item.cast<String, dynamic>();
      return DashboardActivity(
        type: map['type']?.toString() ?? '-',
        title: map['title']?.toString() ?? '-',
        className: map['class']?.toString(),
        date: map['date']?.toString(),
      );
    }).toList();
  }
}

class AssessmentWeights {
  const AssessmentWeights({
    required this.dailyTest,
    required this.assignment,
    required this.midterm,
    required this.finalExam,
  });

  final int dailyTest;
  final int assignment;
  final int midterm;
  final int finalExam;
}

class DashboardStudent {
  const DashboardStudent({
    required this.name,
    required this.nis,
    required this.className,
    required this.status,
  });

  final String name;
  final String nis;
  final String? className;
  final String status;
}

class DashboardActivity {
  const DashboardActivity({
    required this.type,
    required this.title,
    required this.className,
    required this.date,
  });

  final String type;
  final String title;
  final String? className;
  final String? date;
}
