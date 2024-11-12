// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime _selectedDate = DateTime.now();

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    ).then((date) {
      if (date == null) {
        return;
      }

      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final schedulingListProvider = Provider.of<SchedulingList>(context);

    final _schedulingList = schedulingListProvider.schedules;

    final _morningSchedules = schedulingListProvider.filterByDayAndPeriod(
      schedules: _schedulingList,
      date:
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
      period: SchedulingPeriod.morning,
    );
    final _afternoonSchedules = schedulingListProvider.filterByDayAndPeriod(
      schedules: _schedulingList,
      date:
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
      period: SchedulingPeriod.afternoon,
    );
    final _nightSchedules = schedulingListProvider.filterByDayAndPeriod(
      schedules: _schedulingList,
      date:
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
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
              Row(
                children: [
                  OutlinedButton.icon(
                      onPressed: () => _showDatePicker(context),
                      icon: Icon(MdiIcons.calendar),
                      label: Text(DateFormat('dd/MM/y').format(_selectedDate))),
                ],
              ),
              const SizedBox(height: 10),
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
