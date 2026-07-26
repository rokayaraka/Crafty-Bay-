import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';

import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/cart_model.dart';

class CartListProvider extends ChangeNotifier {
  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();
    final NetWorkResponse response = await getNetworkCaller().getRequest(
      Urls.cartListUrl,
    );
    if (response.isSuccess) {
      _cartItems = response.body['data']['results']
          .map<CartModel>((item) => CartModel.fromJson(item))
          .toList();
          isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMsg;
    }
    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  int get totalPrice {
    int total = 0;
    for (CartModel item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  void updateCartItemQuantity(String cartItemId, int quantity) {
    for (CartModel item in _cartItems) {
      if (item.id == cartItemId) {
        item.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }

  void addItem(CartModel item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(CartModel item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}
