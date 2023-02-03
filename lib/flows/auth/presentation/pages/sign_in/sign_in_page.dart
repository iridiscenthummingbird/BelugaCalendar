import 'package:beluga_calendar/flows/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:beluga_calendar/services/injectible/injectible_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../navigation/app_state_cubit/app_state_cubit.dart';
import '../../widgets/email_field.dart';
import '../../widgets/password_field.dart';
import 'cubit/sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => getIt<SignInCubit>(),
        child: Builder(
          builder: (context) {
            return BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state is SignInSuccess) {
                  context.read<AppStateCubit>().checkAuthStatus();
                } else if (state is SignInError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorText)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: context.read<SignInCubit>().formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 140),
                        SvgPicture.asset(Assets.beluga.path),
                        const SizedBox(height: 20),
                        const Text(
                          "Beluga Time",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        EmailField(
                          controller:
                              context.read<SignInCubit>().emailController,
                        ),
                        const SizedBox(height: 10),
                        PasswordField(
                          controller:
                              context.read<SignInCubit>().passwordController,
                        ),
                        const SizedBox(height: 30),
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          child: InkWell(
                            onTap: () async {
                              final formState = context
                                  .read<SignInCubit>()
                                  .formKey
                                  .currentState;
                              if (formState?.validate() ?? false) {
                                await context.read<SignInCubit>().signIn();
                              }
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Routemaster.of(context).push(SignUpPage.path);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Color(0xFFFFE500),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
