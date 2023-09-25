import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

// Cards feature elements.
import 'package:hearthstone_api/features/cards/data/intents/intents.dart';
import 'package:hearthstone_api/features/cards/domain/extensions.dart';
import 'package:hearthstone_api/features/cards/domain/models/card.dart';
import 'package:hearthstone_api/features/cards/data/actions/favorite_card.dart';
import 'package:hearthstone_api/features/cards/providers/favorite_card.dart';
import 'package:hearthstone_api/features/cards/providers/favorite_cards_box.dart';
import 'package:hearthstone_api/core/presentation/widgets/error_view_widget.dart';
import 'package:hearthstone_api/core/presentation/widgets/future_aware_widget.dart';

class HearthstoneCardBodyWidget extends ConsumerWidget {
  const HearthstoneCardBodyWidget({super.key, required this.card});

  final HearthstoneCard card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorited = ref.watch(getFavoriteCardProvider(card: card)).value ?? false;
    final data = ref.watch(getFavoriteCardsBoxProvider);

    return switch (data) {
      AsyncError(:final error, :final stackTrace) => ErrorViewWidget.view(error, stackTrace),
      AsyncData(:final value) => Actions(
          actions: <Type, Action<Intent>>{
            FavoriteCardIntent: FavoriteCardAction(
              favorited: favorited,
              box: value,
              onInvokeComplete: () {
                ref.invalidate(getFavoriteCardProvider(card: card));
              },
            ),
          },
          child: Column(
            children: [
              Row(
                children: [
                  if (card.img != null) Expanded(child: CachedNetworkImage(imageUrl: card.img!)),
                  Text(card.name),
                ],
              ),
              if (card.faction != null) Text(card.faction!),
              FutureAwareWidget<Future<void>>(
                builder: (context, setter, snapshot) {
                  return switch (snapshot.connectionState) {
                    (ConnectionState.done) => buildIcon(context, favorited, setter),
                    (ConnectionState.active) => buildIcon(context, favorited, setter),
                    _ => const CircularProgressIndicator.adaptive().center(),
                  };
                },
              ),
            ],
          ),
        ),
      _ => const CircularProgressIndicator.adaptive().center(),
    };
  }

  Widget buildIcon(BuildContext context, bool favorited, void Function(Future<void>) setter) {
    return Icon(
      favorited ? Icons.favorite : Icons.favorite_border,
      color: Colors.red,
    ) //
        .alignment(Alignment.centerRight)
        .gestures(
      onTap: () {
        final future = context.invokeAction(
          FavoriteCardIntent(card),
        ) as Future<void>;
        setter(future);
      },
    );
  }
}
