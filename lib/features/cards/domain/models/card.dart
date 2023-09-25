// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hearthstone_api/core/domain/serializer_helpers.dart';

part 'card.freezed.dart';
part 'card.g.dart';

@freezed
class HearthstoneCard with _$HearthstoneCard {
  const HearthstoneCard._();
  const factory HearthstoneCard({
    required String cardId,
    required int dbfId,
    required String name,
    required String cardSet,

    @JsonKey(fromJson: deserializeIntFromPossibleNull)
    int? health,

    String? playerClass,
    String? type,
    String? img,
    String? artist,
    String? rarity,
    String? faction,
    String? imgGold,
  }) = _HearthstoneCard;

  factory HearthstoneCard.fromJson(Map<String, dynamic> json) =>
      _$HearthstoneCardFromJson(json);
}