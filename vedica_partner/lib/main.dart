import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:vedica_partner/app/modules/home/views/home_view.dart';
import 'package:vedica_partner/app/modules/onboarding/views/onboarding_view.dart';
import 'package:vedica_partner/app/modules/otp/views/otp_view.dart';
import 'package:vedica_partner/app/modules/splash/views/splash_view.dart';
import 'package:vedica_partner/app/modules/splash/views/splash_view_two.dart';
import 'package:vedica_partner/app/providers/connectivity_providers.dart';
import 'package:vedica_partner/app/providers/data_providers.dart';
import 'package:vedica_partner/app/providers/transactions_provider.dart';
import 'package:vedica_partner/app/routes/app_pages.dart';
import 'package:vedica_partner/app/services/local/local_resource_manager.dart';
import 'package:vedica_partner/utils/constents.dart';
import 'package:vedica_partner/utils/my_colors.dart';

const String apiUrl = String.fromEnvironment('CLOUDINARY_API_URL',
    defaultValue: 'https://api.cloudinary.com/v1_1');
const String apiKey = String.fromEnvironment('CLOUDINARY_API_KEY',
    defaultValue: '328373291423139');
const String apiSecret = String.fromEnvironment('CLOUDINARY_API_SECRET',
    defaultValue: '8g2WMQqh2XaBzaHiH9DSJJnhDgw');
const String cloudName =
    String.fromEnvironment('CLOUDINARY_CLOUD_NAME', defaultValue: 'dim10lg5x');
const String folder =
    String.fromEnvironment('CLOUDINARY_FOLDER', defaultValue: 'vedica');
const String uploadPreset =
    String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET', defaultValue: '');

final cloudinary = Cloudinary.full(
    apiUrl: apiUrl, apiKey: apiKey, apiSecret: apiSecret, cloudName: cloudName);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    ChangeNotifierProvider(create: (_) => DataProvider()),
    ChangeNotifierProvider(create: (_) => TrasactionsProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final isOnline = Provider.of<ConnectivityProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = Provider.of<ConnectivityProvider>(context);
    print("onlinee ${isOnline.isOnline}");
    print("token ${LocalResourceManager().getToken()}");
    print("isonboared ${LocalResourceManager().getIsOnboarded()}");
    return GetMaterialApp(
      theme: ThemeData(
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: MyColor.yellowColor)),
      debugShowCheckedModeBanner: false,
      title: Constents.appName,
      getPages: AppPages.routes,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LocalResourceManager().getIsOnboarded() == true
                ? HomeView()
                : OnboardingView();
          } else {
            return SplashViewTwo();
          }
        },
      ),
    );
  }
}
