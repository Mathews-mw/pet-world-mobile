import 'package:flutter/material.dart';

import 'package:pet_world_mobile/data/dummy_data.dart';
import 'package:pet_world_mobile/@types/enums/scheduling_period.dart';
import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';

class SchedulingList with ChangeNotifier {
  final List<SchedulingDetails> _items = dummySchedules;

  List<SchedulingDetails> get schedules {
    return [..._items];
  }

  int get itemsAmount {
    return _items.length;
  }

  List<SchedulingDetails> filterByDayAndPeriod({
    required List<SchedulingDetails> schedules,
    required DateTime date,
    required SchedulingPeriod period,
  }) {
    final schedulesByPeriod = schedules.where((scheduling) {
      final schedulingDate = scheduling.date;
      final startPeriod = period.timePeriod.start;
      final endPeriod = period.timePeriod.end;

      // Verifica se o agendamento é no mesmo dia
      final sameDay = schedulingDate.year == date.year &&
          schedulingDate.month == date.month &&
          schedulingDate.day == date.day;

      // Verifica se o horário está dentro do período
      final withinPeriod =
          schedulingDate.hour >= startPeriod && schedulingDate.hour < endPeriod;

      return sameDay && withinPeriod;
    }).toList();

    return schedulesByPeriod;
  }

  Future<void> saveScheduling(Map<String, Object> data) async {
    bool hasId = data['id'] != null;

    print('id on save: ${data['id']}');

    final selectedDate = data['date'] as DateTime;
    final selectedTime = data['hour'] as TimeOfDay;

    final scheduling = SchedulingDetails(
      id: hasId
          ? data['id'] as String
          : DateTime.now().microsecondsSinceEpoch.toString(),
      tutor: data['tutor'] as String,
      petName: data['petName'] as String,
      animalType: data['animalType'] as String,
      petOwner: data['petOwner'] as String,
      ownerContact: data['ownerContact'] as String,
      serviceCod: data['serviceCod'] as String,
      description: data['description'] as String,
      date: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      ),
    );

    if (hasId) {
      print('should call update method');
      return await updateScheduling(scheduling);
    } else {
      return await createScheduling(scheduling);
    }
  }

  Future<void> createScheduling(SchedulingDetails scheduling) async {
    _items.add(scheduling);

    notifyListeners();
  }

  Future<void> updateScheduling(SchedulingDetails scheduling) async {
    final index = _items.indexWhere((item) => item.id == scheduling.id);

    print('scheduling id: ${scheduling.id}');
    print('index: $index');

    if (index >= 0) {
      print('updated scheduling: $scheduling');

      _items[index] = scheduling;
      notifyListeners();
    }
  }

  Future<void> removeScheduling(SchedulingDetails scheduling) async {
    final index = _items.indexWhere((item) => item.id == scheduling.id);

    if (index >= 0) {
      _items.removeWhere((item) => item.id == scheduling.id);
      notifyListeners();
    }
  }
}
