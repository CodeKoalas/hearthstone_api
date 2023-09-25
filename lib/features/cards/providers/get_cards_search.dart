import 'package:riverpod_annotation/riverpod_annotation.dart';

// Core elements.
import 'package:hearthstone_api/core/riverpod.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/domain/models/card.dart';
import 'package:hearthstone_api/features/cards/providers/hearthstone_source.dart';

part 'get_cards_search.g.dart';

@riverpod
class CardsSearchToggleNotifier extends _$CardsSearchToggleNotifier {
  @override
  bool build({bool initialToggle = false}) {
    return initialToggle;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
class CardsSearchNotifier extends _$CardsSearchNotifier {
  @override
  String build({String initialSearch = ''}) {
    return initialSearch;
  }

  void setSearchTerm(String searchTerm) {
    state = searchTerm;
  }
}

@riverpod
FutureOr<List<HearthstoneCard>> getCards(GetCardsRef ref) async {
  final source = ref.watch(getHearthstoneOmgVampProvider);
  // @TODO: Local storage save last search.
  final searchTerm = ref.watch(cardsSearchNotifierProvider());
  final response = await source.fetchAllCards(token: ref.cancelToken(), searchTerm: searchTerm);

  return response.when(
    success: (data) {
      return data;
    },
    failure: (message, trace) {
      print(message);
      print(trace);
      return const [];
    },
  );
}
