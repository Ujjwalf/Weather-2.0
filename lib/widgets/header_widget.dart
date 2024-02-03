import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:weather_two/services/fetch_api.dart';
import 'package:weather_two/models/current_weather_model.dart';
import '../services/controllers/global_controller.dart';
import 'package:unixtime/unixtime.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final GlobalContorller globalContorller = Get.put(
    GlobalContorller(),
    permanent: true,
  );

  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  int temp = 0;
  double minTemperature = 0;
  double maxTemperature = 0;
  double windSpeed = 0;
  int sunriseTime = 0;
  int sunsetTime = 0;

  @override
  void initState() {
    // TODO: implement initState
    getLocation(globalContorller.getLatitude().value,
        globalContorller.getLongitude().value);
    super.initState();

    fetchUser();
  }

  getLocation(lat, longi) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, longi);
    // print(placemark);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  void fetchUser() async {
    final CurrentWeatherModel response = await FetchApi().fetchWeather();
    setState(() {
      temp = response.temp.toInt();
      minTemperature = response.minTemperature;
      maxTemperature = response.maxTemperature;
      windSpeed = response.windSpeed.toDouble();
      sunriseTime = response.sunriseTime;
      sunsetTime = response.sunsetTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    //ui variables
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 10.0),
          child: Container(
            height: height * 0.7,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff95d5ea), Color(0xffffffff)],
                  stops: [0.25, 0.75],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     Color.fromARGB(255, 64, 45, 0),
                //     Color.fromARGB(255, 0, 32, 128),
                //   ],
                //   stops: [0.1, 0.9],
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Center(
                  child: Text(
                    city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.08 * height,
                ),
                Center(
                  child: Text(
                    (temp - 273).toString() + "°C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Center(
                //   child: Text(
                //     "cond",
                //     style: const TextStyle(
                //       color: Colors.white,
                //       fontSize: 26,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  //replace for some icons
                  child: LineIcon.hiking(
                    size: 100,
                  ),
                  height: 0.25 * height,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Column(
                          children: [
                            //place low icon here
                            const LineIcon.highTemperature(
                              size: 40,
                            ),
                            Text(
                              (minTemperature - 273).toInt().toString() + "°C",
                              style: const TextStyle(
                                color: Color(0xff95d5ea),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Column(
                          children: [
                            //place high icon here
                            const LineIcon.lowTemperature(
                              size: 40,
                            ),
                            Text(
                              (maxTemperature - 273).toInt().toString() + "°C",
                              style: const TextStyle(
                                color: Color(0xff95d5ea),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          //place windspeed icon here
                          const LineIcon.wind(
                            size: 40,
                          ),
                          Text(
                            windSpeed.toString() + " m/s",
                            style: const TextStyle(
                              color: Color(0xff95d5ea),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xff95d5ea),
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 190, 190, 190),
                    offset: Offset(10, 10),
                    blurRadius: 30,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    offset: Offset(-10, -10),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ]),
            height: height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                        child: const LineIcon.sun(
                          size: 35,
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(sunriseTime.toUnixTime()) +
                            " AM",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 5.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const LineIcon.sun(
                          size: 25,
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(sunsetTime.toUnixTime()) + " AM",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
