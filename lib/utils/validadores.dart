// Reglas para revisar lo que el notificador escribe en el formulario.
// Cada función devuelve null si el dato está bien, o el mensaje de error.

String? validarDni(String? valor) {
  final dni = valor?.trim() ?? '';
  if (dni.isEmpty) return 'Ingresa el DNI de quien recibe';
  if (!RegExp(r'^\d{8}$').hasMatch(dni)) return 'El DNI debe tener 8 dígitos';
  return null;
}

String? validarNombre(String? valor) {
  final nombre = valor?.trim() ?? '';
  if (nombre.isEmpty) return 'Ingresa el nombre de quien recibe';
  if (nombre.length < 3) return 'El nombre es muy corto';
  return null;
}
