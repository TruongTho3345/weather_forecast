import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecast/app/app.locator.dart';
import 'package:weather_forecast/app/app.router.dart';
import 'package:weather_forecast/ui/bottom_sheets/location/location_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final bottomSheetService = locator<BottomSheetService>();

  bottomSheetService.setCustomSheetBuilders({
    'locationSheet': (context, sheetRequest, completer) =>
        LocationSheet(completer: completer, request: sheetRequest),
  });
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TruongThoWeather',
        initialRoute: Routes.homeView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.overpass().fontFamily));
  }
}
