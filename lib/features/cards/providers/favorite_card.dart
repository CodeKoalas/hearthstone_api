import 'package:riverpod_annotation/riverpod_annotation.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/domain/models/card.dart';
import 'package:hearthstone_api/features/cards/providers/favorite_cards_box.dart';

part 'favorite_card.g.dart';

@riverpod
Future<bool> getFavoriteCard(GetFavoriteCardRef ref, {required HearthstoneCard? card}) async {
  if (card == null) {
    return false;
  }

  final box = await ref.watch(getFavoriteCardsBoxProvider.future);
  return box.containsKey(card.cardId);
}
