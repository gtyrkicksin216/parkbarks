import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/models/park_image.dart';
import 'package:parks_bark/models/rated_parks.dart';
import 'package:parks_bark/services/rated_parks_service.dart';
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
        ListenableProvider<RatedParks>(create: (context) => RatedParks()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void fetchInitialParkState() async {
      final parks = await RatedParksService().getAllRatedParks();
      context.read<RatedParks>().setParks(parks);
    }

    fetchInitialParkState();

    return MaterialApp(
        title: AppStrings.applicationName,
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
