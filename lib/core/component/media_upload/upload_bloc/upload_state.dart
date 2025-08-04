import 'dart:io';


abstract class UploadState {}

class UploadInitial extends UploadState {}

class Uploading extends UploadState {}



class UploadFailure extends UploadState {
  final String error;
  UploadFailure(this.error);
}

class FilesPicked extends UploadState {
  final List<File> pickedFiles;
  FilesPicked(this.pickedFiles);
}

class FileRemoved extends UploadState {
  final List<File> remainingFiles;
  FileRemoved(this.remainingFiles);
}


