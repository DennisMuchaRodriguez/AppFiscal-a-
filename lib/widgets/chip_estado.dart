import 'package:flutter/material.dart';

import '../models/parada.dart';

/// Etiqueta de color que muestra el estado de una parada.
class ChipEstado extends StatelessWidget {
  const ChipEstado({super.key, required this.estado});

  final EstadoParada estado;

  @override
  Widget build(BuildContext context) {
    final (fondo, texto, icono) = switch (estado) {
      EstadoParada.pendiente => (
        Colors.amber.shade100,
        Colors.brown.shade800,
        Icons.schedule,
      ),
      EstadoParada.entregada => (
        Colors.green.shade100,
        Colors.green.shade900,
        Icons.check_circle,
      ),
      EstadoParada.noNotificada => (
        Colors.red.shade100,
        Colors.red.shade900,
        Icons.cancel,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 14, color: texto),
          const SizedBox(width: 4),
          Text(
            estado.etiqueta,
            style: TextStyle(
              color: texto,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
