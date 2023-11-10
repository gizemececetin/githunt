import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path_utils;

import '../environment.dart';
import '../network.dart';


class NetClient {
  final _log = Logger('NetClient');
  final Dio client;
  final bool useUpdatedEnvironment;
  final NetJson jsonHandler;

  String? _currentToken;

  final path_utils.Context? _pathContext;

  /// Set the token to use for request authentication.
  // ignore: avoid_setters_without_getters
  set token(String? token) => _currentToken = token;



  /// Returns the current or default token.
  String? currentToken({
    bool useDefaultToken = false,
  }) =>
      (useDefaultToken || _currentToken == null)
          ? EnvironmentConfiguration.current.defaultToken
          : _currentToken;

  /// The default language to ask the backend.
  String defaultLanguage;

  NetClient({
    this.useUpdatedEnvironment = false,
    this.jsonHandler = const NetJson(),
    Map<String, dynamic>? defaultHeaders,
    this.defaultLanguage = 'en',
    HttpClient Function()? createHttpClient,
  })  : client = Dio(
          BaseOptions(
            baseUrl: EnvironmentConfiguration.current.fullUrl,
            headers: defaultHeaders,
          ),
        ),
        _pathContext = useUpdatedEnvironment
            ? path_utils.Context(style: path_utils.Style.url)
            : null {
    if (createHttpClient != null &&
        client.httpClientAdapter is IOHttpClientAdapter) {
      (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          createHttpClient;
    }
  }

  /// Adds a new interceptor to this client.
  void addInterceptor(Interceptor i) => client.interceptors.add(i);

  /// Removes an interceptor from this client.
  bool removeInterceptor(Interceptor i) => client.interceptors.remove(i);

  Future<bool> clearCache() => Future.value(true);

  Options buildOptions({
    String? token,
    String? authorizationHeader,
    NetRequestMethods? method,
    bool? forceRefresh,
    ContentType? contentType,
    ResponseType responseType = ResponseType.json,
  }) =>
      Options(
      /*   headers: {
          if (authorizationHeader != null) "Authorization": authorizationHeader,
          if (authorizationHeader == null && token != null)
            "Authorization": "Bearer $token",
        },
        method: method?.name,
        contentType: (contentType ?? ContentType.json).mimeType,
        responseType: responseType, */
      );

  Future<NetResponse> request(
    String path, {
    NetRequestMethods method = NetRequestMethods.get,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool decodeResponse = true,
    bool useDefaultToken = false,
    String? language,
    bool? forceRefresh,
    String? authorizationHeader,
    bool throwAllErrors = true,
    ResponseType responseType = ResponseType.plain,
  }) async {
    final effectivePath = useUpdatedEnvironment
        ? _pathContext!.join(EnvironmentConfiguration.current.baseUrl, path)
        : path;

    final encodedData = await jsonHandler.encode(data);


    try {
      final response = await client.request(
        effectivePath,
        data: encodedData,
        queryParameters: {
          if (queryParameters != null) ...queryParameters,
        },
        options: buildOptions(
          token: currentToken(useDefaultToken: useDefaultToken),
          authorizationHeader: authorizationHeader,
          method: method,
          forceRefresh: forceRefresh,
          responseType: responseType,
        ),
      );

      return await _buildResponse(
        response: response,
        decodeResponse: decodeResponse,
      );
    } catch (e) {
      _log.severe('${method.name}: $e');

      rethrow;
    }
  }

  /// Builds a [NetResponse] based on the response from the request.
  Future<NetResponse> _buildResponse({
    required Response? response,
    required bool decodeResponse,
  }) async {
    final decodedData = !decodeResponse
        ? response?.data
        : (response?.data is String
                ? (response?.data?.isEmpty ?? true)
                : response?.data == null)
            ? null
            : await jsonHandler.decode(response?.data);

    return NetResponse(
      data: decodedData,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }

}
