import 'package:flutter/cupertino.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/ui/pages/home/home.dart';

/// Router generator in which all pages and their transitions are made.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Pages.home:
      return CupertinoPageRoute(builder: (_) => const HomePage());
  }
  return null;
}