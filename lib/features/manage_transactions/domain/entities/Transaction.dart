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

  @override
  String toString() {
    super.toString();
    return "_id: $id, type: $type, value: $value, description: $description, date: $date, target: $target, category: $category, status: $status, quotas: $quotas, owner: $owner, account: $account";
  }
}