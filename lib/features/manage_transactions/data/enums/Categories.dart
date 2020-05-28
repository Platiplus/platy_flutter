class Categories {
  static const Category HABITACAO = const Category('Habitação');
  static const Category LAZER = const Category('Lazer');
  static const Category MANUTENCAO = const Category('Manutenção');
  static const Category TAXAS_BANCARIAS = const Category('Taxas Bancárias');
  static const Category CONTAS_DA_CASA = const Category('Contas da Casa');
  static const Category SAUDE = const Category('Saúde');
  static const Category OUTROS = const Category('Outros');

  static List<Category> LIST = new List<Category>.unmodifiable([HABITACAO, LAZER, MANUTENCAO, TAXAS_BANCARIAS, CONTAS_DA_CASA, SAUDE, OUTROS]);
}

class Category {
  const Category(this.name);
  final String name;
}