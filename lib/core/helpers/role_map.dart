class RoleHelper {
  static idToName(int id) {
    final map = {
      0: 'Super Admin',
      1: 'Praktikan',
      2: 'Asisten',
    };

    return map[id];
  }

  static nameToId(String name) {
    final map = {
      'Praktikan': 1,
      'Asisten': 2,
    };

    return map[name];
  }
}
