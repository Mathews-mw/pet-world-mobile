import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/components/scheduling_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Agenda'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Text(
                  'Aqui você pode ver todos os clientes e serviços agendados para hoje.'),
              SizedBox(height: 20),
              SchedulingCard(
                schedulingPeriod: SchedulingPeriod.morning,
              ),
              SizedBox(height: 20),
              SchedulingCard(
                schedulingPeriod: SchedulingPeriod.afternoon,
              ),
              SizedBox(height: 20),
              SchedulingCard(
                schedulingPeriod: SchedulingPeriod.night,
              ),
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.SCHEDULING_FORM);
        },
        backgroundColor: AppColors.contentBrand,
        child: Icon(MdiIcons.calendarPlus),
      ),
    );
  }
}
