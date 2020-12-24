class Years {
  static const Year _2020 = const Year('2020', 2020);
  static const Year _2021 = const Year('2021', 2021);
  static const Year _2022 = const Year('2022', 2022);
  static const Year _2023 = const Year('2023', 2023);
  static const Year _2024 = const Year('2024', 2024);
  static const Year _2025 = const Year('2025', 2025);
  static const Year _2026 = const Year('2026', 2026);
  static const Year _2027 = const Year('2027', 2027);
  static const Year _2028 = const Year('2028', 2028);
  static const Year _2029 = const Year('2029', 2029);
  static const Year _2030 = const Year('2030', 2030);
  static const Year _2031 = const Year('2031', 2031);
  static const Year _2032 = const Year('2032', 2032);
  static const Year _2033 = const Year('2033', 2033);
  static const Year _2034 = const Year('2034', 2034);
  static const Year _2035 = const Year('2035', 2035);
  static const Year _2036 = const Year('2036', 2036);
  static const Year _2037 = const Year('2037', 2037);
  static const Year _2038 = const Year('2038', 2038);
  static const Year _2039 = const Year('2039', 2039);
  static const Year _2040 = const Year('2040', 2040);

  static List<Year> LIST = new List<Year>.unmodifiable(
      [ _2020, _2021, _2022,
        _2023, _2024, _2025,
        _2026, _2027, _2028,
        _2029, _2030, _2031,
        _2032, _2033, _2034,
        _2035, _2036, _2037,
        _2038, _2039, _2040
      ]
  );
}

class Year {
  const Year(this.name, this.value);
  final String name;
  final int value;
}