import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lets_blog/l10n/l10n.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}


class HomeGreeing extends StatelessWidget {
  const HomeGreeing({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Text(context.l10n.goodMorningLabel)
        
      ],),
    );
  }
}
