import 'package:pet_world_mobile/models/service.dart';
import 'package:pet_world_mobile/@types/enums/animal_types.dart';
import 'package:pet_world_mobile/models/value-objects/scheduling_details.dart';

final List<SchedulingDetails> dummySchedules = [
  SchedulingDetails(
    tutor: dummyTutorsList[0],
    petName: 'Margaret',
    animalType: AnimalType.DOG.label,
    petOwner: 'Ivan Thomas',
    ownerContact: '(611) 700-2910',
    serviceCod: dummyServicesList[0].cod,
    date: DateTime(2024, 11, 13, 9, 30),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[1],
    petName: 'Butler',
    animalType: AnimalType.DOG.label,
    petOwner: 'Eugene Dean',
    ownerContact: '(615) 722-7914',
    serviceCod: dummyServicesList[1].cod,
    date: DateTime(2024, 11, 13, 9, 45),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[2],
    petName: 'Alta',
    animalType: AnimalType.CAT.label,
    petOwner: 'Rodney Fowler',
    ownerContact: '(317) 515-3977',
    serviceCod: dummyServicesList[2].cod,
    date: DateTime(2024, 11, 13, 10, 15),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[3],
    petName: 'Miguel',
    animalType: AnimalType.DOG.label,
    petOwner: 'Sophia McBride',
    ownerContact: '(624) 743-8901',
    serviceCod: dummyServicesList[3].cod,
    date: DateTime(2024, 11, 13, 14),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[4],
    petName: 'Evelyn',
    animalType: AnimalType.CAT.label,
    petOwner: 'Don McDaniel',
    ownerContact: '(565) 552-2547',
    serviceCod: dummyServicesList[4].cod,
    date: DateTime(2024, 11, 13, 14, 30),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[5],
    petName: 'Darrell',
    animalType: AnimalType.CAT.label,
    petOwner: 'Marie Willis',
    ownerContact: '(656) 779-6288',
    serviceCod: dummyServicesList[5].cod,
    date: DateTime(2024, 11, 13, 15, 15),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[6],
    petName: 'Andrew',
    animalType: AnimalType.DOG.label,
    petOwner: 'Francisco Rhodes',
    ownerContact: '(819) 439-2158',
    serviceCod: dummyServicesList[6].cod,
    date: DateTime(2024, 11, 13, 19, 30),
  ),
  SchedulingDetails(
    tutor: dummyTutorsList[7],
    petName: 'Lucile',
    animalType: AnimalType.CAT.label,
    petOwner: 'Bettie Mills',
    ownerContact: '(379) 834-8757',
    serviceCod: dummyServicesList[7].cod,
    date: DateTime(2024, 11, 13, 20),
  ),
];

final List<Service> dummyServicesList = [
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

final List<String> dummyTutorsList = [
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
