import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeUserItem extends StatelessWidget {
  final UserModel user;

  const HomeUserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 120,
      margin: const EdgeInsets.only(right: 17),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.only(bottom: 13),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                // image: user.profilePicture == null
                //     ? const AssetImage(
                //         'assets/img_profile.png',
                //       )
                //     : NetworkImage(user.profilePicture!) as ImageProvider),
                image: AssetImage(
                  'assets/img_profile.png',
                ),
              ),
            )),
        Text(
          '@${user.name}',
          style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
        )
      ]),
    );
  }
}
