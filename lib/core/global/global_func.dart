import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/component/custom_toast/p_toast.dart';
import 'package:cleanarchitecture/core/component/global_widgets.dart';
import 'package:cleanarchitecture/core/component/media_upload/upload_bloc/upload_bloc.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/services/local_storage/shared_preference/shared_preference_service.dart';

final GlobalKey<NavigatorState> dialogNavigatorKey =
    GlobalKey<NavigatorState>();

loadDialog() {
  showDialog(
    useRootNavigator: false,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    context: Get.context!,
    builder: (_) {
      return PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvokedWithResult: (didPop, result) {
          // if (!didPop) {
          //   Get.context!.pop(); // Return value
          // }
        },
        child: Center(child: customLoader()),
      );
    },
  );
}

void hideLoadingDialog({bool isRefresh = false}) {
  if (Navigator.of(Get.context!).canPop()) {
    Navigator.of(Get.context!).pop(isRefresh);
  }
}

final List<Map<String, dynamic>> statusItems = [
  {
    'color': AppColors.nationalDayColor,
    'transparentColor': AppColors.nationalDayColor.withValues(alpha: 0.15),
    'label': ['تم الدعم', "complete", "resolved - تمت المعالجة"],
  },
  {
    'color': AppColors.secondaryColor,
    'transparentColor': AppColors.secondaryColor.withValues(alpha: 0.15),
    'label': ['جديدة', "open", "open - مفتوح"],
  },
  {
    'color': AppColors.primaryColor,
    'transparentColor': AppColors.shade2,
    'label': ['قيد التنفيذ', "on work order", "onhold - معلقة بشكل مؤقت"],
  },
  {
    'color': AppColors.primaryColor,
    'transparentColor': AppColors.shade2,
    'label': ['تحت المعالجة', "awaiting work order"],
  },
  {
    'color': AppColors.successCode,
    'transparentColor': AppColors.shade2,
    'label': ['مغلقة', "closed", "closed-مغلق", "obsolete - منتهي الصلاحية"],
  },
  {
    'color': AppColors.error,
    'transparentColor': AppColors.errorCode.withValues(alpha: 0.15),
    'label': ['ملغي', "canceled"],
  },
  {
    'color': AppColors.error,
    'transparentColor': AppColors.errorCode.withValues(alpha: 0.15),
    'label': ['مرفوضة', "rejected"],
  },
];

// getAllServices() {
//   if (myServiceBloc.isClosed) {
//     myServiceBloc = MyServiceBloc(myServiceUseCase:getIt());
//     myServiceBloc.add(const GetMyServicesEvents());
//   } else {
//     myServiceBloc.add(const GetMyServicesEvents());
//   }
// }

extension MapIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    int index = 0;
    return map((element) => f(index++, element));
  }
}

String getArabicMonthName(int month) {
  const arabicMonths = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  return arabicMonths[month - 1];
}

// Fade transition
dynamic createFadeRoute({required Widget widget}) {
  return CustomTransitionPage(
    child: widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

// Scale Transition
// dynamic createScaleRoute({required Widget widget}) {
//    CustomTransitionPage(
//     child:widget,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return ScaleTransition(
//         scale: animation,
//         child: child,
//       );
//     },
//   );
// }

// Combine multiple animations
dynamic createRoute({required Widget widget}) {
  return CustomTransitionPage(
    child: widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeAnimation = Tween(begin: 0.0, end: 3.0).animate(animation);
      var slideAnimation = Tween<Offset>(
        begin: const Offset(3.0, 0.0),
        end: Offset.zero,
      ).animate(animation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(position: slideAnimation, child: child),
      );
    },
  );
}

dynamic createNavigation({required Widget widget}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeAnimation = Tween(begin: 0.0, end: 3.0).animate(animation);
      var slideAnimation = Tween<Offset>(
        begin: const Offset(3.0, 0.0),
        end: Offset.zero,
      ).animate(animation);

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(position: slideAnimation, child: child),
      );
    },
  );
}

String convertArabicDate(String arabicDate) {
  // Map of Arabic month names to numeric values
  Map<String, String> arabicMonths = {
    "يناير": "01",
    "فبراير": "02",
    "مارس": "03",
    "أبريل": "04",
    "مايو": "05",
    "يونيو": "06",
    "يوليو": "07",
    "أغسطس": "08",
    "سبتمبر": "09",
    "أكتوبر": "10",
    "نوفمبر": "11",
    "ديسمبر": "12",
  };

  // Split the Arabic date
  List<String> parts = arabicDate.split(" ");
  if (parts.length != 3) return "Invalid Date Format"; // Basic validation

  String day = parts[0]; // "01"
  String month =
      arabicMonths[parts[1]] ?? "00"; // Convert Arabic month to number
  String year = parts[2]; // "2025"

  return "$day-$month-$year";
}

String getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  final i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}

Future<bool> validateImage({
  required File file,
  bool isImage = true,
  required bool isReport,
}) async {
  int fixedSize =
      isReport
          ? reportSize
          : (isImage ? imageMaxSizeInBytes : fileMaxSizeInBytes);
  int fileSize = await file.length();
  String size = getFileSizeString(bytes: fileSize);
  // print('size>>' + size.toString());
  // print('fileSize>>' + fileSize.toString());
  if (fileSize > fixedSize) {
    if (isReport) {
      SafeToast.show(
        duration: const Duration(seconds: 3),
        message: 'حجم المرفق يتجاوز الحد الأقصى وهو 14 ميجا بايت.',
        type: MessageType.error,
      );
    } else {
      SafeToast.show(
        duration: const Duration(seconds: 3),
        message:
            isImage
                ? 'حجم المرفق يتجاوز الحد الأقصى وهو 5 ميجا بايت.'
                : 'حجم المرفق يتجاوز الحد الأقصى وهو 2 ميجا بايت.',
        type: MessageType.error,
      );
    }
  }
  return fixedSize >= fileSize;
}

class NoLeadingSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the text starts with a space and remove it
    if (newValue.text.startsWith(' ')) {
      return oldValue; // Reject the new value if it starts with space
    }
    return newValue;
  }
}

bool isDarkContext(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

bool get isDark {
  if (Get.context == null) {
    return SharedPreferenceService().getBool(SharPrefConstants.isDarkThemeKey);
  }
  return Theme.of(Get.context!).brightness == Brightness.dark;
}

void setSystemNavigationBarColor({bool? isDarkMode}) {
  isDarkMode =
      isDarkMode ??
      SharedPreferenceService().getBool(SharPrefConstants.isDarkThemeKey);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          isDarkMode
              ? AppColors.darkBottomBarColor
              : AppColors.backgroundColor, // Change color
      systemNavigationBarIconBrightness:
          isDarkMode ? Brightness.light : Brightness.dark, // Change icon color
    ),
  );
}

bool isBase64Image(String data) {
  final base64Regex = RegExp(
    r'^data:image\/(png|jpeg|jpg|gif|webp);base64,([A-Za-z0-9+/=]+)$',
  );
  return base64Regex.hasMatch(data);
}

String darkMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [{"color": "#414c5d"}]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#ffffff"}]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [{"color": "#1f1f1f"}]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [{"color": "#5e6673"}]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [{"color": "#2a2a2a"}]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [{"color": "#5e6673"}]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#5e6673"}]
  },
  {
    "featureType": "transit",
    "stylers": [{"visibility": "off"}]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [{"color": "#0b1e35"}]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [{"color": "#4e6d70"}]
  }
]
''';

String convertMapToHtml(Map<String, dynamic> data) {
  StringBuffer buffer = StringBuffer();
  buffer.write('<div style="direction: rtl;">');

  data.forEach((key, value) {
    buffer.write('$key: $value<br />');
  });

  buffer.write('</div>');
  return buffer.toString();
}

String formatJson(dynamic jsonObject) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(jsonObject);
}

String beautifyJsonString(String rawJson) {
  print('rawJson>>$rawJson');
  try {
    final decoded = json.decode(rawJson);
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(decoded);
  } catch (e) {
    return 'Invalid JSON: $e';
  }
}

String beautifyLooseJson(String input) {
  // Step 1: Add double quotes around keys
  String fixed = input.replaceAllMapped(
    RegExp(r'(?<=\{|,)\s*(\w+)\s*:'),
    (match) => '"${match[1]}":',
  );

  // Step 2: Add double quotes around unquoted string values
  fixed = fixed.replaceAllMapped(RegExp(r':\s*([^"\[{][^,}\]]*)'), (match) {
    String value = match[1]!.trim();
    // Leave null, true, false, numbers as they are
    if (value == 'null' ||
        value == 'true' ||
        value == 'false' ||
        num.tryParse(value) != null) {
      return ': $value';
    }
    return ': "${value.replaceAll('"', r'\"')}"';
  });

  // Step 3: Decode and pretty print
  try {
    var decoded = json.decode(fixed);
    return const JsonEncoder.withIndent('  ').convert(decoded);
  } catch (e) {
    return '❌ Failed to beautify JSON: $e\n\nRaw:\n$fixed';
  }
}

String parseFormData(FormData formData) {
  final Map<String, dynamic> dataMap = {};

  for (var field in formData.fields) {
    dataMap[field.key] = field.value;
  }

  for (var file in formData.files) {
    dataMap[file.key] = file.value.filename; // or other file metadata
  }

  return formatJson(dataMap);
}

String formatDate(String inputDate) {
  if (!inputDate.contains('/')) {
    return inputDate;
  }
  final parts = inputDate.split('/');
  if (parts.length != 3) return inputDate;

  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);

  const gregorianMonths = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر",
  ];

  // If Gregorian year
  if (year >= 1600) {
    return "$day ${gregorianMonths[month - 1]} $year";
  }

  // Hijri: fallback to static conversion or custom logic
  const hijriMonths = [
    "محرم",
    "صفر",
    "ربيع الأول",
    "ربيع الآخر",
    "جمادى الأولى",
    "جمادى الآخرة",
    "رجب",
    "شعبان",
    "رمضان",
    "شوال",
    "ذو القعدة",
    "ذو الحجة",
  ];

  return "$day ${hijriMonths[month - 1]} $year";
}
