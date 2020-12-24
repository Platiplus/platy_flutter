class Months {
  static const Month Janeiro = const Month('Janeiro', 1);
  static const Month Fevereiro = const Month('Fevereiro', 2);
  static const Month Marco = const Month('Marco', 3);
  static const Month Abril = const Month('Abril', 4);
  static const Month Maio = const Month('Maio', 5);
  static const Month Junho = const Month('Junho', 6);
  static const Month Julho = const Month('Julho', 7);
  static const Month Agosto = const Month('Agosto', 8);
  static const Month Setembro = const Month('Setembro', 9);
  static const Month Outubro = const Month('Outubro', 10);
  static const Month Novembro = const Month('Novembro', 11);
  static const Month Dezembro = const Month('Dezembro', 12);

  static List<Month> LIST = new List<Month>.unmodifiable([Janeiro, Fevereiro, Marco, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro]);
}

class Month {
  const Month(this.name, this.value);
  final String name;
  final int value;
}