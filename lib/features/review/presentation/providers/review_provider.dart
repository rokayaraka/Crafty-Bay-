import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../../auth/data/models/user_model.dart';
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
      _reviewList
        
        .addAll(
          results
              .map<ReviewModel>((item) => ReviewModel.fromJson(item))
              .toList(),
        );
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
  }) async {
    _isAdding = true;
    notifyListeners();

    final NetWorkResponse response = await getNetworkCaller().postRequest(
      Urls.reviewUrl(productId),
      body: {'comment': comment, 'firstName': firstName, 'lastName': lastName},
    );

    if (response.isSuccess) {
      String token = response.body['data']['token'];
      UserModel userModel = UserModel.fromJson(response.body['data']['user']);
      await AuthController.saveUserData(token, userModel);
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
