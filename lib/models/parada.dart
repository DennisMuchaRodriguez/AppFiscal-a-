import 'registro_notificacion.dart';

/// En qué situación está una parada de la ruta.
enum EstadoParada {
  pendiente('Pendiente'),
  entregada('Entregada'),
  noNotificada('No notificada');

  const EstadoParada(this.etiqueta);

  /// Texto que se muestra en pantalla.
  final String etiqueta;
}

/// Una parada = una notificación que hay que dejar en una dirección.
class Parada {
  Parada({
    required this.id,
    required this.carpetaFiscal,
    required this.destinatario,
    required this.direccion,
    required this.distrito,
    required this.latitud,
    required this.longitud,
  });

  final String id;
  final String carpetaFiscal;
  final String destinatario;
  final String direccion;
  final String distrito;

  /// Coordenadas de la dirección. Se usarán en el mapa (Paso 3)
  /// y para la geocerca (Paso 5).
  final double latitud;
  final double longitud;

  /// Cambia cuando el notificador registra la visita.
  EstadoParada estado = EstadoParada.pendiente;

  /// Lo que se registró en esta parada (null mientras esté pendiente).
  RegistroNotificacion? registro;
}
