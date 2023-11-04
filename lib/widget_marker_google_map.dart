import 'package:app/marker_generator.dart';
import 'package:app/widget_marker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMarkerGoogleMap extends StatefulWidget {
  const WidgetMarkerGoogleMap({
    Key? key,
    required this.initialCameraPosition,
    this.onMapCreated,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.mapType = MapType.normal,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.liteModeEnabled = false,
    this.tiltGesturesEnabled = true,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.layoutDirection,
    this.padding = const EdgeInsets.all(0),
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.buildingsEnabled = true,
    this.widgetMarkers = const <WidgetMarker>[],
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
    this.circles = const <Circle>{},
    this.onCameraMoveStarted,
    this.tileOverlays = const <TileOverlay>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  /// MarkerGeneratorに渡す
  ///
  /// WidgetMarkerのリスト
  final List<WidgetMarker> widgetMarkers;

  /// Markerを除く、純正Google Mapの引数たち
  final MapCreatedCallback? onMapCreated;
  final CameraPosition initialCameraPosition;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final MapType mapType;
  final TextDirection? layoutDirection;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool liteModeEnabled;
  final bool tiltGesturesEnabled;
  final EdgeInsets padding;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<TileOverlay> tileOverlays;
  final VoidCallback? onCameraMoveStarted;
  final CameraPositionCallback? onCameraMove;
  final VoidCallback? onCameraIdle;
  final ArgumentCallback<LatLng>? onTap;
  final ArgumentCallback<LatLng>? onLongPress;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool indoorViewEnabled;
  final bool trafficEnabled;
  final bool buildingsEnabled;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  @override
  State<WidgetMarkerGoogleMap> createState() => _WidgetMarkerGoogleMapState();
}

class _WidgetMarkerGoogleMapState extends State<WidgetMarkerGoogleMap> {
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.widgetMarkers.isNotEmpty)
          MarkerGenerator(
            widgetMarkers: widget.widgetMarkers,
            onMarkerGenerated: (_markers) {
              setState(
                () {
                  markers = _markers.toSet();
                },
              );
            },
          ),
        GoogleMap(
          initialCameraPosition: widget.initialCameraPosition,
          onMapCreated: widget.onMapCreated,
          gestureRecognizers: widget.gestureRecognizers,
          compassEnabled: widget.compassEnabled,
          mapToolbarEnabled: widget.mapToolbarEnabled,
          cameraTargetBounds: widget.cameraTargetBounds,
          mapType: widget.mapType,
          minMaxZoomPreference: widget.minMaxZoomPreference,
          rotateGesturesEnabled: widget.rotateGesturesEnabled,
          scrollGesturesEnabled: widget.scrollGesturesEnabled,
          zoomControlsEnabled: widget.zoomControlsEnabled,
          zoomGesturesEnabled: widget.zoomGesturesEnabled,
          liteModeEnabled: widget.liteModeEnabled,
          tiltGesturesEnabled: widget.tiltGesturesEnabled,
          myLocationEnabled: widget.myLocationEnabled,
          myLocationButtonEnabled: widget.myLocationButtonEnabled,
          layoutDirection: widget.layoutDirection,
          padding: widget.padding,
          indoorViewEnabled: widget.indoorViewEnabled,
          trafficEnabled: widget.trafficEnabled,
          buildingsEnabled: widget.buildingsEnabled,
          markers: markers,
          polygons: widget.polygons,
          polylines: widget.polylines,
          circles: widget.circles,
          onCameraMoveStarted: widget.onCameraMoveStarted,
          tileOverlays: widget.tileOverlays,
          onCameraMove: widget.onCameraMove,
          onCameraIdle: widget.onCameraIdle,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        ),
      ],
    );
  }
}
