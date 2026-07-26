
import 'package:flutter/material.dart';
import '../../../../app/get_network_caller.dart';
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
     body:  params.toJson(),
     isFormLogin: true,
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      String token = response.body['data']['token'];
       UserModel userModel = UserModel.fromJson(response.body['data']['user']);
      await AuthController.saveUserData(token, userModel);
      

    } else {
      _errorMessage = response.errorMsg;
    }

    _signInInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
