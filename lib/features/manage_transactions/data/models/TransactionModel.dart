import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    String id,
    int type,
    double value,
    String description,
    DateTime date,
    String target,
    String category,
    bool status,
    String quotas,
    String owner,
    String account
  }) : super(id: id, type: type, value: value, description: description, date: date, target: target, category: category, status: status, quotas: quotas, owner: owner, account: account);

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      target: json['target'],
      category: json['category'],
      status: json['status'],
      quotas: json['quotas'],
      owner: json['owner'],
      account: json['account']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "value": value.toString(),
    "description": description,
    "date": date.toString(),
    "target": target,
    "category": category,
    "status": status,
    "quotas": quotas,
    "owner": owner,
    "account": account
  };

}