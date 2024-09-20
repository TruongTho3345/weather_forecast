import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/gen/assets.gen.dart';
import 'package:weather_forecast/utils/symbols_utils.dart';
import 'package:weather_forecast/ui/common/ui_helpers.dart';
import 'package:weather_forecast/ui/views/forecast_report/forecast_report_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchWeather();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Container(
              // Add gradient background
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF47BFDF),
                    Color(0xFF4A91FF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          final bottomSheetService =
                              StackedLocator.instance<BottomSheetService>();

                          final response =
                              await bottomSheetService.showCustomSheet(
                            variant: 'locationSheet',
                            title: 'Select Location',
                            description:
                                'Choose a location for weather updates',
                          );

                          if (response != null && response.confirmed) {
                            viewModel
                                .updateLocationAndFetchWeather(response.data);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Symbols.location_on,
                              color: Colors.white,
                              weight: 700,
                              size: 30,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              viewModel.locationName != null &&
                                      viewModel.locationName!.length > 20
                                  ? "${viewModel.locationName!.substring(0, 20)}..."
                                  : viewModel.locationName ?? "LF Global Tech",
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 17),
                            const Icon(
                              Symbols.keyboard_arrow_down,
                              color: Colors.white,
                              weight: 700,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceLarge,
                      // Weather Icon
                      if (viewModel.weatherData != null)
                        Center(
                          child: Icon(
                            viewModel.weatherData!.current.weather.first.id
                                .getWeatherIcon(),
                            color: Colors.white,
                            fill: 1,
                            size: 160,
                          ),
                        ),
                      const SizedBox(
                        height: 66,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withOpacity(0.3),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.7)),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            if (viewModel.weatherData != null)
                              Text(
                                "${viewModel.weatherData!.current.temp.toInt()}°",
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            if (viewModel.weatherData != null)
                              Text(
                                viewModel.weatherData!.current.weather[0].main,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            const SizedBox(
                              height: 30,
                            ),
                            // Wind and Humidity
                            if (viewModel.weatherData != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(Assets.icWind),
                                      const SizedBox(height: 16),
                                      SvgPicture.asset(Assets.icHumidity),
                                    ],
                                  ),
                                  const SizedBox(width: 19),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Wind",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      SizedBox(height: 19),
                                      Text("Humidity",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(width: 19),
                                  const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("|",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                      SizedBox(height: 24),
                                      Text("|",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(width: 19),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${(viewModel.weatherData!.current.windSpeed * 3.6).toInt()} km/h",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      const SizedBox(height: 19),
                                      Text(
                                        "${viewModel.weatherData!.current.humidity}%",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Forecast Report Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForecastReportView(
                                latitude:
                                    viewModel.selectedLocation?.geometry.lat ??
                                        viewModel.defaultLat,
                                longitude:
                                    viewModel.selectedLocation?.geometry.lng ??
                                        viewModel.defaultLng,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 18, horizontal: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forecast Report",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF444E72),
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Symbols.chevron_right,
                                color: Color(0xFF444E72),
                                weight: 700,
                                size: 23,
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
