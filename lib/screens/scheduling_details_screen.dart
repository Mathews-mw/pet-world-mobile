import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_world_mobile/models/scheduling_list.dart';

import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:provider/provider.dart';

enum PopupMenuButtonOptions { edit, delete }

class SchedulingDetailsScreen extends StatefulWidget {
  const SchedulingDetailsScreen({super.key});

  @override
  State<SchedulingDetailsScreen> createState() =>
      _SchedulingDetailsScreenState();
}

class _SchedulingDetailsScreenState extends State<SchedulingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final scheduling =
        ModalRoute.of(context)?.settings.arguments as SchedulingDetails;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do agendamento'),
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: PopupMenuButtonOptions.edit,
                  child: ListTile(
                    leading: Icon(MdiIcons.calendarEdit),
                    title: const Text('Editar agendamento'),
                  ),
                ),
                PopupMenuItem(
                  value: PopupMenuButtonOptions.delete,
                  child: ListTile(
                    leading: Icon(MdiIcons.calendarRemove),
                    title: const Text('Remover agendamento'),
                  ),
                )
              ],
              onSelected: (value) {
                if (value == PopupMenuButtonOptions.edit) {
                  Navigator.of(context).pushNamed(
                    AppRoutes.SCHEDULING_FORM,
                    arguments: scheduling,
                  );
                }

                if (value == PopupMenuButtonOptions.delete) {
                  showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Remover agendamento?'),
                      content: const Text(
                          'Você realmente deseja remover o agendamento?'),
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
                  ).then((response) {
                    if (response == true) {
                      if (context.mounted) {
                        Provider.of<SchedulingList>(context, listen: false)
                            .removeScheduling(scheduling);

                        Navigator.of(context).pop();
                      }
                    }
                  }).catchError((e) {
                    print(
                        'Erro ao tentar remover o agendamento a partir da tela de detalhes: $e');
                  });
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      MdiIcons.calendar,
                      color: AppColors.contentBrand,
                      size: 32,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat("dd/MM/y 'às' H:m 'hrs'")
                          .format(scheduling.date),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Pet:'),
                    const SizedBox(width: 10),
                    Text(
                      scheduling.petName,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Tipo de animal:'),
                    const SizedBox(width: 10),
                    Text(
                      scheduling.animalType,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Nome responsável:'),
                    const SizedBox(width: 10),
                    Text(
                      scheduling.petOwner,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Contato responsável:'),
                    const SizedBox(width: 10),
                    Text(
                      scheduling.ownerContact,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Serviço:'),
                    const SizedBox(width: 10),
                    Text(
                      scheduling.service.name,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Tutor:'),
                    const SizedBox(width: 10),
                    Text(
                      scheduling.tutor,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
