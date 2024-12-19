import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/blocs/transaction/transaction_bloc.dart';
import 'package:ewallet_app/blocs/user/user_bloc.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/widgets/home_service_item.dart';
import 'package:ewallet_app/ui/widgets/home_latest_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            buildProfile(context),
            buildWalletCard(),
            buildServices(context),
            buildLatestTransaction(),
          ],
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.email.toString(),
                        style: greyTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        state.user.name.toString(),
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: semiBold),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: state.user.profilePicture == null
                                ? const AssetImage('assets/img_profile.png')
                                : NetworkImage(state.user.profilePicture!)
                                    as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                ]),
          );
        }
        return Container();
      },
    );
  }

  Widget buildWalletCard() {
    return BlocProvider(
      create: (context) => UserSingleBloc()..add(UserSingleGet()),
      child: BlocBuilder<UserSingleBloc, UserSingleState>(
        builder: (context, state) {
          if (state is UserSingleSuccess) {
            return Container(
              width: double.infinity,
              height: 190,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  image: const DecorationImage(
                      image: AssetImage('assets/img_bg_card.png'))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.user.name.toString(),
                      style: whiteTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      state.user.cardNumber.toString().replaceAllMapped(
                          RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                      style: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium, letterSpacing: 4),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Balance',
                      style: whiteTextStyle,
                    ),
                    Text(
                      formatCurrency(state.user.balance ?? 0),
                      style: whiteTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold),
                    ),
                  ]),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget buildServices(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do Something',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeServiceItem(
                title: 'Top Up',
                iconUrl: 'assets/ic_topup.png',
                onTap: () {
                  Navigator.pushNamed(context, '/topup');
                },
              ),
              HomeServiceItem(
                title: 'Transfer',
                iconUrl: 'assets/ic_send.png',
                onTap: () {
                  Navigator.pushNamed(context, '/transfer');
                },
              ),
              HomeServiceItem(
                title: 'Data',
                iconUrl: 'assets/ic_product_data.png',
                onTap: () {
                  Navigator.pushNamed(context, '/data-provider');
                },
              ),
              HomeServiceItem(
                title: 'More',
                iconUrl: 'assets/ic_more.png',
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => const MoreDialog());
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLatestTransaction() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: BlocProvider(
        create: (context) => TransactionBloc()..add(TransactionGet()),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionSuccess) {
              if (state.transactions.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Transactions',
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 22, left: 22, right: 22, bottom: 4),
                      margin: const EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: state.transactions.map((transaction) {
                          return HomeLatestTransactionItem(
                              transaction: transaction);
                        }).toList(),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 326,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: lightBackgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More With Us',
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 13,
            ),
            Wrap(
              spacing: (MediaQuery.of(context).size.width - 48 - 60 - 210) / 2,
              runSpacing: 25,
              children: [
                HomeServiceItem(
                  title: 'Data',
                  iconUrl: 'assets/ic_product_data.png',
                  onTap: () {
                    Navigator.pushNamed(context, '/data-provider');
                  },
                ),
                HomeServiceItem(
                  title: 'Water',
                  iconUrl: 'assets/ic_product_water.png',
                  onTap: () {},
                ),
                HomeServiceItem(
                  title: 'Stream',
                  iconUrl: 'assets/ic_product_stream.png',
                  onTap: () {},
                ),
                HomeServiceItem(
                  title: 'Movie',
                  iconUrl: 'assets/ic_product_movie.png',
                  onTap: () {},
                ),
                HomeServiceItem(
                  title: 'Food',
                  iconUrl: 'assets/ic_product_food.png',
                  onTap: () {},
                ),
                HomeServiceItem(
                  title: 'Travel',
                  iconUrl: 'assets/ic_product_travel.png',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
