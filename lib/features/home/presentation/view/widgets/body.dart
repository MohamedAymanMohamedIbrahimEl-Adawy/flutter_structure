import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/model/team_member_model.dart';
import 'team_member_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    const members = [
      TeamMember(name: 'Mohamed', role: 'Mobile Developer', online: false),
      TeamMember(name: 'Ayman', role: 'Frontend Developer', online: true),
      TeamMember(name: 'Ali', role: 'Backend Developer', online: true),
      TeamMember(name: 'Said', role: 'Quanilty Controller', online: false),
      TeamMember(name: 'Nour', role: 'UI UX', online: false),

      TeamMember(name: 'Said', role: 'Quanilty Controller', online: true),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('home'.tr(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                // separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: members.length,
                itemBuilder: (context, i) => TeamMemberCard(member: members[i]),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class AddTaskSheet extends StatelessWidget {
  const AddTaskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('addTask'.tr(), style: Theme.of(context).textTheme.titleLarge),
          TextField(decoration: InputDecoration(labelText: 'title'.tr())),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('save'.tr()),
          ),
        ],
      ),
    );
  }
}
