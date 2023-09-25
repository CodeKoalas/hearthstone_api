import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hearthstone_api/features/cards/providers/get_single_card.dart';
import 'package:styled_widget/styled_widget.dart';

// Koality Core features.
import 'package:hearthstone_api/core/presentation/themes.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/domain/models/card.dart';

class CardDetailBody extends ConsumerWidget {
  const CardDetailBody({super.key, required this.cardName});

  final String cardName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(getSingleCardProvider(cardName: cardName));
    return switch (card) {
      AsyncData(:final value) => buildBody(context, value),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget buildBody(BuildContext context, HearthstoneCard? card) {
    if (card != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeaderBackground(context, card).constrained(maxHeight: 375),
          buildDetails(context, card).expanded(),
        ],
      );
    } else {
      return Center(
        child: Column(
          children: [Text('Card not found: $cardName')],
        ),
      );
    }
  }

  Widget buildHeaderBackground(BuildContext context, HearthstoneCard card) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            _buildParallaxBackground(context, card),
            _buildGradient(),
            _buildTitleAndSubtitle(card),
          ],
        ),
      ),
    );
  }

  Widget buildDetails(BuildContext context, HearthstoneCard card) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(card.health.toString()).padding(all: Spacing.four),
        if (card.faction != null) Text(card.faction!).padding(all: Spacing.four),
        if (card.rarity != null) Text(card.rarity!).padding(all: Spacing.four),
        if (card.artist != null) Align(alignment: Alignment.bottomLeft, child: Text(card.artist!)),
      ],
    ).expanded();
  }

  Widget _buildParallaxBackground(BuildContext context, HearthstoneCard card) {
    late final Widget child;
    if (card.img == null) {
      child = Positioned.fill(
        child: Container(
          color: Colors.grey[800],
        ),
      );
    } else {
      child = Positioned.fill(
        child: CachedNetworkImage(
          imageUrl: card.img!,
          fit: BoxFit.cover,
        ),
      );
    }

    return Hero(tag: card, child: child);
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle(HearthstoneCard card) {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            card.cardSet,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
