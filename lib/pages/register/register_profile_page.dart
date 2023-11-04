import 'dart:typed_data';

import 'package:app/app.dart';
import 'package:app/models/register_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:image_picker/image_picker.dart';

class RegisterProfilePage extends HookConsumerWidget {
  const RegisterProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final name = useState('');
    final isRegister = useState(false);
    final iconFile =
        ref.watch(registerNotifier.select((state) => state.iconPath));
    final iconByte = useState<Uint8List?>(null);

    useEffect(() {
      controller.addListener(() {
        name.value = controller.text;
      });
    });

    useEffect(() {
      Future.microtask(() async {
        iconByte.value = await iconFile?.readAsBytes();
      });
    }, [iconFile]);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          'プロフィール設定',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            Center(
              child: ClipOval(
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: iconByte.value == null
                      ? SvgPicture.asset(
                          'assets/icons/person_filled.svg',
                          width: 96,
                        )
                      : Image.memory(
                          iconByte.value!,
                          width: 96,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 0,
                );

                if (pickedFile != null) {
                  ref.read(registerNotifier.notifier).setIcon(pickedFile);
                }
              },
              child: const Text(
                '編集する',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: subSubColor,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: surfaceBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: '名前を入力してください',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: subSubColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      '最大10文字まで入力できます',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: subSubColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 228,
              child: ElevatedButton(
                onPressed: () async {
                  if (name.value.isEmpty) return;

                  isRegister.value = true;
                  try {
                    ref.read(registerNotifier.notifier).setName(name.value);
                    await ref.read(registerNotifier.notifier).insert();
                    // ignore: use_build_context_synchronously
                    context.go('/home');
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'エラー： $e',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    isRegister.value = false;
                    return;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      name.value.isEmpty ? backgroundColor : primaryColor,
                  surfaceTintColor: Colors.transparent,
                  shape: const StadiumBorder(
                    side: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
                child: Stack(
                  children: [
                    Text(
                      isRegister.value ? '登録中...' : '登録する！',
                      style: TextStyle(
                        fontSize: 16,
                        color: name.value.isEmpty ? primaryColor : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
