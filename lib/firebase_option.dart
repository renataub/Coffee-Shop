import 'package:firebase_core/firebase_core.dart';

class DefaultafirebaseOptions{
  static FirebaseOptions get currentPlatform{
    return andriod;
  }

  static const FirebaseOptions andriod = FirebaseOptions(
    apiKey: "AIzaSyA27ZMCDojBv4_PCdmKQD8uAYo4Xw3JTJQ",
    appId: "1:457984482642:android:9160c4c7bd9e98d5cc6e8b",
    messagingSenderId: "457984482642",
    projectId:  "coffee-shop-99a01",
    storageBucket: "coffee-shop-99a01.appspot.com"
  );
}