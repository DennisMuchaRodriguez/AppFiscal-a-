/// Lo que el notificador registra al llegar a una parada.
///
/// Si se entregó, se llenan los datos de quien recibió (DNI, nombre, relación).
/// Si no se pudo notificar, se llena el [motivo].
///
/// En el Paso 2 se agregarán aquí la foto del cargo y las coordenadas GPS.
class RegistroNotificacion {
  RegistroNotificacion({
    required this.fechaHora,
    this.dniReceptor,
    this.nombreReceptor,
    this.relacionConDestinatario,
    this.motivo,
    this.observaciones = '',
  });

  final DateTime fechaHora;
  final String? dniReceptor;
  final String? nombreReceptor;
  final String? relacionConDestinatario;
  final String? motivo;
  final String observaciones;

  bool get fueEntregada => motivo == null;
}

/// Opciones para "¿Quién recibió la notificación?".
const relacionesConDestinatario = [
  'El mismo destinatario',
  'Familiar',
  'Trabajador(a) del hogar',
  'Portero / vigilante',
  'Otro',
];

/// Opciones para "¿Por qué no se pudo notificar?".
const motivosNoNotificada = [
  'Destinatario ausente',
  'Dirección no encontrada',
  'Se negó a recibir',
  'Otro',
];
