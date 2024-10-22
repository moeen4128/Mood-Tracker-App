import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mood_track/configs/routes/routes.dart';
import 'package:mood_track/configs/theme/colors.dart';
import 'package:mood_track/data/db/boxes.dart';
import 'package:mood_track/model/mood_emoji.dart';
import 'package:mood_track/view%20model/home/home_view_model.dart';
import 'package:mood_track/view%20model/login/login_viewmodel.dart';
import 'package:mood_track/view%20model/signup/signup_provider.dart';
import 'package:mood_track/view%20model/report%20provider/report_provider.dart.dart';
import 'package:mood_track/views/bottom_nav_home/nav_controller/nav_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(MoodEmojiAdapter());
  boxMood = await Hive.openBox<MoodEmoji>('moodEmoji');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor.withOpacity(0.4)));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavPageController()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => LoginViewProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ReportProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mood Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        // this is the initial route indicating from where our app will start
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
