/* import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../env/env.dart';

class CustomInterceptor implements InterceptorContract {
  @override
  Future<bool> shouldInterceptRequest() {
    return Future.value(true);
  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.value(true);
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final Map<String, String> headers = Map.from(request.headers);
    headers[HttpHeaders.contentTypeHeader] = "application/json";
    headers[HttpHeaders.authorizationHeader] = 'Bearer ${Env.apiKey}';
    return request.copyWith(
      url: request.url,
      headers: headers,
    );
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    switch (response.statusCode) {
      case 400:
        debugPrint(response.request.toString());
        return response;
      case 500:
        debugPrint(response.request.toString());
        return response;
      default:
        return response;
    }
  }
}
 */