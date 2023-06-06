import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

//ui
import './bottombar/bottombar.dart';

//state
import './state/global_variables.dart';

//helper
import './helper/database_helper.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper().initializeDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: const MainApp(),
    ),
  );
}
