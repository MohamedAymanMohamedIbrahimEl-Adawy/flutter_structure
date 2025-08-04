// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';

// class AnalyticsHelper {
//   static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   // static final FirebaseAnalyticsObserver _observer = FirebaseAnalyticsObserver(analytics: _analytics);

//   static void setAnalyticsData({
//     required String screenName,
//     required String eventName,
//     Map<String, Object>? additionalData,
//   }) async {
//     _analytics.logScreenView(
//       screenName: screenName,
//     );

//     if (additionalData != null) {
//       _analytics.logEvent(
//         name: eventName,
//         parameters: additionalData,
//       );
//     }
//   }

//   static void setAnalyticsDataEventOnly({
//     required String eventName,
//     Map<String, Object>? additionalData,
//   }) async {
//     if (additionalData != null) {
//       _analytics.logEvent(
//         name: eventName,
//         parameters: additionalData,
//       );
//     }
//   }

//   static void setAnalyticsDataAddToCart({
//     Map<String, Object>? additionalData,
//   }) async {
//     _analytics.logAddToCart(
//       parameters: additionalData,
//     );
//   }

//   static void initAnalytics() async {
//     if (kReleaseMode) {
//       try {
//         // Enable Firebase analytics
//         await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

//         // Enable Firebase Crashlytics
//         const fatalError = true;
//         // Non-async exceptions
//         FlutterError.onError = (errorDetails) {
//           if (fatalError) {
//             // If you want to record a "fatal" exception
//             FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
//             // ignore: dead_code
//           } else {
//             // If you want to record a "non-fatal" exception
//             FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
//           }
//         };
//         // Async exceptions
//         PlatformDispatcher.instance.onError = (error, stack) {
//           if (fatalError) {
//             // If you want to record a "fatal" exception
//             FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//             // ignore: dead_code
//           } else {
//             // If you want to record a "non-fatal" exception
//             FirebaseCrashlytics.instance.recordError(error, stack);
//           }
//           return true;
//         };
//       } catch (e) {
//         //
//       }
//     }
//   }
// }
