import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../navigation/app_state_cubit/app_state_cubit.dart';
import '../../../../../services/injectible/injectible_init.dart';
import '../../widgets/email_field.dart';
import '../../widgets/password_field.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static const path = '/sign-up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => getIt<SignUpCubit>(),
        child: Builder(
          builder: (context) {
            return BlocListener<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  context.read<AppStateCubit>().checkAuthStatus();
                } else if (state is SignUpError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorText)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: context.read<SignUpCubit>().formKey,
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
                          'Sign up',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        EmailField(
                          controller:
                              context.read<SignUpCubit>().emailController,
                        ),
                        const SizedBox(height: 10),
                        PasswordField(
                          controller:
                              context.read<SignUpCubit>().passwordController,
                        ),
                        const SizedBox(height: 30),
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          child: InkWell(
                            onTap: () async {
                              final formState = context
                                  .read<SignUpCubit>()
                                  .formKey
                                  .currentState;
                              if (formState?.validate() ?? false) {
                                await context.read<SignUpCubit>().signUp();
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
                                    'Sign up',
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
                              'Do you have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Routemaster.of(context).pop();
                              },
                              child: const Text(
                                'Sign in',
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
