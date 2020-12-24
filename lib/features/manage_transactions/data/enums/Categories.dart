class Categories {
  static const Category HABITACAO = const Category('Habitação');
  static const Category LAZER = const Category('Lazer');
  static const Category TRANSPORTE = const Category('Transporte');
  static const Category COMPRAS = const Category('Compras');
  static const Category CONTAS = const Category('Contas');
  static const Category ALIMENTACAO = const Category('Alimentação');
  static const Category OUTROS = const Category('Outros');

  static List<Category> LIST = new List<Category>.unmodifiable([HABITACAO, LAZER, TRANSPORTE, COMPRAS, CONTAS, ALIMENTACAO, OUTROS]);
}

class Category {
  const Category(this.name);
  final String name;
}