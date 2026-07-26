import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  final Map<String, String> Function() headers;

  final VoidCallback onUnauthorized;

  NetworkCaller({required this.headers, required this.onUnauthorized});

  // Get
  Future<NetWorkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, headers: headers());
      final Response response = await get(uri, headers: headers());
      _logResponse(response);

      if (response.statusCode == 200) {
        // Success
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        //Unauthorized
        onUnauthorized();
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: 'Unauthorized',
        );
      } else {
        // Failed
        // {
        //   'message' : 'something went wrong'
        // }
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: decodedJson['msg'] ?? 'Something went wrong!',
        );
      }
    } on Exception catch (e) {
      return NetWorkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMsg: e.toString(),
      );
    }
  }

  // Post
  Future<NetWorkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
    bool isFormLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, requestBody: body, headers: headers());
      final Response response = await post(
        uri,
        headers: headers(),
        body: jsonEncode(body),
      );
      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401 && isFormLogin==false) {
        //Unauthorized
        
        onUnauthorized();
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: 'Unauthorized',
        );
      } else {
        // Failed
        // {
        //   'message' : 'something went wrong'
        // }
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: decodedJson['msg'] ?? 'Something went wrong!',
        );
      }
    } on Exception catch (e) {
      return NetWorkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMsg: e.toString(),
      );
    }
  }


  void _logRequest(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, String>? headers,
  }) {
    _logger.d('''URL => $url
    Headers => $headers
    RequestBody => $requestBody
    ''');
  }

  void _logResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      _logger.i('''URL => ${response.request?.url}
    Status Code => ${response.statusCode}
    RequestBody => ${response.body}
    ''');
    } else {
      _logger.e('''URL => ${response.request?.url}
    Status Code => ${response.statusCode}
    RequestBody => ${response.body}
    ''');
    }
  }


    // Delete
  Future<NetWorkResponse> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, headers: headers());
      final Response response = await delete(uri, headers: headers());
      _logResponse(response);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return NetWorkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 401) {
        onUnauthorized();
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: 'Unauthorized',
        );
      } else {
        final decodedJson = response.body.isNotEmpty ? jsonDecode(response.body) : null;
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: decodedJson?['msg'] ?? 'Something went wrong!',
        );
      }
    } on Exception catch (e) {
      return NetWorkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMsg: e.toString(),
      );
    }
  }

}
