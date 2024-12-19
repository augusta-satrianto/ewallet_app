import 'package:ewallet_app/models/transaction_model.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLatestTransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  const HomeLatestTransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Image.asset(
            transaction.transactionType!.toString() == 'Top Up'
                ? 'assets/ic_transaction_cat1.png'
                : transaction.transactionType!.toString() == 'Transfer' &&
                        transaction.userId == transaction.userLogin
                    ? 'assets/ic_transaction_cat4.png'
                    : transaction.transactionType!.toString() == 'Transfer' &&
                            transaction.userId != transaction.userLogin
                        ? 'assets/ic_transaction_cat2.png'
                        : 'assets/ic_transaction_cat5.png',
            width: 48,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.transactionType!.toString(),
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                DateFormat('MMM dd')
                    .format(transaction.createdAt ?? DateTime.now()),
                style: greyTextStyle.copyWith(fontSize: 12),
              )
            ],
          ),
          const Spacer(),
          Text(
            formatCurrency(
              ((transaction.transactionType!.toString() == 'Transfer' &&
                          transaction.userId == transaction.userLogin) ||
                      transaction.transactionType!.toString() == 'Data'
                  ? -(transaction.amount ?? 0)
                  : transaction.amount ?? 0),
            ),
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          )
        ],
      ),
    );
  }
}
