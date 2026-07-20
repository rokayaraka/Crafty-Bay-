import 'package:crafty_bay/features/products/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';

class ProductListProvider extends ChangeNotifier {
  bool _isInitialLoading = false;
  bool _isLoadingMore = false;

  final int _productPerPage = 32;

  String? _errormsg;

  int? _lastPage;
  int _currentPage = 0;

  final List<ProductModel> _productList = [];

  bool get isInitialLoading => _isInitialLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errormsg => _errormsg;
  List<ProductModel> get productList => _productList;

  Future<bool> getProductData() async {
    bool isSuccess = false;

    //Current page > last page || is that initial page?
    if (_currentPage == 0 || _lastPage != null && _currentPage < _lastPage!) {
      _currentPage++;
    } else {
      return false;
    }
    if (_currentPage == 1) {
      _isInitialLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    //Load Data from API
    final NetWorkResponse response = await getNetworkCaller().getRequest(
     Urls.productListUrl(_currentPage, _productPerPage),
    );
    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList.addAll(list);
      _lastPage = response.body['data']['last_page'];
    } else {
      _errormsg = response.errorMsg;
    }

    if (_currentPage == 1) {
      _isInitialLoading = false;
    } else {
      _isLoadingMore = false;
    }
    notifyListeners();
    return isSuccess;
  }

  void refreshCategoryList() {
    _currentPage = 0;
    _lastPage = null;
    _productList.clear();
    getProductData();
  }

  bool get isLoading => _isInitialLoading || _isLoadingMore;
}
