import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';

class SchedulingItem extends StatelessWidget {
  final String time;
  final String tutor;
  final String pet;
  final String service;
  final bool showDivider;

  const SchedulingItem({
    super.key,
    required this.time,
    required this.tutor,
    required this.pet,
    required this.service,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(Random().nextInt(100)),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Remover agendamento?'),
            content: const Text('Você realmente deseja remover o agendamento?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Sim'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {},
      child: Column(
        children: [
          ListTile(
            leading: Text(
              time,
              style: const TextStyle(
                color: AppColors.contentPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            title: Row(
              children: [
                Text(
                  pet,
                  style: const TextStyle(
                      color: AppColors.contentPrimary,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  ' / ',
                  style: TextStyle(
                    color: AppColors.contentSecondary,
                  ),
                ),
                Text(
                  tutor,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              service,
              style: const TextStyle(
                color: AppColors.contentSecondary,
              ),
            ),
          ),
          // Adiciona o Divider até o penúltimo item
          if (showDivider) const Divider(),
        ],
      ),
    );
  }
}
