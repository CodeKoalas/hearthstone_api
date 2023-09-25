import 'package:flutter/material.dart';
import 'package:hearthstone_api/features/cards/domain/models/card.dart';

class CardsSearchIntent extends Intent {
  const CardsSearchIntent({this.text = ''});

  final String text;
}

class FavoriteCardIntent extends Intent {
  const FavoriteCardIntent(this.card);

  final HearthstoneCard card;
}
