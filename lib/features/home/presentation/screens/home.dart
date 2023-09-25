import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hearthstone_api/core/presentation/themes.dart';
import 'package:hearthstone_api/features/app/data/router.dart';
import 'package:styled_widget/styled_widget.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Welcome to Hearthstone API!',
              style: Theme.of(context).textTheme.headlineLarge,
            ).padding(all: Spacing.four),
            const Text(
              'This is a sample app to demonstrate how to use the Hearthstone API.',
            ).padding(all: Spacing.four),
            ElevatedButton(
              onPressed: () => context.router.navigate(const CardsSearchRoute()),
              child: const Text('Get Started!'),
            ),
          ],
        ),
      ),
    );
  }
}
