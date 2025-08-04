import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/extensions/string_extensions.dart';
import '../../data/constants/app_router.dart';
import '../../data/constants/global_obj.dart';
import '../../global/enums/global_enum.dart';
import '../log/app_log.dart';

String? globalFcmToken;

class NotificationsServices {
  // Private constructor
  NotificationsServices._internal();

  //NotificationService a singleton object
  static final NotificationsServices instance =
      NotificationsServices._internal();

  static const channelId = 'ics2024';
  static const channelName = 'ics2024';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String?> getToken() async {
    try {
      globalFcmToken = await FirebaseMessaging.instance.getToken();
      AppLog.logValue("FCM Token --> $globalFcmToken");
      return globalFcmToken;
    } catch (e) {
      AppLog.printValue(e);
      FirebaseMessaging.instance.onTokenRefresh.listen((event) {
        globalFcmToken = event;
      });

      if (!globalFcmToken.isEmptyOrNull) {
        return globalFcmToken;
      } else {
        return await handleFailOfGetToken();
      }
    }
  }

  Future<String?> handleFailOfGetToken() async {
    try {
      await requestPermission();
    } catch (e) {
      await FirebaseMessaging.instance.deleteToken();
      globalFcmToken = null;
      globalFcmToken = await FirebaseMessaging.instance.getToken();
    }
    AppLog.logValue("New FCM Token --> $globalFcmToken");
    return globalFcmToken;
  }

  static void handleOnClickNotification(
    RemoteMessage? message,
    AppState appState,
  ) async {
    //handle on click notifiction whether if it's from firebase or from locale notification plugin
    try {
      if (message != null) {
        //
        switch (appState) {
          case AppState.foregorund:
            navigateToNotifications();
            break;
          case AppState.background:
            navigateToNotifications();

            break;
          case AppState.terminated:
            navigateToNotifications();
            break;
        }
      } else {
        //
      }
    } catch (error) {
      AppLog.logValue(
        'An error occured during handling notifications and catched using catch method $error',
      );
    }
  }

  static navigateToNotifications() {
    String currentRoute =
        GoRouter.of(Get.context!).state?.matchedLocation ?? '';
    if (currentRoute.contains('notifications')) {
      Navigator.pop(Get.context!);
    }
    Get.context?.pushNamed(AppRouter.notifications);
  }

  Future<void> requestPermission() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // Request Notifications permission
    NotificationSettings notificationSettings = await firebaseMessaging
        .requestPermission(
          sound: true,
          badge: true,
          alert: true,
          announcement: false,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
        );

    AppLog.logValue(
      'Notifications permission == ${notificationSettings.authorizationStatus}',
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      await firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
        badge: true,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  bool _isListenerAdded = false;

  Future<void> init() async {
    if (_isListenerAdded) return; // Prevent duplicate listeners
    _isListenerAdded = true;

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    var androidInitialize = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iOSInitialize = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        handleOnClickNotification(
          RemoteMessage.fromMap(json.decode(details.payload!)),
          AppState.foregorund,
        );
      },
      // onDidReceiveBackgroundNotificationResponse:
      //     (NotificationResponse details) {
      //   handleOnClickNotification(
      //     RemoteMessage.fromMap(json.decode(details.payload!)),
      //   );
      // },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(notificationChannel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display alerts (banners)
          badge: true, // Adds a badge on the app icon
          sound: true, // Enables sound for notifications
        );
    // Handle notifications on foreground
    //--> This is the only case where we use locale notifiction plugin to show the notifiction
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // notificationCountNotifier.value++;
      // notificationBloc.add(NotificationCountEvent());
      // AppLog.logValue(
      //     "onMessage came while the app on foreground state type: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      showNotification(message, flutterLocalNotificationsPlugin, false);
    });

    // Handle notifications on background
    // --> In this case the app was in the background, and the notification was clicked and moved app to the foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // notificationBloc.add(NotificationCountEvent());
      AppLog.logValue(
        "onOpenApp from Background State: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}",
      );
      // Handle on Click notification
      handleOnClickNotification(message, AppState.background);
    });

    // Handle on terminated state
    // --> In this case the app was opend from the terminated by clicking the notifications

    firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        AppLog.logValue(
          "onOpenApp From Terminated state: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}",
        );
        // Handle on Click notification
        handleOnClickNotification(message, AppState.terminated);
      }
    });

    //
    getToken();
  }

  AndroidNotificationChannel notificationChannel =
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title/ description
        playSound: true,
        importance: Importance.high,
      );

  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
    bool data,
  ) async {
    if (!Platform.isIOS) {
      String? title;
      String? body;
      String? image;
      if (data) {
        title = message.data['title'];
        body = message.data['body'];
      } else {
        title = message.notification!.title;
        body = message.notification!.body;

        if (Platform.isAndroid) {
        } else if (Platform.isIOS) {}
      }
      if (image != null && image.isNotEmpty) {
      } else {
        await showBigTextNotification(title, body!, message, fln);
      }
    }
  }

  // static Future<void> showTextNotification(
  //     String title,
  //     String body,
  //     RemoteMessage? message,
  //     FlutterLocalNotificationsPlugin fln,
  //     ) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //     channelId,
  //     channelName,
  //     playSound: true,
  //     importance: Importance.max,
  //     priority: Priority.max,
  //     // sound: RawResourceAndroidNotificationSound('notification'),
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await fln.show(
  //     0,
  //     title,
  //     body,
  //     platformChannelSpecifics,
  //     payload: message != null ? jsonEncode(message.toMap()) : null,
  //   );
  // }

  static Future<void> showBigTextNotification(
    String? title,
    String body,
    RemoteMessage? message,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          channelId,
          channelName,
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true,
          // sound: const RawResourceAndroidNotificationSound('notification'),
        );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: message != null ? jsonEncode(message.toMap()) : null,
    );
  }
}

Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppLog.printValue(
    "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}",
  );
}
