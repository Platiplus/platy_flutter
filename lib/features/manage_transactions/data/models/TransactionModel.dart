import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/core/helpers/constants/utilities_constants.dart';

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
      id: json['_id'],
      type: json['type'],
      value: json['value'].toDouble(),
      description: json['description'],
      date: DateTime.parse(json['date']),
      target: json['target'],
      category: json['category'],
      status: json['status'],
      quotas: json['quotas'],
      owner: json['owner'],
      account: json['account']
  );

  Map<String, String> toJson() => {
    "id": id,
    "type": type.toString(),
    "value": value.toString(),
    "description": description,
    "date": dateFormatter.format(date),
    "target": target,
    "category": category,
    "status": status.toString(),
    "quotas": quotas,
    "owner": owner,
    "account": account
  };

}