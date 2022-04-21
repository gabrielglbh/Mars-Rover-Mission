import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static final Utils _instance = Utils._();

  /// Singleton instance of [Utils]
  static Utils get instance => _instance;

  /// Creates a snack bar with the given [message]
  void createSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text(message), duration: const Duration(seconds: 2))
      );
  }

  Future<void> launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      createSnackBar(context, "Could not launch url.");
    }
  }
}