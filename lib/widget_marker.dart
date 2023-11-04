import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMarker {
  WidgetMarker({
    required this.position,
    required this.markerId,
    required this.widget,
    this.onTap,
  }) : assert(markerId.isNotEmpty);

  final LatLng position;
  final String markerId;

  /// widgetのジェスチャーは無効化されるので、
  /// タップ時のコールバックが必要であればここに書く。
  final VoidCallback? onTap;

  /// ここが画像に変換される
  final Widget widget;
}
