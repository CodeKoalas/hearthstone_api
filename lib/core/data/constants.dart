import 'package:flutter/material.dart';

// coverage:ignore-file

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

// For any static variables we want to "scope" here.
class AppConstants {}
