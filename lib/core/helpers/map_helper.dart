class MapHelper {
  static String? idToName(int id) {
    final map = <int, String>{
      0: 'Super Admin',
      1: 'Praktikan',
      2: 'Asisten',
    };

    return map[id];
  }

  static int? nameToId(String name) {
    final map = <String, int>{
      'Praktikan': 1,
      'Asisten': 2,
    };

    return map[name];
  }

  static String? getAttendanceStatus(int key) {
    final map = <int, String>{
      0: 'Alfa',
      1: 'Izin',
      2: 'Sakit',
      3: 'Hadir',
    };

    return map[key];
  }
}
