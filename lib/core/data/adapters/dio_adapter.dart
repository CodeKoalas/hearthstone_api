import 'package:dio/dio.dart';

// Core elements.
import 'package:hearthstone_api/core/adapters.dart';

class DioAdapterOptions extends AdapterHttpOptions {
  const DioAdapterOptions({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    this.cancelToken,
  }) : super(
          path: path,
          query: query,
          body: body,
          headers: headers,
        );

  final CancelToken? cancelToken;

  @override
  List<Object?> get props => [...super.props, cancelToken];
}

class DioAdapter extends AsyncRestAdapter<AdapterResponse, DioAdapterOptions> {
  const DioAdapter({required this.client});

  final Dio client;

  Map<String, dynamic> get defaultHeaders {
    return {
      ...client.options.headers,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<AdapterResponse<T>> get<T>(DioAdapterOptions options) async {
    final response = await client.get<T>(
      options.path,
      queryParameters: options.query,
      cancelToken: options.cancelToken,
    );
    final statusCode = response.statusCode ?? 500;
    if ((statusCode >= 200 && statusCode < 300) && response.data != null) {
      return AdapterResponse.success(response.data as T);
    } else {
      return AdapterResponse.failure(response.statusMessage, StackTrace.current);
    }
  }

  @override
  Future<AdapterResponse<T>> post<T>(DioAdapterOptions options) async {
    final response = await client.post<T>(
      options.path,
      data: options.body,
      queryParameters: options.query,
      cancelToken: options.cancelToken,
    );
    final statusCode = response.statusCode ?? 500;
    if ((statusCode >= 200 && statusCode < 300) && response.data != null) {
      return AdapterResponse.success(response.data as T);
    } else {
      return AdapterResponse.failure(response.statusMessage, StackTrace.current);
    }
  }

  @override
  Future<AdapterResponse<T>> put<T>(DioAdapterOptions options) async {
    final response = await client.put<T>(
      options.path,
      data: options.body,
      queryParameters: options.query,
      cancelToken: options.cancelToken,
    );
    final statusCode = response.statusCode ?? 500;
    if ((statusCode >= 200 && statusCode < 300) && response.data != null) {
      return AdapterResponse.success(response.data as T);
    } else {
      return AdapterResponse.failure(response.statusMessage, StackTrace.current);
    }
  }

  @override
  Future<AdapterResponse<T>> patch<T>(DioAdapterOptions options) async {
    final response = await client.patch<T>(
      options.path,
      data: options.body,
      queryParameters: options.query,
      cancelToken: options.cancelToken,
    );
    final statusCode = response.statusCode ?? 500;
    if ((statusCode >= 200 && statusCode < 300) && response.data != null) {
      return AdapterResponse.success(response.data as T);
    } else {
      return AdapterResponse.failure(response.statusMessage, StackTrace.current);
    }
  }

  @override
  Future<AdapterResponse<T>> delete<T>(DioAdapterOptions options) async {
    final response = await client.delete<T>(
      options.path,
      queryParameters: options.query,
      cancelToken: options.cancelToken,
    );
    final statusCode = response.statusCode ?? 500;
    if ((statusCode >= 200 && statusCode < 300) && response.data != null) {
      return AdapterResponse.success(response.data as T);
    } else {
      return AdapterResponse.failure(response.statusMessage, StackTrace.current);
    }
  }
}
