import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.details});
  final FlutterErrorDetails details;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: 'Error',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 24),
                    child: PText(
                      title: 'Error Occurred!',
                      size: PSize.text16,
                      fontWeight: FontWeight.w600,
                      fontColor: Colors.black,
                    ),
                  ),
                  PText(
                    title: details.exceptionAsString(),
                    size: PSize.text9,
                    fontColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
