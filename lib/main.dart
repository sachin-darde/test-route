import 'package:flutter/material.dart';
import 'package:flutter_responsive_framework_tutorial/courses_page.dart';
import 'package:flutter_responsive_framework_tutorial/routers/config/injection.dart';
import 'package:flutter_responsive_framework_tutorial/routers/navigation_service.dart';
import 'package:flutter_responsive_framework_tutorial/routers/route_names.dart';
import 'package:flutter_responsive_framework_tutorial/routers/routing_config.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future main() async {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
    setUrlStrategy(PathUrlStrategy());

  setupLocator(navKey);
  runApp(MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            breakpoints: const [
              ResponsiveBreakpoint.resize(350, name: MOBILE),
              ResponsiveBreakpoint.autoScale(600, name: TABLET),
              ResponsiveBreakpoint.resize(800, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
            ],
          ),
      title: 'Flutter Responsive Framework',
      home: const CoursesPage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator<NavigationService>().navigatorKey,
      onGenerateRoute: commonNavigation,
      initialRoute: CoreRoute.homeRoute));
}
