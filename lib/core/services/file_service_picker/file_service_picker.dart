import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cleanarchitecture/core/component/custom_toast/p_toast.dart';

import '../../global/enums/global_enum.dart';
import 'package:path/path.dart' as p;

/// Enum for file picker types
enum PickerType { multipleImages, singleImageGallery, singleImageCamera, file }

List<String> fileExtensions = [
  'pdf',
  'doc',
  'docx',
  'xls',
  'xlsx',
  'rar',
  'zip',
];

List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];

class FilePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Unified function for picking files
  Future<List<File>> pickFile(PickerType type, bool isReport) async {
    switch (type) {
      case PickerType.multipleImages:
        final List<XFile> pickedFiles = await _imagePicker.pickMultiImage();
        return pickedFiles.map((xFile) => File(xFile.path)).toList();

      case PickerType.singleImageCamera || PickerType.singleImageGallery:
        final XFile? pickedFile = await _imagePicker.pickImage(
          source:
              type == PickerType.singleImageCamera
                  ? ImageSource.camera
                  : ImageSource.gallery,
        );
        if (pickedFile != null) {
          // Extract file extension
          String? extension = p
              .extension(pickedFile.path)
              .toLowerCase()
              .replaceAll('.', '');

          if (!imageExtensions.contains(extension)) {
            SafeToast.show(
              duration: const Duration(seconds: 3),
              message: 'صيغة المرفق المختارة غير مدعومة',
              type: MessageType.error,
            );
            return [];
          }
          return [File(pickedFile.path)];
        } else {
          return [];
        }

      case PickerType.file:
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: fileExtensions,
        );
        if (result != null && result.files.isNotEmpty) {
          PlatformFile file = result.files.first;

          // Extract file extension
          String? extension = file.extension?.toLowerCase();

          if (extension != null && !fileExtensions.contains(extension)) {
            SafeToast.show(
              duration: const Duration(seconds: 3),
              message: 'صيغة المرفق المختارة غير مدعومة',
              type: MessageType.error,
            );
            return [];
          }
        }
        return (result != null && result.files.single.path != null)
            ? [File(result.files.single.path!)]
            : [];
    }
  }
}
