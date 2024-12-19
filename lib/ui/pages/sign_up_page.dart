import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/models/sign_up_form_model.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/pages/sign_up_set_profile_page.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:ewallet_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              showCustomSnackbar(context, state.e);
            }

            if (state is AuthCheckEmailSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpSetProfilePage(
                          data: SignUpFormModel(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text))));
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
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
                    style: blackTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormField(
                          title: 'Nama Lengkap',
                          controller: nameController,
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          title: 'Email',
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          title: 'Password',
                          isPassword: true,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomFilledButton(
                          title: 'Continue',
                          onPressed: () {
                            if (validate()) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthCheckEmail(emailController.text));
                            } else {
                              showCustomSnackbar(
                                  context, 'Semua field harus diisi');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomOutlineButton(
                          title: 'Sign In',
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign-in');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]);
          },
        ),
      ),
    );
  }
}
