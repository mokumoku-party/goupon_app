import 'dart:ui';

import 'package:app/widget_marker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerGenerator extends StatefulWidget {
  const MarkerGenerator({
    Key? key,
    required this.widgetMarkers,
    required this.onMarkerGenerated,
  }) : super(key: key);
  final List<WidgetMarker> widgetMarkers;
  final ValueChanged<List<Marker>> onMarkerGenerated;

  @override
  _MarkerGeneratorState createState() => _MarkerGeneratorState();
}

class _MarkerGeneratorState extends State<MarkerGenerator> {
  List<GlobalKey> _globalKeys = [];
  List<WidgetMarker> _lastMarkers = [];

  Future<Marker> _convertToMarker(GlobalKey key) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData =
        await image.toByteData(format: ImageByteFormat.png) ?? ByteData(0);
    final uint8List = byteData.buffer.asUint8List();
    final widgetMarker = widget.widgetMarkers[_globalKeys.indexOf(key)];
    return Marker(
      onTap: widgetMarker.onTap,
      markerId: MarkerId(widgetMarker.markerId),
      position: widgetMarker.position,
      icon: BitmapDescriptor.fromBytes(uint8List),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        ?.addPersistentFrameCallback((_) => _onBuildCompleted());
  }

  Future<void> _onBuildCompleted() async {
    /// 無駄な更新を避けるため、
    /// 前回ビルド時とmarkerが同じだった場合はmarkerの生成をスキップします。
    if (_lastMarkers == widget.widgetMarkers) {
      return;
    }
    _lastMarkers = widget.widgetMarkers;
    final markers =
        await Future.wait(_globalKeys.map((key) => _convertToMarker(key)));
    widget.onMarkerGenerated.call(markers);
  }

  @override
  Widget build(BuildContext context) {
    _globalKeys = [];
    return Transform.translate(
      /// GoogleMapよりも先に描画されてしまった場合を考慮して、
      /// 生成したマーカーを画面の外に追いやります。
      offset: Offset(
        0,
        -MediaQuery.of(context).size.height,
      ),
      child: Stack(
        children: widget.widgetMarkers.map(
          (widgetMarker) {
            final key = GlobalKey();
            _globalKeys.add(key);
            return RepaintBoundary(
              key: key,
              child: widgetMarker.widget,
            );
          },
        ).toList(),
      ),
    );
  }
}
