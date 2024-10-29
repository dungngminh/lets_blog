import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_blog/commons/generated/fonts.gen.dart';
import 'package:lets_blog/commons/theme/app_text_theme.dart';
import 'package:lets_blog/di/di.dart';
import 'package:lets_blog/l10n/l10n.dart';
import 'package:lets_blog/ui/app/bloc/theme/theme_bloc.dart';
import 'package:lets_blog/ui/app/bloc/user_session/user_session_bloc.dart';
import 'package:lets_blog/ui/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => UserSessionBloc(authRepository: getIt()),
        ),
      ],
      child: AppView(
        appRouter: _appRouter,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.select((ThemeBloc bloc) => bloc.state);
    return MaterialApp.router(
      routerConfig: appRouter.config(
        navigatorObservers: () => [
          AppRouterObserver(),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: "Let's Blog",
      themeMode: currentTheme,
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepPurple,
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        fontFamily: FontFamily.nunito,
        textTheme: AppTextTheme.textTheme,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.deepPurple,
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        fontFamily: FontFamily.nunito,
        textTheme: AppTextTheme.textTheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
