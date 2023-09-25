import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:styled_widget/styled_widget.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/data/actions/favorite_card.dart';
import 'package:hearthstone_api/features/cards/data/intents/intents.dart';
import 'package:hearthstone_api/features/cards/domain/models/card.dart';
import 'package:hearthstone_api/features/cards/presentation/widgets/card_body.dart';
import 'package:hearthstone_api/features/cards/providers/favorite_card.dart';
import 'package:hearthstone_api/features/cards/providers/favorite_cards_box.dart';
import 'package:hearthstone_api/features/cards/providers/get_single_card.dart';

part 'card.g.dart';

typedef HearthstoneCardWidgetData = (HearthstoneCard?, Box<HearthstoneCard>, bool);

@riverpod
Future<HearthstoneCardWidgetData> hearthstoneCardBuilder(
  HearthstoneCardBuilderRef ref, {
  required String cardName,
}) async {
  final card = await ref.watch(getSingleCardProvider(cardName: cardName).future);
  final box = await ref.watch(getFavoriteCardsBoxProvider.future);
  final favorited = ref.watch(getFavoriteCardProvider(card: card)).value ?? false;

  return (card, box, favorited);
}

class HearthstoneCardWidget extends ConsumerWidget {
  const HearthstoneCardWidget({super.key, required this.cardName});

  final String cardName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildData = ref.watch(hearthstoneCardBuilderProvider(cardName: cardName));
    return switch (buildData) {
      AsyncError(:final error) => Column(
        children: [
          const Icon(Icons.mood_bad),
          Text(error.toString()),
        ],
      ),
      AsyncData(:final value) => value.$1 == null
          ? Column(
              children: [
                const Icon(Icons.mood_bad),
                Text('Unable to find: $cardName'),
              ],
            )
          : Actions(
              actions: <Type, Action<Intent>>{
                FavoriteCardIntent: FavoriteCardAction(
                  favorited: value.$3,
                  box: value.$2,
                  onInvokeComplete: () {
                    ref.invalidate(getFavoriteCardProvider(card: value.$1));
                  },
                ),
              },
              child: value.$1 != null ? HearthstoneCardBodyWidget(card: value.$1!) : const Icon(Icons.mood_bad),
            ),
      _ => const CircularProgressIndicator.adaptive().center(),
    };
  }
}
