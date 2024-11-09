enum AnimalType {
  DOG,
  CAT;

  String get label {
    switch (this) {
      case AnimalType.DOG:
        return 'Cachorro';
      case AnimalType.CAT:
        return 'Gato';
    }
  }

  String get value {
    switch (this) {
      case AnimalType.DOG:
        return 'DOG';
      case AnimalType.CAT:
        return 'CAT';
    }
  }
}
