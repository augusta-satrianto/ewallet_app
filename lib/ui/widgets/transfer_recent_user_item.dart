import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';

class TransferRecentUserItem extends StatelessWidget {
  final UserModel user;

  const TransferRecentUserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: whiteColor),
      child: Row(
        children: [
          Container(
              width: 45,
              height: 45,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    // image: user.profilePicture == null
                    //     ? const AssetImage('assets/img_profile.png')
                    //     : NetworkImage(user.profilePicture!) as ImageProvider),
                    image: const AssetImage('assets/img_profile.png')),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name.toString(),
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '@${user.name}',
                style: greyTextStyle.copyWith(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
