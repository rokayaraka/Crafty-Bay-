import 'dart:async';

import 'package:flutter/foundation.dart';

class OtpTimerProvider extends ChangeNotifier {


static const int _secondsForResendOTP = 30;
  Timer? _timer;
  int _secondsLeft=0;


  int get secondsLeft=>_secondsLeft;
  void startTimer(){
    _timer?.cancel(); 
    _secondsLeft=_secondsForResendOTP;

    _timer=Timer.periodic(Duration(seconds: 1), (timer){
      if(_secondsLeft==0){
        _timer?.cancel();
        _secondsLeft=0;
      }
      else{
        _secondsLeft--;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

}