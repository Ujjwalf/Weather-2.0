class CurrentWeatherModel {
  final double temp;
  // final String mausam;
  final double minTemperature;
  final double maxTemperature;
  final int windSpeed;
  final int sunriseTime;
  final int sunsetTime;

  CurrentWeatherModel({
    required this.temp,
    // required this.mausam,
    required this.minTemperature,
    required this.maxTemperature,
    required this.windSpeed,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> e) {
    return CurrentWeatherModel(
      temp: e['main']['temp'],
      // mausam: e['0']['main'],
      minTemperature: e['main']['temp_min'],
      maxTemperature: e['main']['temp_max'],
      windSpeed: e['wind']['speed'],
      sunriseTime: e['sys']['sunrise'],
      sunsetTime: e['sys']['sunset'],
    );
  }
}
