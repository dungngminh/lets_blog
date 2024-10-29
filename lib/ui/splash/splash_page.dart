import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_blog/ui/app/bloc/user_session/user_session_bloc.dart';
import 'package:lets_blog/ui/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashView(
      onUnauthenticated: () {
        context.router.replace(const LoginRoute());
      },
      onAuthenticated: () {
        context.router.replace(const MainRoute());
      },
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
    required this.onUnauthenticated,
    required this.onAuthenticated,
  });

  final VoidCallback onUnauthenticated;

  final VoidCallback onAuthenticated;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSessionBloc, UserSessionState>(
      listener: (context, state) {
        switch (state) {
          case UserSessionAuthenticated():
            onAuthenticated();
          case UserSessionUnauthenticated():
            onUnauthenticated();
          case _:
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
