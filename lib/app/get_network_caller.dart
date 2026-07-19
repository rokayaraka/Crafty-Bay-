import '../core/service/network_caller/network_caller.dart';
import 'providers/auth_controller.dart';

NetworkCaller getNetworkCaller() {
  Map<String, String> headers = {'content-type': 'application/json'};
  if (AuthController.accessToken != null) {
    headers['token'] = AuthController.accessToken!;
  }

  return NetworkCaller(headers: () => headers);
}


//Uses
// NetWorkResponse response = await getNetworkCaller().getRequest('bdd');
// if(response.isSuccess){}
// else{
//   response.errorMsg!
// }