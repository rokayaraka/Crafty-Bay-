
import 'package:flutter/material.dart';

import '../core/service/network_caller/network_caller.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import 'crafty_bay_app.dart';
import 'providers/auth_controller.dart';

NetworkCaller getNetworkCaller() {
  Map<String, String> headers = {'content-type': 'application/json'};
  if (AuthController.accessToken != null) {
    headers['token'] = AuthController.accessToken!;
  }

  return NetworkCaller(
    headers: () => headers,
    onUnauthorized: () async {
      //On User Unauthorize
      await AuthController.clearUserData();
      Navigator.pushNamed(
        CraftyBayApp.navigatorKey.currentContext!,
        SignUpScreen.name,
      );
    },
  );
}


//Uses
// NetWorkResponse response = await getNetworkCaller().getRequest('bdd');
// if(response.isSuccess){}
// else{
//   response.errorMsg!
// }