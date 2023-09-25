import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Core elements.
import 'package:hearthstone_api/core/presentation/layouts/layouts.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/presentation/screens/card_detail/card_detail_body.dart';

@RoutePage()
class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, @PathParam('cardName') required this.cardName});

  final String cardName;

  Widget mobile(BuildContext context) {
    return MobileLayout(
      bodyBuilder: (_) {
        return CardDetailBody(cardName: cardName);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout.builder(mobile: mobile, tablet: mobile);
  }
}
