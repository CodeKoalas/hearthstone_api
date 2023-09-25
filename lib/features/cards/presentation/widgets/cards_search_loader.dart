import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:supercharged/supercharged.dart';

// Core elements.
import 'package:hearthstone_api/core/presentation/themes.dart';

part 'cards_search_loader.g.dart';

@riverpod
class CardsSearchLoaderNotifier extends _$CardsSearchLoaderNotifier {
  @override
  int build() {
    Timer.periodic(5.seconds, (timer) {
      state = state + 1;
      if (state > 5) {
        timer.cancel();
      }
    });
    return 0;
  }
}

class CardsSearchLoader extends ConsumerWidget {
  const CardsSearchLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(cardsSearchLoaderNotifierProvider);
    late final String message;
    switch (index) {
      case 0:
        message = 'Loading';
        break;
      case 1:
        message = 'Lots of really cool cards to load!';
        break;
      case 2:
        message = 'Okay, so the kobolds are a bit of a pain...';
        break;
      case 3:
        message = 'Ugh, sorry gnoll attack slowed things down a bit...';
        break;
      case 4:
        message = 'GIANT LIZARDS! I KID YOU NOT THE BIGGEST LIZARDS I\'VE EVER SEEN! HOLD THE LINE!';
        break;
      case 5:
        message = 'Okay, okay, okay, we\'re almost there!';
        break;
      default:
        message = 'Well... this is awkward...';
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(message),
        const CircularProgressIndicator.adaptive().padding(vertical: Spacing.four),
      ],
    );
  }
}
