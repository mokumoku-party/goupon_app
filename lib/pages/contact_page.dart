import 'package:app/app.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

/// カメラコントローラ用のプロバイダー
final cameraControllerProvider =
    FutureProvider.autoDispose<CameraController>((ref) async {
  // 利用可能なカメラの一覧を取得
  final cameras = await availableCameras();
  CameraDescription camera;
  // 内カメをセット　※0: 外カメ　1: 内カメ
  if (!kIsWeb) {
    camera = cameras[1];
  } else {
    camera = cameras[0];
  }
  final controller = CameraController(
    camera,
    ResolutionPreset.high,
  );
  // プロバイダーの破棄時にカメラコントローラを破棄する
  ref.onDispose(() {
    controller.dispose();
  });

  // コントローラを初期化
  await controller.initialize();
  return controller;
});

final dio = Dio();

class ContactPage extends HookConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cameraControllerProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: controller.when(
        data: (data) => Flex(
          direction: kIsWeb ? Axis.vertical : Axis.horizontal,
          children: [
            CameraPreview(data),
            Center(
              child: IconButton(
                onPressed: () async {
                  final file = await data.takePicture();

                  if (!kIsWeb) {
                    final directory = await getExternalStorageDirectory();
                    if (directory == null) return;
                  }

                  // 端末に画像保存
                  final buffer = await file.readAsBytes();

                  if (!kIsWeb) {
                    final result = await ImageGallerySaver.saveImage(
                      buffer,
                      name: file.name,
                    );
                    print(result);
                  }

                  // 判定APIに投げる
                  const url = 'http://35.77.199.18/check_gou_touch';

                  final formData = FormData.fromMap({
                    'upload_file': MultipartFile.fromBytes(
                      buffer,
                      filename: 'hoge.png',
                      contentType: MediaType.parse('image/png'),
                    ),
                  });
                  print('start upload');
                  final response = await dio.post(
                    url,
                    data: formData,
                    options: Options(
                      headers: {
                        'accept': 'application/json',
                      },
                      contentType: 'multipart/form-data',
                    ),
                    onSendProgress: (count, total) =>
                        print('s: $count /  $total'),
                    onReceiveProgress: (count, total) =>
                        print('r: $count / $total'),
                  );
                  print('complete');
                  final success = response.data as bool;

                  return;
                },
                icon: const Icon(
                  Icons.circle,
                  size: 128,
                ),
              ),
            ),
          ],
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
