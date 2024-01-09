import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_framework_tutorial/home_screen.dart';
import 'package:flutter_responsive_framework_tutorial/routers/platform/platform_enum.dart';
import 'package:flutter_responsive_framework_tutorial/routers/string_extensions.dart';

import '../profile_screen.dart';
import 'config/determine_platform.dart'
    if (dart.library.html) 'config/determine_platform_web.dart';
import 'route_names.dart';

Route<dynamic> commonNavigation(RouteSettings settings) {
  //Navigation for un authorized or common pages(Home,etc)
  final routingData = settings.name!.getRoutingData;
  switch (routingData.route) {
    case CoreRoute.homeRoute:
      return _getPageRoute(
        const HomeScreen(),
        settings,
      );
    case CoreRoute.profileRoute:
      return _getPageRoute(
        ProfileScreen(),
        settings,
      );
    default:
      return _getPageRoute(
        Container(),
        settings,
      );
  }
}

PageRoute _getPageRoute(
  Widget child,
  RouteSettings settings, {
  bool mainRoute = false,
}) {
  final SupportedPlatform platform = getPlatform();
  if (platform == SupportedPlatform.ios && !mainRoute) {
    return CupertinoPageRoute(builder: (BuildContext context) {
      return child;
    });
  } else if (platform == SupportedPlatform.android && !mainRoute) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return child;
    });
  } else {
    return _FadeRoute(child: child, routeName: settings.name!);
  }
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class CupertinoRoute extends PageRouteBuilder {
  final Widget enterPage;
  CupertinoRoute({required this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return enterPage;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linearToEaseOut,
                  reverseCurve: Curves.easeInToLinear,
                ),
              ),
              child: enterPage,
            );
          },
        );
}
