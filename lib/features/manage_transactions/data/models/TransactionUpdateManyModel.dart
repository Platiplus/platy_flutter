import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/core/helpers/constants/utilities_constants.dart';

class TransactionUpdateManyModel extends Transaction {
  TransactionUpdateManyModel({
    int type,
    double value,
    String description,
    String target,
    String category,
    bool status,
    String quotas,
    String account
  }) : super(type: type, value: value, description: description, target: target, category: category, status: status, quotas: quotas, account: account);

  Map<String, String> toJson() => {
    "type": type.toString(),
    "value": value.toString(),
    "description": description,
    "target": target,
    "category": category,
    "status": status.toString(),
    "quotas": quotas,
    "account": account
  };

}