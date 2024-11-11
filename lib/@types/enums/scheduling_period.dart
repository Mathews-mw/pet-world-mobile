enum SchedulingPeriod {
  morning,
  afternoon,
  night;

  String get value {
    switch (this) {
      case SchedulingPeriod.morning:
        return 'morning';
      case SchedulingPeriod.afternoon:
        return 'afternoon';
      case SchedulingPeriod.night:
        return 'night';
    }
  }

  String get label {
    switch (this) {
      case SchedulingPeriod.morning:
        return 'Manhã';
      case SchedulingPeriod.afternoon:
        return 'Tarde';
      case SchedulingPeriod.night:
        return 'Noite';
    }
  }

  String get labelTimePeriod {
    switch (this) {
      case SchedulingPeriod.morning:
        return '08-12h';
      case SchedulingPeriod.afternoon:
        return '12-18h';
      case SchedulingPeriod.night:
        return '18-21h';
    }
  }

  String get iconPath {
    switch (this) {
      case SchedulingPeriod.morning:
        return 'assets/icons/sun_fog.svg';
      case SchedulingPeriod.afternoon:
        return 'assets/icons/cloud_sun.svg';
      case SchedulingPeriod.night:
        return 'assets/icons/moon_stars.svg';
    }
  }

  ({int start, int end}) get timePeriod {
    switch (this) {
      case SchedulingPeriod.morning:
        return (start: 8, end: 12);
      case SchedulingPeriod.afternoon:
        return (start: 12, end: 18);
      case SchedulingPeriod.night:
        return (start: 18, end: 21);
    }
  }
}
