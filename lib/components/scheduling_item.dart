import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pet_world_mobile/models/scheduling_list.dart';

import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';

class SchedulingItem extends StatelessWidget {
  final SchedulingDetails scheduling;
  final bool showDivider;

  const SchedulingItem({
    super.key,
    required this.scheduling,
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
      onDismissed: (_) async {
        try {
          await Provider.of<SchedulingList>(context, listen: false)
              .removeScheduling(scheduling);
        } catch (e) {
          print('Erro ao tentar remover agendamento: $e');
        }
      },
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('Navegar para tela de detalhes');
              Navigator.of(context).pushNamed(AppRoutes.SCHEDULING_DETAILS,
                  arguments: scheduling);
            },
            child: ListTile(
              leading: Text(
                DateFormat('Hm', 'pt_BR').format(scheduling.date),
                style: const TextStyle(
                  color: AppColors.contentPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              title: Row(
                children: [
                  Text(
                    scheduling.petName,
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
                    scheduling.tutor,
                    style: const TextStyle(
                      color: AppColors.contentSecondary,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                scheduling.service.name,
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                ),
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
