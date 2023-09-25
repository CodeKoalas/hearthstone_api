import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/domain/constants.dart';
import 'package:hearthstone_api/features/cards/domain/models/card.dart';

part 'favorite_cards_box.g.dart';

@riverpod
Future<Box<HearthstoneCard>> getFavoriteCardsBox(GetFavoriteCardsBoxRef ref) async {
  return Hive.openBox<HearthstoneCard>(kFavoriteCardsBoxName);
}
