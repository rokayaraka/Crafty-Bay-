import 'app/crafty_bay_app.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//Business layer Q&N
//Scope of work-Crafty Bay App
//Design - UI/UX - Q&A
//Project Initiate ->Define Project version

//-----Coding part------


//ETC- Easy to Change
//SOC ->Seperation of concern



//set up Firebase
//Craslytics
//analytics
//Project Structure -> MVVM, Clean Architecture, onion,MVP

//Layer first architecture/Structure
//Feature First 

//themeing
//navigation- Named Navigation


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

 FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

  

  runApp(const CraftyBayApp());
}

