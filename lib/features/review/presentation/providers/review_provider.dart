import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../../../app/get_network_caller.dart';

import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';

import '../../data/models/review_model.dart';

class ReviewProvider extends ChangeNotifier {
  final List<ReviewModel> _reviewList = [];

  List<ReviewModel> get reviewList => _reviewList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAdding = false;
  bool get isAdding => _isAdding;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getReviewList(String productId) async {
    _isLoading = true;
    notifyListeners();

    final NetWorkResponse response = await getNetworkCaller().getRequest(
      Urls.reviewListUrl(productId),
    );

    if (response.isSuccess) {
      final List<dynamic> results = response.body['data']['results'];
      log('Review List: $results');
      // _reviewList
      // ..clear()
      // ..addAll(
      //   results.map<ReviewModel>((item) => ReviewModel.fromJson(item)).toList(),
      // );
      _reviewList.clear();

      for (final item in results) {
        try {
          _reviewList.add(ReviewModel.fromJson(item));
        } catch (e) {
          debugPrint('Failed to parse: $item');
          debugPrint(e.toString());
        }
      }

      // _reviewList = results.map((item) => ReviewModel.fromJson(item)).toList();
      // try {
      //   _reviewList =_reviewList..addAll( results.map((e) => ReviewModel.fromJson(e)).toList());
      // } catch (e, s) {
      //   debugPrint(e.toString());
      //   debugPrintStack(stackTrace: s);
      // }
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _errorMessage = response.errorMsg;
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> addReview({
    required String productId,
    required String firstName,
    required String lastName,
    required String comment,
    required String rating,
  }) async {
    _isAdding = true;
    notifyListeners();

    final NetWorkResponse response = await getNetworkCaller().postRequest(
      Urls.reviewUrl(productId),
      body: {'comment': comment, 'product': productId, 'rating': rating},
    );

    if (response.isSuccess) {
      await getReviewList(productId);
      _isAdding = false;
      notifyListeners();
      return true;
    }

    _errorMessage = response.errorMsg;
    _isAdding = false;
    notifyListeners();
    return false;
  }
}
