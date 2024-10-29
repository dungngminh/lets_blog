import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lets_blog/di/di.dart';
import 'package:lets_blog/domain/repositories/auth_repository.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              child: const Text('Log out'),
              onPressed: () {
                getIt<AuthRepository>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
