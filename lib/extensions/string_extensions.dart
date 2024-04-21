import 'package:url_launcher/url_launcher_string.dart';

extension StringExtensions on String {
  Future<void> launch() async {
    if (await canLaunchUrlString(this)) await launchUrlString(this, mode: LaunchMode.externalApplication);
  }
}
