import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:weather_two/models/current_weather_model.dart';
import 'package:weather_two/services/controllers/global_controller.dart';

class FetchApi {
  final GlobalContorller globalContorller = Get.put(
    GlobalContorller(),
    permanent: true,
  );

  Future<CurrentWeatherModel> fetchWeather() async {
    String latitude = globalContorller.getLatitude().toString();
    String longitude = globalContorller.getLongitude().toString();
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=a6d17f1d1fe4a17be3592c8e851d1dfc";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final currentweathermodel = CurrentWeatherModel.fromJson(json);
    return currentweathermodel;
  }
}
