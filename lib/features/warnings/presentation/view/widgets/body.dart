import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'vpnOrProxyDetected'.tr(),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'pleaseDisableVpnOrProxy'.tr(),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              onPressed: () {
                // ref.invalidate(vpnGuardProvider);
              },
              icon: const Icon(Icons.refresh, size: 36),
            ),
          ],
        ),
      ),
    );
  }
}
