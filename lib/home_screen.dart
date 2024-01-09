import 'package:flutter/material.dart';
import 'package:flutter_responsive_framework_tutorial/courses_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CoursesPage();
  }
}
