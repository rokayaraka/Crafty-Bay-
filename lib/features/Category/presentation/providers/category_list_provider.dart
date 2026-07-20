import 'package:flutter/material.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/category_model.dart';

class CategoryListProvider extends ChangeNotifier {
  bool _isInitialLoading = false;
  bool _isLoadingMore = false;

  final int _categoryPerPage = 32;

  String? _errormsg;

  int? _lastPage;
  int _currentPage = 0;

  final List<CategoryModel> _categoryList = [];

  bool get isInitialLoading => _isInitialLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errormsg => _errormsg;
  List<CategoryModel> get categoryList => _categoryList;

  Future<bool> getCategoryData() async {
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
      Urls.categoryListUrl(_currentPage, _categoryPerPage),
    );
    if (response.isSuccess) {
      List<CategoryModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']['results']) {
        list.add(CategoryModel.fromJson(jsonData));
      }
      _categoryList.addAll(list);
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
    _categoryList.clear();
    getCategoryData();
  }

  bool get isLoading => _isInitialLoading || _isLoadingMore;
}
