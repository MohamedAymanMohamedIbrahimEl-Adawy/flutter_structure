import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/error_widget.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/component/inspector/overview_widget.dart';
import 'package:cleanarchitecture/core/component/inspector/request_widget.dart';
import 'package:cleanarchitecture/core/component/inspector/response_widget.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';

class InspectorDetailsScreen extends StatefulWidget {
  final InspectorModel inspectorModel;
  const InspectorDetailsScreen({super.key, required this.inspectorModel});
  @override
  State<InspectorDetailsScreen> createState() => InspectorDetailsScreenState();
}

class InspectorDetailsScreenState extends State<InspectorDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //tabcontroller.index can be used to get the name of current index value of the tabview.
          title: Text(
            tabController.index == 0
                ? 'Overview'
                : tabController.index == 1
                ? 'Request'
                : tabController.index == 2
                ? 'Response'
                : 'Error',
          ),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: 'Overview',
                icon: Icon(Icons.error_outline, color: Colors.indigo.shade500),
              ),
              Tab(
                text: 'Request',
                icon: Icon(
                  Icons.arrow_upward_sharp,
                  color: Colors.indigo.shade500,
                ),
              ),
              Tab(
                text: 'Response',
                icon: Icon(Icons.restore_page, color: Colors.indigo.shade500),
              ),

              Tab(
                text: 'Error',
                icon: Icon(Icons.error, color: Colors.indigo.shade500),
              ),
            ],
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            OverviewWidget(inspectorModel: widget.inspectorModel),
            RequestWidget(inspectorModel: widget.inspectorModel),
            ResponseWidget(inspectorModel: widget.inspectorModel),
            ErrorInspectorWidget(inspectorModel: widget.inspectorModel),
          ],
        ),
      ),
    );
  }
}
