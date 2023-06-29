import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safarnama/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Safarnama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: SplashPage.routeNamed,
      routes: {
        // LoginScreen.routeNamed: (BuildContext context) => LoginScreen(),
        // SplashPage.routeNamed: (BuildContext context) => SplashPage(),
        // HomeScreen.routeNamed: (BuildContext context) => HomeScreen(),
        // PackageOverviewScreen.routeNamed: (BuildContext context) =>
        //     PackageOverviewScreen(),
        // // CheckoutScreen.routeNamed: (BuildContext context) => CheckoutScreen(),
        // BookingScreen.routeNamed: (BuildContext context) => BookingScreen(),
        // ProfileScreen.routeNamed: (BuildContext context) => ProfileScreen(),
        // ReferScreen.routeNamed: (BuildContext context) => ReferScreen(),
        // FavouriteScreen.routeNamed: (BuildContext context) => FavouriteScreen(),
        // PackagesScreen.routeNamed: (BuildContext context) => PackagesScreen(),
      },
    );
  }
}
