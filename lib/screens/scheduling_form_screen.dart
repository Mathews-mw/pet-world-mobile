import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pet_world_mobile/models/service.dart';
import 'package:pet_world_mobile/data/dummy_data.dart';
import 'package:pet_world_mobile/models/scheduling_list.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/@types/enums/animal_types.dart';
import 'package:pet_world_mobile/@mixins/form_validations_mixin.dart';
import 'package:pet_world_mobile/components/app_drawer/app_drawer.dart';
import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';

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

  final List<String> _tutorsList = dummyTutorsList;
  final List<Service> _servicesList = dummyServicesList;

  final _ownerFocus = FocusNode();
  final _petFocus = FocusNode();
  final _animalTypeFocus = FocusNode();
  final _contactFocus = FocusNode();
  final _serviceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _timeFocus = FocusNode();

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final scheduling = arg as SchedulingDetails;

        formData['id'] = scheduling.id;
        formData['tutor'] = scheduling.tutor;
        formData['petName'] = scheduling.petName;
        formData['animalType'] = scheduling.animalType;
        formData['petOwner'] = scheduling.petOwner;
        formData['ownerContact'] = scheduling.ownerContact;
        formData['serviceCod'] = scheduling.serviceCod;
        formData['description'] = scheduling.description ?? '';

        _selectedDate = DateTime(
          scheduling.date.year,
          scheduling.date.month,
          scheduling.date.day,
        );
        _selectedTime = TimeOfDay(
          hour: scheduling.date.hour,
          minute: scheduling.date.minute,
        );
        formData['date'] = _selectedDate;
        formData['hour'] = _selectedTime;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ownerFocus.dispose();
    _petFocus.dispose();
    _animalTypeFocus.dispose();
    _contactFocus.dispose();
    _serviceFocus.dispose();
    _descriptionFocus.dispose();
    _dateFocus.dispose();
    _timeFocus.dispose();
    _tutorController.dispose();
    _animalTypeController.dispose();
    _serviceController.dispose();
  }

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
        FocusScope.of(context).requestFocus(_timeFocus);
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

  Future<void> submitForm() async {
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
    if (formData['serviceCod'] == null) {
      setState(() {
        _isServiceFieldEmpty = true;
      });

      return;
    }

    try {
      await Provider.of<SchedulingList>(context, listen: false)
          .saveScheduling(formData);

      // Verifique se o widget ainda está montado antes de chamar Navigator.of(context)
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Erro ao tentar salvar o agendamento: $e');
    }
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
                        initialSelection: formData['tutor']?.toString(),
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
                        textInputAction: TextInputAction.next,
                        initialValue: formData['petOwner']?.toString(),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_petFocus);
                        },
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
                        focusNode: _petFocus,
                        textInputAction: TextInputAction.next,
                        initialValue: formData['petName']?.toString(),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_animalTypeFocus);
                        },
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
                        focusNode: _animalTypeFocus,
                        initialSelection: formData['animalType']?.toString(),
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
                        keyboardType: TextInputType.phone,
                        focusNode: _contactFocus,
                        textInputAction: TextInputAction.next,
                        initialValue: formData['ownerContact']?.toString(),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_serviceFocus);
                        },
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
                        focusNode: _serviceFocus,
                        initialSelection: formData['serviceCod']?.toString(),
                        onSelected: (value) {
                          if (value!.isNotEmpty) {
                            formData['serviceCod'] = value;
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
                        focusNode: _descriptionFocus,
                        initialValue: formData['description']?.toString(),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_dateFocus);
                        },
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
                                    focusNode: _dateFocus,
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
                                  focusNode: _timeFocus,
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
