import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_blog/l10n/l10n.dart';
import 'package:lets_blog/ui/app/bloc/user_session/user_session_bloc.dart';
import 'package:lets_blog/ui/app_router.gr.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<UserSessionBloc, UserSessionState>(
      listener: (context, state) {
        if (state is UserSessionUnauthenticated) {
          context.router.replace(const LoginRoute());
        }
      },
      child: AutoTabsScaffold(
        transitionBuilder: (context, child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        routes: const [
          HomeRoute(),
          SearchRoute(),
          FavoriteRoute(),
          ProfileRoute(),
        ],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(l10n.createPostLabel),
          icon: const Icon(PhosphorIconsRegular.pencil),
        ),
        bottomNavigationBuilder: (_, tabsRouter) {
          return NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: [
              NavigationDestination(
                icon: const Icon(PhosphorIconsRegular.houseSimple),
                selectedIcon: const Icon(PhosphorIconsFill.houseSimple),
                label: l10n.homeLabel,
              ),
              NavigationDestination(
                icon: const Icon(PhosphorIconsRegular.magnifyingGlass),
                selectedIcon: const Icon(PhosphorIconsFill.magnifyingGlass),
                label: l10n.searchLabel,
              ),
              NavigationDestination(
                icon: const Icon(PhosphorIconsRegular.heart),
                selectedIcon: const Icon(PhosphorIconsFill.heart),
                label: l10n.favoritesLabel,
              ),
              NavigationDestination(
                icon: const Icon(PhosphorIconsRegular.user),
                selectedIcon: const Icon(PhosphorIconsFill.user),
                label: l10n.profileLabel,
              ),
            ],
          );
        },
      ),
    );
  }
}
