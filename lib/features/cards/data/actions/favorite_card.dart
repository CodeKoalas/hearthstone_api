import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/data/intents/intents.dart';
import 'package:hearthstone_api/features/cards/domain/models/card.dart';

/// An action for marking a card as favorited. It will either add or remove the
/// card from the box depending on if it's already favorited or not.
class FavoriteCardAction extends Action<FavoriteCardIntent> {
  FavoriteCardAction({
    required this.favorited,
    required this.box,
    this.onInvokeComplete,
  });

  final bool favorited;
  final Box<HearthstoneCard> box;
  final VoidCallback? onInvokeComplete;

  @override
  void invoke(FavoriteCardIntent intent) {
    // Now we just need to either favorite or unfavorite the card.
    if (favorited) {
      box.delete(intent.card.cardId);
    } else {
      box.put(intent.card.cardId, intent.card);
    }

    // Now invalidate the favorite card provider for this card.
    onInvokeComplete?.call();
  }
}
