import 'package:flutter/material.dart';

import 'package:geo_distance_calculator/geo_distance_calculator.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';

import '../../helpers/interstitial_ad_helper.dart';
import '../../models/place_model.dart';
import '../../services/http_service.dart';
import '../../services/place_service.dart';
import '../place_details/place_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PlaceService _placeService;
  late Future<List<PlaceModel>> _placesFuture;

  PageController imagePageController = PageController(viewportFraction: 0.75);
  PageController coverImagePageController = PageController();

  int currentPage = 0;

  bool watchAds = false;

  @override
  void initState() {
    super.initState();
    //
    _placeService = PlaceService(HttpService());
    _placesFuture = _placeService.getAllPlaces();
    //
    imagePageController.addListener(() {
      setState(() {
        currentPage = imagePageController.page?.round() ?? 0;
      });
    });
    InterstitialAdHelper.initialize();
    InterstitialAdHelper.loadInterstitialAd();
    InterstitialAdHelper.onAdClosed = () {
      setState(() {
        watchAds = true;
      });
    };
  }

  void _onShowInterstitialAd() {
    InterstitialAdHelper.showInterstitialAd();
  }

  String calcDistance(endLatitude, endLongitude) {
    double distance = GeoDistanceCalculator.calculateDistance(
      startLatitude: 16.82241,
      startLongitude: 107.08553,
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    );

    return "$distance km";
  }

  @override
  void dispose() {
    InterstitialAdHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        body: FutureBuilder<List<PlaceModel>>(
            future: _placesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No places available'));
              }

              final places = snapshot.data!;
              return Stack(
                children: [
                  PageView.builder(
                    controller: coverImagePageController,
                    scrollBehavior: const ScrollBehavior(),
                    scrollDirection: Axis.horizontal,
                    itemCount: places.length,
                    onPageChanged: (value) {
                      imagePageController.animateToPage(
                        value,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ShaderMask(
                        blendMode: BlendMode.modulate,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.transparent,
                            ],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: Image.network(
                          places[index].coverImage,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height * 0.50,
                        width: size.width,
                        child: PageView.builder(
                            controller: imagePageController,
                            onPageChanged: (value) {
                              coverImagePageController.animateToPage(
                                value,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            itemCount: places.length,
                            itemBuilder: (context, currentIndex) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  bottom: currentPage == currentIndex ? 0 : 30,
                                  top: currentPage == currentIndex ? 0 : 30,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                            alignment: Alignment.topCenter,
                                            image: NetworkImage(
                                                places[currentIndex].image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: size.height * 0.30,
                                        width: size.width * 0.70,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          places[currentIndex].name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: places[currentIndex]
                                            .type
                                            .map(
                                              (e) => Container(
                                                margin: const EdgeInsets.all(2),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                ),
                                                child: Text(e),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        calcDistance(
                                          places[currentIndex].latitude,
                                          places[currentIndex].longitude,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceDetailScreen(
                                  place: places[
                                      coverImagePageController.page?.toInt() ??
                                          0],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "XEM CHI TIẾT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
      floatingWidget: watchAds
          ? const SizedBox.shrink()
          : InkWell(
              onTap: _onShowInterstitialAd,
              child: Image.asset(
                'assets/images/ads.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
      floatingWidgetHeight: 100,
      floatingWidgetWidth: 130,
      dx: 270,
      dy: 80,
    );
  }
}
