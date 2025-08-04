import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/features/parent/presentation/ui/widgets/parent_bottom_nav.dart';

class ParentScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final int? index;
  const ParentScreen({super.key, this.index, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clean Architecture"), centerTitle: true),
      bottomNavigationBar: CustomBottomNavigation(
        navigationShell: navigationShell,
      ),
      body: navigationShell,
    );
  }
}
