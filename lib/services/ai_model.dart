import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

// ignore: must_be_immutable
abstract class AiModel extends Equatable {
  final outputShapes = <List<int>>[];

  final outputTypes = <TensorType>[];
  Interpreter? interpreter;

  AiModel({this.interpreter});

  int get getAddress;

  @override
  List<Object> get props => [];

  TensorImage getProcessedImage(TensorImage inputImage);
  Future<void> loadModel();
  Map<String, dynamic>? predict(image_lib.Image image);
}
