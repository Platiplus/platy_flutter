import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/core/helpers/constants/utilities_constants.dart';

class TransactionCreateModel extends Transaction {
  TransactionCreateModel({
    int type,
    double value,
    String description,
    DateTime date,
    String target,
    String category,
    bool status,
    String quotas,
    String account
  }) : super(type: type, value: value, description: description, date: date, target: target, category: category, status: status, quotas: quotas, account: account);

  Map<String, String> toJson() => {
    "type": type.toString(),
    "value": value.toString(),
    "description": description,
    "date": dateFormatter.format(date),
    "target": target,
    "category": category,
    "status": status.toString(),
    "quotas": quotas,
    "account": account
  };

}