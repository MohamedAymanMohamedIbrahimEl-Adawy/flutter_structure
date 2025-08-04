import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../log/app_log.dart';

class UrlLauncherManager {
  static Future<void> redirectUrl(String url, {LaunchMode? mode}) async {
    if(url.isEmpty)return;
    // if (await canLaunchUrlString(url)) {
    await launchUrlString(
      url,
      mode: mode ?? LaunchMode.platformDefault,
    );
    // } else {
    //   log('Could not launch $url');
    // }
  }

  static Future<void> redirectToMap(double latitude , double longitude) async {
    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
    if (!await launchUrl(googleMapsUrl,
        mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch map.");
    }
  }

  static Future<void> redirectToInstagramById(String? id) async {
    final url = 'https://www.instagram.com/$id';

    await redirectUrl(url);
  }

  static Future<void> redirectToTwitterById(String? id) async {
    final url = 'https://twitter.com/$id';

    await redirectUrl(url);
  }

  static Future<void> redirectToFacebookById(String? id) async {
    final url = 'https://www.facebook.com/$id';

    await redirectUrl(url);
  }

  static Future<void> redirectToYoutubeById(String? id) async {
    final url = 'https://www.youtube.com/channel/$id';

    await redirectUrl(url);
  }

  static Future<void> redirectToImdbById(String? id) async {
    final url = 'https://www.imdb.com/name/$id';
    await redirectUrl(url);
  }

  static Future<void> redirectToTiktokById(String? id) async {
    final url = 'https://www.tiktok.com/@$id';

    await redirectUrl(url);
  }

  static Future<void> sendEmail({
    required String email,
    required String subject,
    required String message,
  }) async {
    final String url = "mailto:$email?subject=$subject&body=$message";

    await redirectUrl(url);
  }

  static void openWhatsapp({
    required String phoneNumber,
    required String dialCode,
    required String message,
  }) async {
    final String fullPhoneNumber = '$dialCode$phoneNumber';
    AppLog.logValue(phoneNumber);

    final String url4 = "https://wa.me/$fullPhoneNumber?text=$message";
    final String url5 = "whatsapp://send?phone=$fullPhoneNumber&text=$message";

    try {
      await redirectUrl(
        url4,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      try {
        redirectUrl(
          url5,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        try {
          String encodedUrl4 = Uri.encodeFull(url4);
          redirectUrl(
            encodedUrl4,
            mode: LaunchMode.externalApplication,
          );
        } catch (e) {
          //
        }
      }
    }
  }
}
