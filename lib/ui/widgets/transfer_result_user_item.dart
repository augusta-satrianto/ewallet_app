import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';

class TransferResultItem extends StatelessWidget {
  final UserModel user;
  final bool isSelected;
  const TransferResultItem(
      {super.key, required this.user, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        border:
            Border.all(color: isSelected ? purpleColor : whiteColor, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: user.profilePicture == null
                      ? const AssetImage('assets/img_profile.png')
                      : NetworkImage(
                          user.profilePicture!,
                        ) as ImageProvider),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name.toString(),
                style:
                    blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                user.email.toString(),
                style: greyTextStyle.copyWith(fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
