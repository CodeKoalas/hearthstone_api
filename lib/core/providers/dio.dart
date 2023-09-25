import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Core elements.
import 'package:hearthstone_api/core/constants.dart';
import 'package:hearthstone_api/core/data/adapters/dio_adapter.dart';
import 'package:hearthstone_api/core/providers/alice.dart';

part 'dio.g.dart';

@riverpod
DioAdapter dioAdapter(DioAdapterRef ref, {required BaseOptions options}) {
  final alice = ref.watch(aliceProvider);
  final client = Dio(options);
  var isDev = kEnvironment == 'development';
  if (isDev) {
    client.interceptors.add(alice.getDioInterceptor());
  }
  return DioAdapter(client: client);
}
