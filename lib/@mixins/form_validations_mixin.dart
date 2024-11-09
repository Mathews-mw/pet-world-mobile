mixin FormValidationMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? 'Campo obrigatório';

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();

      if (validation != null) return validation;
    }

    return null;
  }
}
