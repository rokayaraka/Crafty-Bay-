import 'package:crafty_bay/app/get_network_caller.dart';
import 'package:flutter/material.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/sign_up_params.dart';

class SignUpProvider extends ChangeNotifier {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpParams params) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    notifyListeners();

    final NetWorkResponse response = await getNetworkCaller().postRequest(
      Urls.signUpUrl,
      params.toJson(),
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMsg;
    }

    _signUpInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
