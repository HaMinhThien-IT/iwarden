import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iWarden/providers/locations.dart';
import 'package:iWarden/providers/print_issue_providers.dart';
import 'package:iWarden/screens/AbortingScreen.dart';
import 'package:iWarden/screens/IssuePCNFirstSeen.dart';
import 'package:iWarden/screens/add-first-seen/AddFirstSeenScreen.dart';
import 'package:iWarden/screens/demo-ocr/DemoOCR.dart';
import 'package:iWarden/screens/first-seen/DetailFirstSeen.dart';
import 'package:iWarden/screens/HomeOverview.dart';
import 'package:iWarden/screens/location/LocationScreen.dart';
import 'package:iWarden/screens/login_screens.dart';
import 'package:iWarden/screens/print_issue.dart' as print;
import 'package:iWarden/theme/color.dart';
import 'package:iWarden/theme/theme.dart';
import 'package:provider/provider.dart';
import '../routes/routes.dart';
import 'dart:async';
import 'package:anyline_plugin/anyline_plugin.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: ColorTheme.backdrop2),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Locations(),
        ),
        ChangeNotifierProvider.value(
          value: PrintIssueProviders(),
        ),
      ],
      child: MaterialApp(
        title: 'iWarden',
        theme: themeMain(),
        debugShowCheckedModeBanner: false,
        home: const print.PrintIssue(),
        initialRoute: print.PrintIssue.routeName,
        routes: routes,
      ),
    );
  }
}
