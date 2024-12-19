import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/blocs/transfer/transfer_bloc.dart';
import 'package:ewallet_app/models/transfer_model.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransferAmountPage extends StatefulWidget {
  final TransferFormModel data;
  const TransferAmountPage({super.key, required this.data});

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      final text = amountController.text;

      amountController.value = amountController.value.copyWith(
          text:
              NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: '')
                  .format(int.parse(text.replaceAll('.', ''))));
    });
  }

  addTransfer(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteTransfer() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
      });
    }

    if (amountController.text == '') {
      amountController.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: BlocProvider(
        create: (context) => TransferBloc(),
        child: BlocConsumer<TransferBloc, TransferState>(
          listener: (context, state) {
            if (state is TransferFailed) {
              showCustomSnackbar(context, state.e);
            }
            if (state is TransferSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/transfer-success', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is TransferLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Total Amount',
                  style: whiteTextStyle.copyWith(
                      fontSize: 20, fontWeight: semiBold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 67,
                ),
                Align(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: amountController,
                      cursorColor: greyColor,
                      enabled: false,
                      style: whiteTextStyle.copyWith(
                        fontSize: 36,
                        fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          'Rp ',
                          style: whiteTextStyle.copyWith(
                              fontSize: 36, fontWeight: medium),
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: greyColor)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 66,
                ),
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    CustomInputButton(
                      title: '1',
                      onTap: () {
                        addTransfer('1');
                      },
                    ),
                    CustomInputButton(
                      title: '2',
                      onTap: () {
                        addTransfer('2');
                      },
                    ),
                    CustomInputButton(
                      title: '3',
                      onTap: () {
                        addTransfer('3');
                      },
                    ),
                    CustomInputButton(
                      title: '4',
                      onTap: () {
                        addTransfer('4');
                      },
                    ),
                    CustomInputButton(
                      title: '5',
                      onTap: () {
                        addTransfer('5');
                      },
                    ),
                    CustomInputButton(
                      title: '6',
                      onTap: () {
                        addTransfer('6');
                      },
                    ),
                    CustomInputButton(
                      title: '7',
                      onTap: () {
                        addTransfer('7');
                      },
                    ),
                    CustomInputButton(
                      title: '8',
                      onTap: () {
                        addTransfer('8');
                      },
                    ),
                    CustomInputButton(
                      title: '9',
                      onTap: () {
                        addTransfer('9');
                      },
                    ),
                    const SizedBox(
                      width: 60,
                      height: 60,
                    ),
                    CustomInputButton(
                      title: '0',
                      onTap: () {
                        addTransfer('0');
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        deleteTransfer();
                      },
                      child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: numberBackgroundColor),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: whiteColor,
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomFilledButton(
                  title: 'Continue',
                  onPressed: () async {
                    if (await Navigator.pushNamed(context, '/pin') == true) {
                      final authState = context.read<AuthBloc>().state;
                      String pin = '';
                      if (authState is AuthSuccess) {
                        pin = authState.user.pin!;
                      }
                      context.read<TransferBloc>().add(
                            TransferPost(
                              widget.data.copyWith(
                                pin: pin,
                                amount:
                                    amountController.text.replaceAll('.', ''),
                              ),
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextButton(
                  title: 'Terms & Conditions',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
