import '../core/service/network_caller/network_caller.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {
      'content-type': 'application/json',
      //'access token':'token'
    },
  );
}


//Uses
// NetWorkResponse response = await getNetworkCaller().getRequest('bdd');
// if(response.isSuccess){}
// else{
//   response.errorMsg!
// }