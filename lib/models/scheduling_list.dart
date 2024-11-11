import 'package:flutter/material.dart';
import 'package:pet_world_mobile/@types/enums/scheduling_period.dart';

import 'package:pet_world_mobile/data/dummy_data.dart';
import 'package:pet_world_mobile/models/scheduling.dart';
import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';

class SchedulingList with ChangeNotifier {
  final List<SchedulingDetails> _items = dummySchedules;

  List<SchedulingDetails> get schedules {
    print('Tamanho da lista de agendamentos: ${_items.length}');
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

  Future<void> saveScheduling(SchedulingDetails scheduling) async {
    _items.add(scheduling);

    notifyListeners();
  }
}
