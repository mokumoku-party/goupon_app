import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/data.dart';
import '../../camera/camera_page.dart';

class ModelCard extends StatelessWidget {
  final int index;

  final double scale;
  const ModelCard({
    required this.index,
    required this.scale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTapCamera(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(models[index]['image']!),
            fit: BoxFit.cover,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30 * scale,
        ),
        child: _ModelDescription(index: index),
      ),
    );
  }

  void _onTapCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CameraPage(index: index);
        },
      ),
    );
  }
}

class _ModelDescription extends StatelessWidget {
  final int index;

  const _ModelDescription({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          padding: EdgeInsets.all(ScreenUtil().setWidth(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                models[index]['title']!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(20.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(8.0),
              ),
              Text(
                models[index]['text']!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(12.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
