import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/models/topup_form_model.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/pages/topup_amount_page.dart';
import 'package:ewallet_app/ui/widgets/bank_item.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> paymentList = [
      {
        "title": "BCA",
        "image": "assets/img_bank_bca.png",
        "kode": "bca_va",
      },
      {
        "title": "BRI",
        "image": "assets/img_bank_bri.png",
        "kode": "bri_va",
      },
      {
        "title": "BNI",
        "image": "assets/img_bank_bni.png",
        "kode": "bni_va",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Wallet',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return Row(
                    children: [
                      Image.asset(
                        'assets/img_wallet.png',
                        width: 80,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.user.cardNumber!.replaceAllMapped(
                                RegExp(r'.{4}'),
                                (match) => '${match.group(0)} '),
                            style: blackTextStyle.copyWith(
                                fontWeight: medium, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            state.user.name.toString(),
                            style: greyTextStyle.copyWith(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Select Bank',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            ),
            const SizedBox(
              height: 14,
            ),
            Column(
              children: List.generate(paymentList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = paymentList[index]['kode'];
                    });
                  },
                  child: BankItem(
                    assetImage: paymentList[index]['image']!,
                    paymentName: paymentList[index]['title']!,
                    isSelected:
                        paymentList[index]['kode'] == selectedPaymentMethod,
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 12,
            ),
          ]),
      floatingActionButton: selectedPaymentMethod != null
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopupAmountPage(
                        data: TopupFormModel(
                            paymentMethodCode: selectedPaymentMethod),
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
