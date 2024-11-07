import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_world_mobile/components/app_drawer/app_drawer.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';

class SchedulingFormScreen extends StatefulWidget {
  const SchedulingFormScreen({super.key});

  @override
  State<SchedulingFormScreen> createState() => _SchedulingFormScreenState();
}

class _SchedulingFormScreenState extends State<SchedulingFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agende um atendimento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: AppColors.contentPrimary),
                  decoration: InputDecoration(
                    labelText: 'Nome do tutor',
                    prefixIcon: Icon(MdiIcons.account),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
