// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cleanarchitecture/core/services/file_service_picker/file_service_picker.dart';

abstract class UploadEvent {}

class PickFiles extends UploadEvent {
  final PickerType pickerType;
  final int numberOfImages;
  final bool isReport;
  PickFiles({
    required this.pickerType,
    required this.numberOfImages,
    required this.isReport,
  });
}

class RemoveFile extends UploadEvent {
  final File file;
  RemoveFile(this.file);
}
