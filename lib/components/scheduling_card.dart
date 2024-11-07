import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_world_mobile/@types/enums/scheduling_period.dart';
import 'package:pet_world_mobile/components/scheduling_item.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';

class SchedulingCard extends StatelessWidget {
  final SchedulingPeriod schedulingPeriod;

  const SchedulingCard({super.key, required this.schedulingPeriod});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5'
    ];

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
                    const Text(
                      'Manhã',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '09-12h',
                  style: TextStyle(
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
                items.length,
                (index) {
                  return SchedulingItem(
                    time: "10:30",
                    pet: 'Thor',
                    service: 'Aplicação de Anti-pulgas',
                    tutor: 'Fernanda Costa',
                    showDivider: index < (items.length - 1),
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
