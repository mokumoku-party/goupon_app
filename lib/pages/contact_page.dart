import 'dart:async';

import 'package:app/app.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
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
final _isLoadingProvider = StateProvider((ref) => false);
final _retryEventProvider = StateProvider((ref) => false);

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
            Stack(
              children: [
                CameraPreview(data),
                const Positioned.fill(
                  child: Center(
                    child: _LoadingIndicator(),
                  ),
                ),
                const Positioned.fill(
                    child: Center(
                  child: _SuccessDialog(),
                ))
              ],
            ),
            Flexible(
              child: Center(
                child: IconButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: const Size(128, 128),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    if (ref.read(_isLoadingProvider)) {
                      return;
                    }

                    ref
                        .read(_isLoadingProvider.notifier)
                        .update((state) => true);
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
                        filename: 'contact.png',
                        contentType: MediaType.parse('image/png'),
                      ),
                    });
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

                    final success = response.data as bool;

                    ref
                        .read(_retryEventProvider.notifier)
                        .update((_) => !success);
                    print('complete $success');
                    ref
                        .read(_isLoadingProvider.notifier)
                        .update((state) => false);

                    return;
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/icon-thumbs-up.svg',
                    width: 80,
                    height: 80,
                  ),
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

class _LoadingIndicator extends HookConsumerWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(_isLoadingProvider);

    return AnimatedOpacity(
      opacity: isLoading ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 50),
      child: const CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }
}

class _SuccessDialog extends HookConsumerWidget {
  const _SuccessDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final timer = Timer(const Duration(milliseconds: 3000), () {
        ref.read(_retryEventProvider.notifier).update((state) => false);
      });

      return timer.cancel;
    });

    return AnimatedOpacity(
      opacity: ref.watch(_retryEventProvider) ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 100),
      child: Container(
        width: 287,
        height: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              SvgPicture.asset('assets/icons/icon-sad.svg'),
              const Text('ぐーぽんっ！できませんでした', style: TextStyle(fontSize: 16)),
              const Text('再度撮影してみてください', style: TextStyle(fontSize: 16)),
            ],
          ),
        )),
      ),
    );
  }
}
