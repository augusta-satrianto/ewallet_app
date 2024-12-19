class TransactionModel {
  final int? id;
  final int? userId;
  final int? userLogin;
  final int? amount;
  final String? transactionType;
  final DateTime? createdAt;

  TransactionModel({
    this.id,
    this.userId,
    this.userLogin,
    this.amount,
    this.transactionType,
    this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        userId: json['user_id'],
        userLogin: json['user_login'],
        amount: json['amount'],
        transactionType: json['transaction_type'],
        createdAt: DateTime.tryParse(json['created_at']),
      );
}
