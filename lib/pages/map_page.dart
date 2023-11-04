import 'dart:async';

import 'package:app/widget_marker.dart';
import 'package:app/widget_marker_google_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends HookConsumerWidget {
  const MapPage({super.key});

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 1,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statePosition = useState<Position?>(null);
    final guidePosition =
        useState<LatLng>(const LatLng(35.5583744, 139.7555427));
    final distance = useState<double>(10000000000000000000);
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
                zoom: 17,
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
          Text('距離 ${distance.value}'),
        ],
      ),
    );
  }
}
