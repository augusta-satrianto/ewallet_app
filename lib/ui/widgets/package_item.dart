import 'package:ewallet_app/models/data_plan_model.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';

class PackageItem extends StatelessWidget {
  final DataPlanModel dataPlan;
  final bool isSelected;
  const PackageItem(
      {super.key, required this.dataPlan, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 147,
      height: 171,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 49),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        border:
            Border.all(color: isSelected ? purpleColor : whiteColor, width: 2),
      ),
      child: Column(
        children: [
          Text(
            dataPlan.name.toString(),
            style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 32),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            formatCurrency(dataPlan.price ?? 0),
            style: greyTextStyle.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
