import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Core elements.
import 'package:hearthstone_api/core/data/adapters/dio_adapter.dart';
import 'package:hearthstone_api/core/data_classes.dart';

part 'example_backend.freezed.dart';

@freezed
class ExampleBackend with _$ExampleBackend {
  const ExampleBackend._();
  const factory ExampleBackend({
    required String baseUrl,
    required DioAdapter adapter,
    String? authToken,
  }) = _ExampleBackend;

  String getOneThingUrl(String name) => '$baseUrl/one-thing/$name';

  Future<ActionResult<Object?, Map<String, dynamic>>> getOneThing({
    required String name,
    required CancelToken token,
  }) async {
    final response = await adapter.get<Map<String, dynamic>>(
      DioAdapterOptions(
        path: getOneThingUrl(name),
        headers: {
          'Authorization': 'Bearer $authToken',
          ...adapter.defaultHeaders,
        },
      ),
    );

    return response.when(
      success: (data) {
        return ActionResult.success(data);
      },
      failure: ActionResult.failure,
    );
  }
}
