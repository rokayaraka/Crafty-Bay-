import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/add_to_cart_params.dart';

class AddToCartProvider extends ChangeNotifier {
  bool _isLoading = false;

  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(AddToCartParams params) async {
    bool isSuccess = false;

    _isLoading = true;
    notifyListeners();

    final NetWorkResponse response = await getNetworkCaller().postRequest(
      Urls.cartUrl,
     body:  params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMsg;
    }

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }
}
