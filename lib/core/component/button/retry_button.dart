import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryButton({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh, size: 30, color: AppColors.primaryColor),
    );
    // return Padding(padding:const EdgeInsets.only(top:14),
    //   child: ElevatedButton(
    //     onPressed: onRetry,
    //     style: ElevatedButton.styleFrom(
    //       padding: const EdgeInsets.symmetric(horizontal:12, vertical: 6),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20),
    //       ), backgroundColor:AppColors.primaryColor, elevation: 4,
    //       shadowColor:AppColors.primaryColor.withValues(alpha: 0.4),
    //     ),
    //     child: const Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Icon(Icons.refresh,
    //           size: 20,
    //           color: Colors.white,
    //         ),
    //         SizedBox(width: 8),
    //         Text(
    //           "Retry",
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
