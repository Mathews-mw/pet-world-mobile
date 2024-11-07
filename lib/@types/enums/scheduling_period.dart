enum SchedulingPeriod {
  morning,
  afternoon,
  night;

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
}
