import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/blocs/operator_card/operator_card_bloc.dart';
import 'package:ewallet_app/models/operator_card_model.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/pages/data_package_page.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:ewallet_app/ui/widgets/data_provider_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataProviderPage extends StatefulWidget {
  const DataProviderPage({super.key});

  @override
  State<DataProviderPage> createState() => _DataProviderPageState();
}

class _DataProviderPageState extends State<DataProviderPage> {
  OperatorCardModel? selectedOperatorCards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beli Data'),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'From Wallet',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/img_wallet.png',
                  width: 80,
                ),
                const SizedBox(
                  width: 16,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      return Column(
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
                            'Balance: ${formatCurrency(state.user.balance ?? 0)}',
                            style: greyTextStyle.copyWith(fontSize: 12),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Select Provider',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            ),
            const SizedBox(
              height: 14,
            ),
            BlocProvider(
              create: (context) => OperatorCardBloc()..add(OperatorCardGet()),
              child: BlocBuilder<OperatorCardBloc, OperatorCardState>(
                builder: (context, state) {
                  if (state is OperatorCardSuccess) {
                    return Column(
                      children: state.operatorCards.map((operatorCard) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperatorCards = operatorCard;
                              });
                            },
                            child: DataProviderItem(
                              operatorCard: operatorCard,
                              isSelected:
                                  operatorCard.id == selectedOperatorCards?.id,
                            ));
                      }).toList(),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ]),
      floatingActionButton: (selectedOperatorCards != null)
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataPackagePage(
                        operatorCard: selectedOperatorCards!,
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
