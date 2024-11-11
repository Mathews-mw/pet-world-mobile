// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:pet_world_mobile/models/scheduling_list.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/components/schedules_card.dart';
import 'package:pet_world_mobile/@types/enums/scheduling_period.dart';
import 'package:pet_world_mobile/components/app_drawer/app_drawer.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    final schedulingListProvider = Provider.of<SchedulingList>(context);

    final _schedulingList = schedulingListProvider.schedules;
    print('_schedulingList: ${_schedulingList.length}');

    final _morningSchedules = schedulingListProvider.filterByDayAndPeriod(
      schedules: _schedulingList,
      date: DateTime(2024, 11, 13),
      period: SchedulingPeriod.morning,
    );
    final _afternoonSchedules = schedulingListProvider.filterByDayAndPeriod(
      schedules: _schedulingList,
      date: DateTime(2024, 11, 13),
      period: SchedulingPeriod.afternoon,
    );
    final _nightSchedules = schedulingListProvider.filterByDayAndPeriod(
      schedules: _schedulingList,
      date: DateTime(2024, 11, 13),
      period: SchedulingPeriod.night,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Agenda'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              const Text(
                  'Aqui você pode ver todos os clientes e serviços agendados para hoje.'),
              const SizedBox(height: 20),
              SchedulesCard(
                schedules: _morningSchedules,
                schedulingPeriod: SchedulingPeriod.morning,
              ),
              const SizedBox(height: 20),
              SchedulesCard(
                schedules: _afternoonSchedules,
                schedulingPeriod: SchedulingPeriod.afternoon,
              ),
              const SizedBox(height: 20),
              SchedulesCard(
                schedules: _nightSchedules,
                schedulingPeriod: SchedulingPeriod.night,
              ),
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.SCHEDULING_FORM);
        },
        backgroundColor: AppColors.contentBrand,
        child: Icon(MdiIcons.calendarPlus),
      ),
    );
  }
}
