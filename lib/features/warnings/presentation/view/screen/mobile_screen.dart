import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/body.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("warning".tr())),
      backgroundColor: Colors.red.shade50,
      body: const Body(),
    );
  }
}
