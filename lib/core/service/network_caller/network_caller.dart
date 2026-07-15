import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

part  'network_response.dart';



class NetworkCaller {
  final Logger _logger = Logger();

  final  Map<String, String> Function() headers;

  NetworkCaller({required this.headers});

  ///GET///
  Future<NetWorkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: headers());
      final Response response = await get(uri, headers: headers());
      _logResponse(response);
      if (response.statusCode == 200) {
        //sucess
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        //failed
        // {
        //   'massage':"something went wrong"
        // }
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: decodedJson['massage'] ?? 'something went wrong',
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
  ///POST///
  Future<NetWorkResponse> postRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
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
        //sucess
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetWorkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMsg: decodedJson['msg'] ?? 'something went wrong',
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
    Headers=>$headers
    RequestBody => $requestBody
    ''');
  }

  void _logResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      _logger.i('''URL => ${response.request?.url}
    Status Code=>${response.statusCode}
    RequestBody => ${response.body}
    ''');
    } else {
      _logger.e('''URL => ${response.request?.url}
    Status Code=>${response.statusCode}
    RequestBody => ${response.body}
    ''');
    }
  }


}


