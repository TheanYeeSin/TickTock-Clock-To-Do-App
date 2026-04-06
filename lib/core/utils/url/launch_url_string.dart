import "package:url_launcher/url_launcher.dart";

Future<bool> launchUrlString(final String url) async {
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return true;
    }
  } catch (e) {
    // Handle any exceptions that may occur during URL parsing or launching
  }
  return false;
}
