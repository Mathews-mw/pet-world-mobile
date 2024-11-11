import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/components/scheduling_item.dart';
import 'package:pet_world_mobile/@types/enums/scheduling_period.dart';
import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';

class SchedulesCard extends StatelessWidget {
  final List<SchedulingDetails> schedules;
  final SchedulingPeriod schedulingPeriod;

  const SchedulesCard({
    super.key,
    required this.schedules,
    required this.schedulingPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: AppColors.backgroundTertiary,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      schedulingPeriod.iconPath,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      schedulingPeriod.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  schedulingPeriod.labelTimePeriod,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.contentSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: List.generate(
                schedules.length,
                (index) {
                  return SchedulingItem(
                    scheduling: schedules[index],
                    showDivider: index < (schedules.length - 1),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
