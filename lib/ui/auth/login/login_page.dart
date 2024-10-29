import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lets_blog/commons/types/validator.dart';
import 'package:lets_blog/di/di.dart';
import 'package:lets_blog/ui/app/bloc/user_session/user_session_bloc.dart';
import 'package:lets_blog/ui/app_router.gr.dart';
import 'package:lets_blog/ui/auth/login/bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(authRepository: getIt()),
      child: LoginView(
        onAuthSuccess: () {
          context.router.replace(const MainRoute());
        },
        onRegisterPressed: () {
          context.router.push(const RegisterRoute());
        },
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required this.onAuthSuccess,
    required this.onRegisterPressed,
  });

  final VoidCallback onAuthSuccess;
  final VoidCallback onRegisterPressed;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  void initializeController() {
    _emailController.addListener(() {
      context.read<LoginBloc>().add(
            LoginEmailChanged(_emailController.text),
          );
    });
    _passwordController.addListener(() {
      context.read<LoginBloc>().add(
            LoginPasswordChanged(_passwordController.text),
          );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSessionBloc, UserSessionState>(
      listener: (context, state) {
        if (state is UserSessionAuthenticated) {
          widget.onAuthSuccess();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    final email = context.select(
                      (LoginBloc bloc) => bloc.state.email,
                    );
                    return TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        errorText: email.mapErrorOrNull((e) {
                          return switch (e) {
                            ValueEmpty() => 'Value cannot be empty',
                            EmailInvalidFormat() => 'Email is invalid',
                            _ => null,
                          };
                        }),
                      ),
                    );
                  },
                ),
                const Gap(16),
                _buildPasswordField(),
                const Gap(24),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Builder(
      builder: (context) {
        final password = context.select(
          (LoginBloc bloc) => bloc.state.password,
        );
        return TextFormField(
          obscureText: true,
          controller: _passwordController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: password.mapErrorOrNull((e) {
              return switch (e) {
                ValueEmpty() => 'Value cannot be empty',
                PasswordTooShort() => 'Password is too short',
                _ => null,
              };
            }),
          ),
          onFieldSubmitted: (_) {
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return Builder(
      builder: (context) {
        final isFormValid = context.select(
          (LoginBloc bloc) => bloc.state.isFormValid,
        );
        return FilledButton(
          onPressed: !isFormValid
              ? null
              : () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
          child: const Text('Login'),
        );
      },
    );
  }
}
