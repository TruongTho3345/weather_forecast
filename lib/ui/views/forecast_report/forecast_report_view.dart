import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_forecast/ui/common/ui_helpers.dart';
import 'forecast_report_viewmodel.dart';
import 'package:weather_forecast/utils/symbols_utils.dart';

class ForecastReportView extends StackedView<ForecastReportViewModel> {
  final double latitude;
  final double longitude;

  final ScrollController _scrollController = ScrollController();

  ForecastReportView({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  void onViewModelReady(ForecastReportViewModel viewModel) {
    viewModel.fetchForecastReport(latitude, longitude).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentHour(viewModel);
      });
    });
    super.onViewModelReady(viewModel);
  }

  void _scrollToCurrentHour(ForecastReportViewModel viewModel) {
    DateTime now = DateTime.now();
    int currentIndex = viewModel.hourlyData?.time.indexWhere((time) {
          DateTime forecastTime = DateTime.parse(time);
          return forecastTime.hour == now.hour;
        }) ??
        0;

    double screenWidth = WidgetsBinding
            .instance.platformDispatcher.views.first.display.size.width /
        WidgetsBinding
            .instance.platformDispatcher.views.first.display.devicePixelRatio;
    double itemWidth = 100;
    double scrollPosition = currentIndex * itemWidth;
    double centeredPosition =
        scrollPosition - (screenWidth / 2) + (itemWidth / 1.5);

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        centeredPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget builder(
      BuildContext context, ForecastReportViewModel viewModel, Widget? child) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            const Text(
              "Back",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 56),
                    const SizedBox(height: 58),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          viewModel.formatDateFromDt(
                              viewModel.weatherData?.current.dt ?? 0),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.172,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.hourlyData?.time.length ?? 0,
                        itemBuilder: (context, index) {
                          DateTime forecastTime = DateTime.parse(
                              viewModel.hourlyData?.time[index] ?? '');

                          int forecastHour = forecastTime.hour;
                          int currentHour = DateTime.now().hour;

                          bool isCurrentHour = forecastHour == currentHour;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: isCurrentHour
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isCurrentHour
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${viewModel.hourlyData?.temperature2m[index].toInt() ?? 0}°C',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 23),
                                  Icon(
                                    viewModel.hourlyData?.weatherCode[index]
                                        .getWeatherIcon(),
                                    color: Colors.white,
                                    fill: 1,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 23),
                                  Text(
                                    viewModel.formatTimeFromString(
                                        viewModel.hourlyData?.time[index] ??
                                            ''),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Next Forecast",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 22,
                    ),
                    RawScrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      thumbColor: Colors.white,
                      radius: const Radius.circular(5),
                      trackRadius: const Radius.circular(5),
                      thickness: 6,
                      padding: const EdgeInsets.all(0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 46.0),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.35,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0.0),
                            itemCount:
                                (viewModel.weatherData?.daily.length ?? 1) - 1,
                            itemBuilder: (context, index) {
                              final daily =
                                  viewModel.weatherData?.daily[index + 1];
                              return SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      viewModel
                                          .formatDateFromDt(daily?.dt ?? 0),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      daily?.weather.first.id.getWeatherIcon(),
                                      color: Colors.white,
                                      fill: 1,
                                      size: 30,
                                    ),
                                    Text(
                                      '${daily?.temp.day.toInt() ?? 0}°',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Symbols.sunny,
                                  color: Colors.white,
                                  fill: 1,
                                  size: 23,
                                ),
                                horizontalSpaceSmall,
                                Text(
                                  "TruongThoWeather",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                          verticalSpaceMedium,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  ForecastReportViewModel viewModelBuilder(BuildContext context) =>
      ForecastReportViewModel();
}
