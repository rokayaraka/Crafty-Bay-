
part of 'network_caller.dart';

class NetWorkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String? errorMsg;

  NetWorkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMsg,
  });
}
