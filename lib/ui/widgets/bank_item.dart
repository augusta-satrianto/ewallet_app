import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';

class BankItem extends StatelessWidget {
  final bool isSelected;
  final String assetImage;
  final String paymentName;
  final VoidCallback? onTap;
  const BankItem(
      {super.key,
      this.onTap,
      required this.assetImage,
      required this.paymentName,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 2, color: isSelected ? purpleColor : whiteColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            assetImage,
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                paymentName,
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
