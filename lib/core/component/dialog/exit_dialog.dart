import 'dart:async';
import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(BuildContext context) {
  final Completer<bool?> completer = Completer<bool?>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Confirm Exit"),
        content: const Text("Are you sure you want to exit app?"),
        actions: [
          TextButton(
            onPressed: () {
              completer.complete(false);
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              completer.complete(true);
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );

  return completer.future;
}