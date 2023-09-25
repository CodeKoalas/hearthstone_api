import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Core elements.
import 'package:hearthstone_api/core/data/adapters/dio_adapter.dart';
import 'package:hearthstone_api/core/providers/dio.dart';

// Card feature elements.
import 'package:hearthstone_api/features/cards/domain/models/card.dart';
import 'package:hearthstone_api/features/cards/providers/hearthstone_source.dart';

part 'get_single_card.g.dart';

@riverpod
FutureOr<HearthstoneCard?> getSingleCard(GetSingleCardRef ref, {required String cardName}) async {
  final source = ref.watch(getHearthstoneOmgVampProvider);
  final options = BaseOptions(baseUrl: source.baseUrl, headers: {
    'X-RAPIDAPI-KEY': source.apiKey,
    'X-RAPIDAPI-HOST': source.host,
  });
  final adapter = ref.watch(dioAdapterProvider(options: options));

  final response = await adapter.get<Map<String, dynamic>>(
    DioAdapterOptions(path: source.getSingleCard(cardName)),
  );

  return response.when(
    success: (data) {
      try {
        final card = HearthstoneCard.fromJson(data);
        return card;
      } catch (e, trace) {
        print(e);
        print(trace);
        return null;
      }
    },
    failure: (message, trace) {
      print(message);
      print(trace);
      return null;
    },
  );
}
