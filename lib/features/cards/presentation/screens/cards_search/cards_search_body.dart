import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

// Koality Core features.
import 'package:hearthstone_api/core/extension.dart';
import 'package:hearthstone_api/core/presentation/themes.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/presentation/widgets/cards_search_loader.dart';
import 'package:hearthstone_api/features/cards/providers/get_cards_search.dart';

class CardsSearchBody extends ConsumerWidget {
  const CardsSearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(getCardsProvider);
    return cards.when(
      data: (cardList) {
        final filtered = cardList.where((card) => card.img != null).toList();
        return GridView.builder(
          itemCount: filtered.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final card = filtered[index];
            return AspectRatio(
              aspectRatio: 9 / 16,
              child: Hero(
                tag: card,
                child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: card.img!),
              ),
            );
          },
        );
      },
      loading: () {
        return Center(child: const CardsSearchLoader().padding(horizontal: Spacing.four));
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
            style: context.textTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
        );
      },
    );
  }
}
