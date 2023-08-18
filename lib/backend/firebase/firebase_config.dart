import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBpbPwhLsXyEo13YZf70tm-4f6cZJMcxbI",
            authDomain: "dailymatch-14dff.firebaseapp.com",
            projectId: "dailymatch-14dff",
            storageBucket: "dailymatch-14dff.appspot.com",
            messagingSenderId: "528418629392",
            appId: "1:528418629392:web:66302d968ebf4fad25a795",
            measurementId: "G-ZC291BTDYK"));
  } else {
    await Firebase.initializeApp();
  }
}
