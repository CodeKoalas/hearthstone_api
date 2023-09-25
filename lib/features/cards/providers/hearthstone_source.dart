import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Core elements.
import 'package:hearthstone_api/core/providers/dio.dart';

// Cards feature elements.
import 'package:hearthstone_api/features/cards/data/sources/hearthstone_omgvamp.dart';

part 'hearthstone_source.g.dart';

@riverpod
HearthstoneOmgVamp getHearthstoneOmgVamp(GetHearthstoneOmgVampRef ref) {
  const apiKey = 'd81bbd0981mshdf3640f69bcd62cp159eb1jsn00fc678a35b4';
  const host = 'omgvamp-hearthstone-v1.p.rapidapi.com';
  const baseUrl = 'https://omgvamp-hearthstone-v1.p.rapidapi.com';
  final options = BaseOptions(baseUrl: baseUrl, headers: {
    'X-RAPIDAPI-KEY': apiKey,
    'X-RAPIDAPI-HOST': host,
  });
  final adapter = ref.watch(dioAdapterProvider(options: options));

  return HearthstoneOmgVamp(adapter: adapter, baseUrl: baseUrl, apiKey: apiKey, host: host);
}
