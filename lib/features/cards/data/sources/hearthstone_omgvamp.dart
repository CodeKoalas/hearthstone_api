import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Core feature elements.
import 'package:hearthstone_api/core/data/adapters/dio_adapter.dart';
import 'package:hearthstone_api/core/data_classes.dart';

// Cards feature elements.
import 'package:hearthstone_api/features/cards/domain/models/card.dart';

part 'hearthstone_omgvamp.freezed.dart';

@freezed
class HearthstoneOmgVamp with _$HearthstoneOmgVamp {
  const HearthstoneOmgVamp._();
  const factory HearthstoneOmgVamp({
    required String baseUrl,
    required String apiKey,
    required String host,
    required DioAdapter adapter,
  }) = _HearthstoneOmgVamp;

  String get cardsUrl => '$baseUrl/cards';
  String getSingleCard(String cardName) => '$cardsUrl/$cardName';
  String getCardsByClass(String className) => '$cardsUrl/classes/$className';
  String getCardsBySet(String setName) => '$cardsUrl/sets/$setName';
  String getCardsByType(String typeName) => '$cardsUrl/types/$typeName';
  String getCardsByFaction(String factionName) => '$cardsUrl/factions/$factionName';
  String getCardsByRarity(String rarityName) => '$cardsUrl/qualities/$rarityName';
  String getCardsBySearchTerm(String searchTerm) => '$cardsUrl/search/$searchTerm';

  FutureOr<ActionResult<String, HearthstoneCard>> fetchSingleCard({
    required CancelToken token,
    String? searchTerm,
  }) async {
    if (searchTerm == null) {
      return ActionResult.failure('Missing search term was: $searchTerm', StackTrace.current);
    }
    // @TOOD: Add caching with Hive.
    final response = await adapter.get<Map<String, dynamic>>(
      DioAdapterOptions(path: getSingleCard(searchTerm), cancelToken: token),
    );

    return response.when(
      success: (data) {
        try {
          return ActionResult.success(HearthstoneCard.fromJson(data));
        } catch (e, trace) {
          return ActionResult.failure(getFormattedError('Unable to find card for: $searchTerm', e), trace);
        }
      },
      failure: (message, trace) {
        return ActionResult.failure('Unable to search for card: $message', trace);
      },
    );
  }

  FutureOr<ActionResult<String, List<HearthstoneCard>>> fetchAllCards({
    required CancelToken token,
    String? searchTerm,
  }) async {
    if (searchTerm == null) {
      return ActionResult.failure('Missing search term was: $searchTerm', StackTrace.current);
    }
    // @TOOD: Add caching with Hive.
    final response = await adapter.get<Map<String, dynamic>>(
      DioAdapterOptions(path: searchTerm.isEmpty ? cardsUrl : getCardsBySearchTerm(searchTerm), cancelToken: token),
    );

    return response.when(
      success: (data) {
        try {
          // Since the adapter returns a Map<String, dynamic> but we need to convert it into a
          // Map<String, List<dynamic>>.
          final cardList = data.values.cast<List<dynamic>>().toList();

          // The data is formatted as a Map of keys where each value is a list of cards.
          // Need to reduce the list of cards to a single list and then map each card
          // in the list to a HearthstoneCard.fromJson.
          final cards = cardList.reduce((value, element) => value + element).map((e) {
            return HearthstoneCard.fromJson(e);
          }).toList();
          return ActionResult.success(cards);
        } catch (e, trace) {
          return ActionResult.failure(getFormattedError('Unable to find cards for: $searchTerm', e), trace);
        }
      },
      failure: (message, trace) {
        return ActionResult.failure('Unable to search for cards: $message', trace);
      },
    );
  }
}

String getFormattedError(String message, dynamic error) => '''
$message
Error: $error
''';
