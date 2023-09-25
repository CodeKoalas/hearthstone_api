import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:supercharged/supercharged.dart';

// Core elements.
import 'package:hearthstone_api/core/presentation/layouts/layouts.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/presentation/screens/cards_search/cards_search_body.dart';
import 'package:hearthstone_api/features/cards/providers/get_cards_search.dart';

@RoutePage()
class CardsSearchScreen extends ConsumerWidget {
  const CardsSearchScreen({super.key});

  Widget mobile(BuildContext context, bool searchOpen) {
    final child = searchOpen ? TextFormField() : const Text('Hearthstone Cards');
    return MobileLayout(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: 300.milliseconds,
          child: child,
        ),
      ),
      bodyBuilder: (_) {
        return const CardsSearchBody();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchOpen = ref.watch(cardsSearchToggleNotifierProvider());
    return ScreenTypeLayout.builder(
      mobile: (_) => mobile(_, searchOpen),
      tablet: (_) => mobile(_, searchOpen),
    );
  }
}
