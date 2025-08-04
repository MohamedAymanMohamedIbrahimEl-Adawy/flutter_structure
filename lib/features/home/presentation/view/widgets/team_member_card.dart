import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/team_member_model.dart';

class TeamMemberCard extends StatelessWidget {
  final TeamMember member;
  const TeamMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 22.w,
          child: Column(
            children: [
              CircleAvatar(radius: 28, child: Text(member.name[0])),
              const SizedBox(height: 4),
              Text(member.name, style: const TextStyle(fontSize: 12)),
              Text(
                member.role,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 0,
          right: 16,
          child: Icon(Icons.circle, color: Colors.green, size: 10),
        ),
      ],
    );
  }
}
