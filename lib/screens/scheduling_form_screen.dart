import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pet_world_mobile/models/service.dart';
import 'package:pet_world_mobile/models/scheduling.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/@types/enums/animal_types.dart';
import 'package:pet_world_mobile/@mixins/form_validations_mixin.dart';
import 'package:pet_world_mobile/components/app_drawer/app_drawer.dart';

class SchedulingFormScreen extends StatefulWidget {
  const SchedulingFormScreen({super.key});

  @override
  State<SchedulingFormScreen> createState() => _SchedulingFormScreenState();
}

class _SchedulingFormScreenState extends State<SchedulingFormScreen>
    with FormValidationMixin {
  final List<AnimalType> _animalTypes = [
    AnimalType.DOG,
    AnimalType.CAT,
  ];

  final List<String> _tutorsList = [
    'Floyd Beck',
    'Jordan Evans',
    'Ian McDonald',
    'Lulu Reed',
    'Owen Hardy',
    'Jeffery Kelly',
    'Georgia Fernandez',
    'Alejandro Hale',
    'Edgar Turner',
    'Luke Maxwell',
    'Charlotte James',
    'Glenn Logan',
    'Jesse Owens',
  ];

  final List<Service> _servicesList = [
    Service(cod: '4780e245-a91c-57ac-966c-76080ac94426', name: 'Banho e Tosa'),
    Service(
        cod: 'cbb8183d-8030-56ab-8897-d8fc89b9a8d6',
        name: 'Serviços Veterinários'),
    Service(
        cod: '36575386-5fcf-5ce4-af11-6ccd88d5a35e',
        name: 'Exames de Laboratório'),
    Service(cod: '6feaa0a3-5aaa-5977-a07a-8fc7725478e3', name: 'Hospedagem'),
    Service(cod: '1b1444ad-7016-5f5b-9299-36e6bc345859', name: 'Taxi Dog'),
    Service(cod: 'cb849881-b6d5-5723-87c3-968c691d9a92', name: 'Spa'),
    Service(cod: 'b81ee7b9-549c-5829-b6df-bda96b21d56c', name: 'Vacinação'),
    Service(cod: 'a6698b02-ab17-59b1-a574-63a26df2d9aa', name: 'Clinica'),
  ];

  final TextEditingController _tutorController = TextEditingController();
  final TextEditingController _animalTypeController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();

  bool _isTutorFieldEmpty = false;
  bool _isAnimalTypeFieldEmpty = false;
  bool _isServiceFieldEmpty = false;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, Object> formData = <String, Object>{};

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
        formData['date'] = date;
      });
    });
  }

  _showTimePicker(BuildContext context) {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext ctx, Widget? child) {
          final mediaQueryData = MediaQuery.of(ctx);

          return MediaQuery(
            data: mediaQueryData.alwaysUse24HourFormat
                ? mediaQueryData
                : mediaQueryData.copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        }).then((time) {
      if (time == null) {
        return;
      }

      setState(() {
        _selectedTime = time;
        formData['hour'] = time;
      });
    });
  }

  void submitForm() {
    final bool isValidForm = formKey.currentState?.validate() ?? false;

    if (!isValidForm) {
      return;
    }

    formKey.currentState?.save();

    if (formData['tutor'] == null) {
      setState(() {
        _isTutorFieldEmpty = true;
      });

      return;
    }
    if (formData['animalType'] == null) {
      setState(() {
        _isAnimalTypeFieldEmpty = true;
      });

      return;
    }
    if (formData['service'] == null) {
      setState(() {
        _isServiceFieldEmpty = true;
      });

      return;
    }

    formData.forEach((k, v) => print('key: $k | value: $v'));

    final selectedDate = formData['date'] as DateTime;
    final selectedTime = formData['hour'] as TimeOfDay;

    final scheduling = Scheduling(
      tutor: formData['tutor'] as String,
      petName: formData['petName'] as String,
      animalType: formData['animalType'] as String,
      petOwner: formData['petOwner'] as String,
      ownerContact: formData['ownerContact'] as String,
      service: formData['service'] as String,
      description: formData['description'] as String,
      date: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agende um atendimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownMenu(
                        expandedInsets: EdgeInsets.zero,
                        menuStyle: const MenuStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            AppColors.backgroundSecondary,
                          ),
                          maximumSize: WidgetStatePropertyAll<Size>(
                            Size.fromHeight(280),
                          ),
                        ),
                        inputDecorationTheme: const InputDecorationTheme(),
                        label: const Text('Tutor'),
                        leadingIcon: Icon(MdiIcons.badgeAccount),
                        textStyle: const TextStyle(
                          color: AppColors.contentPrimary,
                        ),
                        controller: _tutorController,
                        errorText: _isTutorFieldEmpty
                            ? 'Por favor, selecione um tutor'
                            : null,
                        onSelected: (value) {
                          if (value!.isNotEmpty) {
                            formData['tutor'] = value;
                            setState(() => _isTutorFieldEmpty = false);
                          }
                        },
                        dropdownMenuEntries:
                            _tutorsList.map<DropdownMenuEntry<String>>((value) {
                          return DropdownMenuEntry<String>(
                            value: value,
                            label: value,
                            style: MenuItemButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        style: const TextStyle(color: AppColors.contentPrimary),
                        decoration: InputDecoration(
                          labelText: 'Nome do responsável',
                          prefixIcon: Icon(MdiIcons.account),
                        ),
                        onSaved: (String? value) =>
                            formData['petOwner'] = value ?? '',
                        validator: isNotEmpty,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        style: const TextStyle(color: AppColors.contentPrimary),
                        decoration: const InputDecoration(
                          labelText: 'Nome do pet',
                          prefixIcon: Icon(Icons.pets),
                        ),
                        onSaved: (String? value) =>
                            formData['petName'] = value ?? '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownMenu(
                        expandedInsets: EdgeInsets.zero,
                        menuStyle: const MenuStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            AppColors.backgroundSecondary,
                          ),
                          maximumSize: WidgetStatePropertyAll<Size>(
                            Size.fromHeight(280),
                          ),
                        ),
                        inputDecorationTheme: const InputDecorationTheme(),
                        label: const Text('Tipo de animal'),
                        leadingIcon: Icon(MdiIcons.dog),
                        textStyle: const TextStyle(
                          color: AppColors.contentPrimary,
                        ),
                        errorText: _isAnimalTypeFieldEmpty
                            ? 'Por favor, selecione um tipo de animal'
                            : null,
                        controller: _animalTypeController,
                        onSelected: (value) {
                          if (value!.isNotEmpty) {
                            formData['animalType'] = value;
                            setState(() => _isAnimalTypeFieldEmpty = false);
                          }
                        },
                        dropdownMenuEntries:
                            _animalTypes.map<DropdownMenuEntry<String>>((item) {
                          return DropdownMenuEntry<String>(
                            value: item.value,
                            label: item.label,
                            style: MenuItemButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        style: const TextStyle(color: AppColors.contentPrimary),
                        decoration: InputDecoration(
                          labelText: 'Contato',
                          prefixIcon: Icon(MdiIcons.phone),
                        ),
                        onSaved: (String? value) =>
                            formData['ownerContact'] = value ?? '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownMenu(
                        expandedInsets: EdgeInsets.zero,
                        menuStyle: const MenuStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            AppColors.backgroundSecondary,
                          ),
                          maximumSize: WidgetStatePropertyAll<Size>(
                            Size.fromHeight(280),
                          ),
                        ),
                        inputDecorationTheme: const InputDecorationTheme(),
                        label: const Text('Serviço'),
                        leadingIcon: Icon(MdiIcons.dogService),
                        textStyle: const TextStyle(
                          color: AppColors.contentPrimary,
                        ),
                        errorText: _isServiceFieldEmpty
                            ? 'Por favor, selecione um tipo de serviço'
                            : null,
                        controller: _serviceController,
                        onSelected: (value) {
                          if (value!.isNotEmpty) {
                            formData['service'] = value;
                            setState(() => _isServiceFieldEmpty = false);
                          }
                        },
                        dropdownMenuEntries: _servicesList
                            .map<DropdownMenuEntry<String>>((item) {
                          return DropdownMenuEntry<String>(
                            value: item.cod,
                            label: item.name,
                            style: MenuItemButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 5,
                        style: const TextStyle(color: AppColors.contentPrimary),
                        decoration: const InputDecoration(
                          hintText: 'Insira alguma observação...',
                        ),
                        onSaved: (String? value) =>
                            formData['description'] = value ?? '',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.calendar,
                                    color: AppColors.contentBrand,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Data',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () => _showDatePicker(context),
                                    child: Text(DateFormat('dd/MM/y')
                                        .format(_selectedDate))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.clock,
                                    color: AppColors.contentBrand,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Hora',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () => _showTimePicker(context),
                                  child: Text(
                                    '${_selectedTime.hour.toString()}: ${_selectedTime.minute.toString()}',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: submitForm,
                  child: const Text('AGENDAR'),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
