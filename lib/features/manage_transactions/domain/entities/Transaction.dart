class Transaction {
  String id;
  int type;
  double value;
  String description;
  DateTime date;
  String target;
  String category;
  bool status;
  String quotas;
  String owner;
  String account;

  Transaction({
    this.id,
    this.type,
    this.value,
    this.description,
    this.date,
    this.target,
    this.category,
    this.status,
    this.quotas,
    this.owner,
    this.account
  });
}