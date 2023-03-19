class RoleHelper {
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
}
