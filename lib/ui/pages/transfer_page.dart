import 'package:ewallet_app/blocs/user/user_bloc.dart';
import 'package:ewallet_app/models/transfer_model.dart';
import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/ui/pages/transfer_amount_page.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:ewallet_app/ui/widgets/forms.dart';
import 'package:ewallet_app/ui/widgets/transfer_result_user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final usernameController = TextEditingController(text: '');
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>()..add(UserGet());
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    usernameController.addListener(() {
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(
            height: 14,
          ),
          CustomFormField(
            title: 'Cari nama',
            isShowTitle: false,
            controller: usernameController,
          ),
          const SizedBox(
            height: 14,
          ),
          buildResult(context),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !showFab,
        child: selectedUser != null
            ? Container(
                margin: const EdgeInsets.all(24),
                child: CustomFilledButton(
                  title: 'Continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferAmountPage(
                          data: TransferFormModel(
                              sendTo: selectedUser!.id.toString()),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildResult(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return Column(
            children: state.users.map((user) {
              if (usernameController.text == '' ||
                  user.name!
                      .toLowerCase()
                      .contains(usernameController.text.toLowerCase())) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedUser = user;
                        });
                      },
                      child: TransferResultItem(
                        user: user,
                        isSelected: user.id == selectedUser?.id,
                      )),
                );
              } else {
                return Container();
              }
            }).toList(),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
