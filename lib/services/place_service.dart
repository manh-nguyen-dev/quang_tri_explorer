import '../models/place_model.dart';
import 'http_service.dart';

class PlaceService {
  final HttpService _httpService;

  PlaceService(this._httpService);

  /// Retrieves a list of all places.
  Future<List<PlaceModel>> getAllPlaces() async {
    try {
      final response = await _httpService.get('places');
      final List<dynamic> data = response as List<dynamic>;

      return data.map((json) => PlaceModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {

      rethrow;
    }
  }
}