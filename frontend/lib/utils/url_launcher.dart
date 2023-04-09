import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<bool> _open(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);

      return true;
    } else {
      return false;
    }
  }

  static void open(String url) {
    if (url.startsWith('mailto')) {
      openEmail(url.replaceFirst('mailto:', ''), '');
    } else if (url.startsWith('tel')) {
      openPhone(url.replaceFirst('tel:', ''));
    } else {
      openUrl(url);
    }
  }

  static void openUrl(String url) => UrlLauncher._open(url);

  static void openEmail(String to, String params) =>
      UrlLauncher._open('mailto:$to$params');

  static void openPhone(String to) => UrlLauncher._open('tel:$to');
}
