import 'package:crafty_bay/app/get_network_caller.dart';
import 'package:flutter/material.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/sign_in_params.dart';
import '../../data/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInInProgress = false;
  bool get signInInProgress => _signInInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params) async {
    bool isSuccess = false;
    _signInInProgress = true;
    notifyListeners();
    final NetWorkResponse response = await getNetworkCaller().postRequest(
      Urls.signInUrl,
      params.toJson(),
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      String token = response.body['data']['token'];
       UserModel userModel = UserModel.fromJson(response.body['data']['user']);
      //TODO: save token and user data in shared preferences
      await AuthController.saveUserData(token, userModel);
      

    } else {
      _errorMessage = response.errorMsg;
    }

    _signInInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
