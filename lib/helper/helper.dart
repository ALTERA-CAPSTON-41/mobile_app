class Helper {
  static String getKeyOrValueMapGender(
    String? search, [
    bool getKeyByValue = true,
  ]) {
    if (search == null) return "";
    Map<String, String> map = {
      'MALE': 'LAKI-LAKI',
      'FEMALE': 'PEREMPUAN',
    };
    if (getKeyByValue) {
      return map.keys.toList().firstWhere((key) => map[key] == search);
    } else {
      return map[search] ?? "";
    }
  }

  static String getKeyOrValueMapStatus(
    String? search, [
    bool getKeyByValue = true,
  ]) {
    if (search == null) return "";
    Map<String, String> map = {
      'OUTPATIENT': 'RAWAT JALAN',
      'REFERRED': 'RUJUKAN',
    };
    if (getKeyByValue) {
      return map.keys.toList().firstWhere((key) => map[key] == search);
    } else {
      return map[search] ?? "";
    }
  }
}
