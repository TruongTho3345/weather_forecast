import 'package:stacked/stacked.dart';
import 'package:weather_forecast/services/location_service.dart';

class LocationSheetModel extends BaseViewModel {
  final LocationService _locationService = LocationService();
  List<String> _suggestions = [];

  List<String> get suggestions => _suggestions;

  Future<void> searchLocation(String query) async {
    setBusy(true);
    final results = await _locationService.searchLocation(query);
    _suggestions = results.map((loc) => loc.formatted).toList();
    setBusy(false);
    notifyListeners();
  }
}
