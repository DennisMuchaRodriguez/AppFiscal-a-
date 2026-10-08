import 'package:flutter/foundation.dart';

import '../models/parada.dart';
import '../models/registro_notificacion.dart';

/// Guarda las paradas del día y avisa a las pantallas cuando algo cambia
/// (por eso extiende [ChangeNotifier]).
///
/// Las pantallas lo escuchan con `ListenableBuilder`: cada vez que aquí se
/// llama a `notifyListeners()`, se vuelven a dibujar con los datos nuevos.
class RutaDelDia extends ChangeNotifier {
  RutaDelDia(List<Parada> paradas) : _paradas = paradas;

  final List<Parada> _paradas;

  /// Todas las paradas, en el orden de visita.
  List<Parada> get paradas => List.unmodifiable(_paradas);

  List<Parada> get pendientes =>
      _paradas.where((p) => p.estado == EstadoParada.pendiente).toList();

  int get total => _paradas.length;
  int get atendidas => total - pendientes.length;
  int get entregadas => _contar(EstadoParada.entregada);
  int get noNotificadas => _contar(EstadoParada.noNotificada);

  /// Número de la parada en la ruta (1, 2, 3...).
  int numeroDe(Parada parada) => _paradas.indexOf(parada) + 1;

  /// Marca la parada como entregada con los datos de quien recibió.
  void registrarEntrega(
    Parada parada, {
    required String dni,
    required String nombre,
    required String relacion,
    String observaciones = '',
  }) {
    parada.registro = RegistroNotificacion(
      fechaHora: DateTime.now(),
      dniReceptor: dni,
      nombreReceptor: nombre,
      relacionConDestinatario: relacion,
      observaciones: observaciones,
    );
    parada.estado = EstadoParada.entregada;
    notifyListeners();
  }

  /// Marca la parada como no notificada, indicando el motivo.
  void registrarNoNotificada(
    Parada parada, {
    required String motivo,
    String observaciones = '',
  }) {
    parada.registro = RegistroNotificacion(
      fechaHora: DateTime.now(),
      motivo: motivo,
      observaciones: observaciones,
    );
    parada.estado = EstadoParada.noNotificada;
    notifyListeners();
  }

  int _contar(EstadoParada estado) =>
      _paradas.where((p) => p.estado == estado).length;
}
