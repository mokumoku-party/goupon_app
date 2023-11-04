import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cameraListProvider = FutureProvider<List<CameraDescription>>((ref) async {
  return await availableCameras();
});
