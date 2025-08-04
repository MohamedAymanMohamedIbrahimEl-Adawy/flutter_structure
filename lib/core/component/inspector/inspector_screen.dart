import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_item.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';

class InspectorScreen extends StatelessWidget {
  final List<InspectorModel> inspectorList;
  const InspectorScreen({super.key, required this.inspectorList});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Http Calls'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                inspectorList.clear();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final item = inspectorList.reversed.toList()[index];
            return InspectorItem(
              item: item,
              isFailed: !(item.statusCode == 200 || item.statusCode == 201),
            );
          },
          itemCount: inspectorList.reversed.toList().length,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
