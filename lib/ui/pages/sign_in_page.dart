import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/models/sign_in_form_model.dart';
import 'package:ewallet_app/shared/shared_method.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/widgets/buttons.dart';
import 'package:ewallet_app/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
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
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
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
                    'Sign In',
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
                          title: 'Sign In',
                          onPressed: () {
                            if (validate()) {
                              context.read<AuthBloc>().add(AuthLogin(
                                  SignInFormModel(
                                      email: emailController.text,
                                      password: passwordController.text)));
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
                          title: 'Sign Up',
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign-up');
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ]);
          },
        ),
      ),
    );
  }
}
