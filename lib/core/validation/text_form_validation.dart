class TextFormValidation {
  static String? Function(String?)? validate({FormFieldType? field}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Введите текст';
      }
      if (field == FormFieldType.email) {
        if (!value.contains('@')) {
          return 'Введите email';
        }
      }
      return null;
    };
  }
}

enum FormFieldType { email, password, name }
