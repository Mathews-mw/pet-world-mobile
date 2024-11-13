import 'package:pet_world_mobile/data/dummy_data.dart';
import 'package:pet_world_mobile/models/service.dart';
import 'package:pet_world_mobile/models/scheduling.dart';

abstract class SchedulingDetailsProps extends Scheduling {
  abstract final Service service;

  SchedulingDetailsProps({
    required super.id,
    required super.tutor,
    required super.petName,
    required super.animalType,
    required super.petOwner,
    required super.ownerContact,
    required super.serviceCod,
    super.description,
    required super.date,
  });
}

class SchedulingDetails extends Scheduling {
  SchedulingDetails({
    required super.id,
    required super.tutor,
    required super.petName,
    required super.animalType,
    required super.petOwner,
    required super.ownerContact,
    required super.serviceCod,
    super.description,
    required super.date,
  });

  Service get service {
    final service =
        dummyServicesList.firstWhere((service) => service.cod == serviceCod);

    return service;
  }
}
