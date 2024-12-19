import 'dart:io';

import 'package:ewallet_app/models/sign_up_form_model.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:ewallet_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';

class SignUpSetProfilePage extends StatefulWidget {
  final SignUpFormModel data;
  const SignUpSetProfilePage({super.key, required this.data});

  @override
  State<SignUpSetProfilePage> createState() => _SignUpSetProfilePageState();
}

class _SignUpSetProfilePageState extends State<SignUpSetProfilePage> {
  final pinController = TextEditingController(text: '');
  File? selectedImage;

  bool validate() {
    if (pinController.text.length != 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/img_logo.png'),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Sign Up',
                style:
                    blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await selectImageGalery();

                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightBackgroundColor,
                            image: selectedImage == null
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        FileImage(File(selectedImage!.path)))),
                        child: selectedImage != null
                            ? null
                            : Center(
                                child: Image.asset(
                                  'assets/ic_upload.png',
                                  width: 32,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      widget.data.name.toString(),
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFormField(
                      title: 'Set PIN (6 digit number)',
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      controller: pinController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFilledButton(
                      title: 'Continue',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  widget.data.copyWith(
                                      pin: pinController.text,
                                      profilePicture: selectedImage == null
                                          ? null
                                          : getStringImage(selectedImage)),
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
