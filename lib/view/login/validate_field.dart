String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome é obrigatório';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O e-mail é obrigatório';
    } else if (!value.contains('@')) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'O CPF é obrigatório';
    } else if (value.length != 14) {
      return 'CPF inválido';
    }
    return null;
  }

  String? validateRG(String? value) {
    if (value == null || value.isEmpty) {
      return 'O RG é obrigatório';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'O endereço é obrigatório';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'O número de telefone é obrigatório';
    } else if (value.length != 16) {
      return 'Número de telefone inválido';
    }
    return null;
  }