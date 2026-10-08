// Convierte fechas a texto en español, por ejemplo:
// "miércoles 8 de octubre de 2026" o "08/10/2026 14:35".

const _dias = [
  'lunes',
  'martes',
  'miércoles',
  'jueves',
  'viernes',
  'sábado',
  'domingo',
];

const _meses = [
  'enero',
  'febrero',
  'marzo',
  'abril',
  'mayo',
  'junio',
  'julio',
  'agosto',
  'septiembre',
  'octubre',
  'noviembre',
  'diciembre',
];

String fechaLarga(DateTime f) =>
    '${_dias[f.weekday - 1]} ${f.day} de ${_meses[f.month - 1]} de ${f.year}';

String hora(DateTime f) => '${_dosDigitos(f.hour)}:${_dosDigitos(f.minute)}';

String fechaHora(DateTime f) =>
    '${_dosDigitos(f.day)}/${_dosDigitos(f.month)}/${f.year} ${hora(f)}';

String _dosDigitos(int n) => n.toString().padLeft(2, '0');
