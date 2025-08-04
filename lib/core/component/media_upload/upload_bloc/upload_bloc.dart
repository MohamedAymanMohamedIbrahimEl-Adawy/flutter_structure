import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarchitecture/core/services/file_service_picker/file_service_picker.dart';
import '../../../global/global_func.dart';
import 'upload_event.dart';
import 'upload_state.dart';

int imageMaxSizeInBytes = 5 * 1024 * 1024; // 5 MB
int fileMaxSizeInBytes = 2 * 1024 * 1024; // 2 MB

int reportSize = 14 * 1024 * 1024; // 5 MB
// int fileMaxSizeInBytes = 10 * 1024 * 1024; // 10 MB

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final FilePickerService _filePickerService = FilePickerService();
  final List<File> selectedFiles = [];

  UploadBloc() : super(UploadInitial()) {
    on<PickFiles>(_handlePickFiles);
    on<RemoveFile>(_handleRemoveFile);
  }

  Future<void> _handlePickFiles(
    PickFiles event,
    Emitter<UploadState> emit,
  ) async {
    try {
      List<File> newFiles = await _filePickerService.pickFile(
        event.pickerType,
        event.isReport,
      );

      if (newFiles.isEmpty) {
        emit(
          UploadFailure("No valid files selected or file size exceeds limit"),
        );
        return;
      }

      File image = newFiles.first;
      if (!(await validateImage(file: image, isReport: event.isReport))) {
        emit(UploadFailure("size of file is bigger"));
        return;
      }

      emit(Uploading());

      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Optional delay for smooth UX

      if (event.numberOfImages == 1) {
        selectedFiles.clear();
        selectedFiles.addAll(newFiles);
      } else {
        selectedFiles.addAll(newFiles);
      }

      emit(FilesPicked(List.from(selectedFiles)));
    } catch (e) {
      emit(UploadFailure("File picking failed: ${e.toString()}"));
    }
  }

  Future<void> _handleRemoveFile(
    RemoveFile event,
    Emitter<UploadState> emit,
  ) async {
    selectedFiles.removeWhere((file) => file.path == event.file.path);
    emit(FilesPicked(List.from(selectedFiles))); // Emit updated state
  }
}
