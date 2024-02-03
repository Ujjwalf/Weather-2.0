import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_two/services/controllers/global_controller.dart';
import 'package:weather_two/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //call get provider
  final GlobalContorller globalContorller = Get.put(
    GlobalContorller(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      // appBar: AppBar(
      //   title: const Text('plpace name'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Obx(
          () => globalContorller.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : HeaderWidget(),
        ),
      ),
    );
  }
}
