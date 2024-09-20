import 'package:weather_forecast/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/ui/views/forecast_report/forecast_report_view.dart';
import 'package:weather_forecast/ui/bottom_sheets/location/location_sheet.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ForecastReportView),
    // @stacked-route
  ],
  bottomsheets: [
    StackedBottomsheet(classType: LocationSheet),
    // @stacked-bottom-sheet
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
)
class App {}
