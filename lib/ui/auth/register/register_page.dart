import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lets_blog/commons/types/errors/auth_error.dart';
import 'package:lets_blog/commons/types/validators/app_validator.dart';
import 'package:lets_blog/commons/types/validators/validator.dart';
import 'package:lets_blog/di/di.dart';
import 'package:lets_blog/l10n/l10n.dart';
import 'package:lets_blog/ui/app_router.gr.dart';
import 'package:lets_blog/ui/auth/register/bloc/register_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(authRepository: getIt()),
      child: RegisterView(
        onBackPressed: () {
          context.router.back();
        },
        onRegisterSuccess: () {
          context.router.pushAndPopUntil(
            const LoginRoute(),
            predicate: (route) => false,
          );
        },
      ),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.onRegisterSuccess,
    required this.onBackPressed,
  });

  final VoidCallback onRegisterSuccess;
  final VoidCallback onBackPressed;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  void initializeController() {
    _emailController.addListener(() {
      context.read<RegisterBloc>().add(
            RegisterEmailChanged(_emailController.text),
          );
    });
    _passwordController.addListener(() {
      context.read<RegisterBloc>().add(
            RegisterPasswordChanged(_passwordController.text),
          );
    });
    _nameController.addListener(() {
      context.read<RegisterBloc>().add(
            RegisterNameChanged(_nameController.text),
          );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listenWhen: (previous, current) {
            return previous.error != current.error;
          },
          listener: (context, state) {
            if (!state.isError) return;
            context.showSnackBar(
              message: switch (state.error) {
                UserAlreadyExists() => context.l10n.userExistsErrorLabel,
                _ => context.l10n.unexpectedErrorLabel,
              },
              backgroundColor: context.theme.colorScheme.error,
            );
          },
        ),
        BlocListener<RegisterBloc, RegisterState>(
          listenWhen: (previous, current) {
            return previous.isRegisterSuccess != current.isRegisterSuccess;
          },
          listener: (context, state) {
            if (state.isRegisterSuccess) {
              context.showSnackBar(message: context.l10n.registerSuccessLabel);
              widget.onRegisterSuccess();
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _buildNameField(),
                const Gap(16),
                _buildEmailField(),
                const Gap(16),
                _buildPasswordField(),
                const Gap(24),
                _buildRegisterButton(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Builder(
      builder: (context) {
        final name = context.select(
          (RegisterBloc bloc) => bloc.state.name,
        );
        return TextFormField(
          controller: _nameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: context.l10n.nameLabel,
            hintText: context.l10n.inputYourNameLabel,
            errorText: name.mapErrorOrNull((e) {
              return switch (e) {
                ValueEmpty() => context.l10n.nameNotEmptyLabel,
                _ => null,
              };
            }),
          ),
        );
      },
    );
  }

  Widget _buildEmailField() {
    return Builder(
      builder: (context) {
        final email = context.select(
          (RegisterBloc bloc) => bloc.state.email,
        );
        return TextFormField(
          controller: _emailController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: context.l10n.emailLabel,
            hintText: context.l10n.inputYourEmailLabel,
            errorText: email.mapErrorOrNull((e) {
              return switch (e) {
                ValueEmpty() => context.l10n.emailNotEmptyLabel,
                EmailInvalidFormat() => context.l10n.emailNotValidLabel,
                _ => null,
              };
            }),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Builder(
      builder: (context) {
        final password = context.select(
          (RegisterBloc bloc) => bloc.state.password,
        );
        final hidePassword = context.select(
          (RegisterBloc bloc) => bloc.state.hidePassword,
        );
        return TextFormField(
          obscureText: hidePassword,
          controller: _passwordController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: hidePassword
                  ? const PhosphorIcon(PhosphorIconsRegular.eyeClosed)
                  : const PhosphorIcon(PhosphorIconsRegular.eye),
              onPressed: () {
                context
                    .read<RegisterBloc>()
                    .add(const RegisterTogglePasswordVisibility());
              },
            ),
            labelText: context.l10n.passwordLabel,
            hintText: context.l10n.inputYourPasswordLabel,
            errorText: password.mapErrorOrNull((e) {
              return switch (e) {
                ValueEmpty() => context.l10n.passwordNotEmptyLabel,
                PasswordTooShort() => context.l10n.passwordTooShortLabel,
                _ => null,
              };
            }),
          ),
          onFieldSubmitted: (_) {
            context.read<RegisterBloc>().add(const RegisterSubmitted());
          },
        );
      },
    );
  }

  Widget _buildRegisterButton() {
    return Builder(
      builder: (context) {
        final isFormValid = context.select(
          (RegisterBloc bloc) => bloc.state.isFormValid,
        );
        final isLoading = context.select(
          (RegisterBloc bloc) => bloc.state.isLoading,
        );
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FilledButton(
          onPressed: !isFormValid
              ? null
              : () {
                  context.read<RegisterBloc>().add(const RegisterSubmitted());
                },
          child: Text(context.l10n.signUpLabel),
        );
      },
    );
  }
}
