import 'dart:async';

import 'package:app/data/personal_state.dart';
import 'package:app/routes/app_router.dart';
import 'package:app/widget_marker.dart';
import 'package:app/widget_marker_google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapPage extends HookConsumerWidget {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 1,
  );
  final PersonalState personalState;

  const MapPage({super.key, required this.personalState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statePosition = useState<Position?>(null);
    final guidePosition = useState<LatLng>(
        LatLng(personalState.latitude, personalState.longitude));
    final distance = useState<double>(0);
    final mapController = useState<GoogleMapController?>(null);
    final cameraSetFlag = useState<bool>(false);

    void _onMapCreated(GoogleMapController controller) {
      mapController.value = controller;
    }

    useEffect(() {
      StreamSubscription<Position>? positionStream;
      Future(() async {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          await Geolocator.requestPermission();
        }

        //現在位置を更新し続ける
        positionStream =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position? position) {
          if (position == null) return;
          if (!context.mounted) return;
          statePosition.value = position;

          if (mapController.value != null && !cameraSetFlag.value) {
            mapController.value!.moveCamera(CameraUpdate.newLatLng(
                LatLng(position.latitude, position.longitude)));
            cameraSetFlag.value = true;
          }

          distance.value = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            guidePosition.value.latitude,
            guidePosition.value.longitude,
          );

          print(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
        });
      });
      return positionStream?.cancel;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('aaaaaa'),
      ),
      body: Stack(
        children: [
          WidgetMarkerGoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(statePosition.value?.latitude ?? 35.5583744,
                    statePosition.value?.longitude ?? 139.7555427),
                zoom: 18,
              ),
              widgetMarkers: [
                WidgetMarker(
                  position: guidePosition.value,
                  markerId: 'clothes',
                  widget: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(4),
                    child: const Text(
                      '案内者の場所',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ]),
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/imgs/kani.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'あと',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${(distance.value / 80).ceil()}',
                                style: const TextStyle(fontSize: 32),
                              ),
                              const Text(
                                '分で合流です！',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF7E7E7E),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              side: const BorderSide(
                                color: Color(0xFF7E7E7E),
                              ),
                            ),
                            child: const Text('合流した！'),
                            onPressed: () {
                              ref.read(appRouterProvider).go('/guide_home');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
