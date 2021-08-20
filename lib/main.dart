import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/models/park_image.dart';
import 'package:provider/provider.dart';
// Models
import './app/color_sets.dart';
// Views
import './views/Home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<CurrentPark>(create: (context) => CurrentPark()),
        ListenableProvider<ParkImage>(create: (context) => ParkImage()),
      ],
      child: MyApp(),
    )
    // ChangeNotifierProvider(
    //   create: (context) => CurrentPark(),
    //   child: MyApp(),
    // )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          // primarySwatch: BrandColors.brandPrimary,
          primaryColor: BrandColors.brandPrimary,
          accentColor: BrandColors.brandAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: HomePage(),
      );
  }
}
