class Scheduling {
  String id = DateTime.now().microsecondsSinceEpoch.toString();
  final String tutor;
  final String petName;
  final String animalType;
  final String petOwner;
  final String ownerContact;
  final String serviceCod;
  final String? description;
  final DateTime date;

  Scheduling({
    required this.tutor,
    required this.petName,
    required this.animalType,
    required this.petOwner,
    required this.ownerContact,
    required this.serviceCod,
    required this.date,
    this.description,
  });

  set tutor(String tutor) {
    this.tutor = tutor;
  }

  set petName(String petName) {
    this.petName = petName;
  }

  set petType(String petType) {
    this.petType = petType;
  }

  set petOwner(String petOwner) {
    this.petOwner = petOwner;
  }

  set ownerContact(String ownerContact) {
    this.ownerContact = ownerContact;
  }

  set serviceCod(String serviceCod) {
    this.serviceCod = serviceCod;
  }

  set description(String? description) {
    this.description = description;
  }
}
