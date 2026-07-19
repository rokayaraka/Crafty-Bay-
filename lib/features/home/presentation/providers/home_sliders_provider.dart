import 'package:flutter/material.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../../../core/service/network_caller/network_caller.dart';
import '../../data/models/slider_model.dart';

class HomeSlidersProvider extends ChangeNotifier {

  bool _getSlidersInProgress = false;
  List<SliderModel> _sliders = [];

  String? _errorMessage;
  bool get getSlidersInProgress => _getSlidersInProgress;
  List<SliderModel> get sliders => _sliders;
  String? get errorMessage => _errorMessage;

  Future<void> getSliders() async {
          bool isSuccess = false;
    _getSlidersInProgress = true;
    notifyListeners();

    final NetWorkResponse response = await getNetworkCaller().getRequest(
      Urls.getSlidersUrl,
    );

    if (response.isSuccess) {
      List<SliderModel> sliderModels = [];
      for (Map<String, dynamic> model in response.body['data']['results']) {
        sliderModels.add(SliderModel.fromJson(model));
      }
      _sliders = sliderModels;
      _errorMessage = null;

      _getSlidersInProgress = false;
      notifyListeners();
    } else {
      _errorMessage = response.errorMsg;
    }
    _getSlidersInProgress = false;
    notifyListeners();
  }
}
