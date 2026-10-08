import 'package:flutter/material.dart';

import '../models/parada.dart';
import 'chip_estado.dart';

/// Tarjeta con los datos de una parada: número, destinatario, dirección,
/// carpeta fiscal y estado. Se usa en la lista de la ruta y en el registro.
class TarjetaParada extends StatelessWidget {
  const TarjetaParada({
    super.key,
    required this.parada,
    required this.numero,
    this.alPresionar,
  });

  final Parada parada;
  final int numero;

  /// Qué hacer al tocar la tarjeta (null = no se puede tocar).
  final VoidCallback? alPresionar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: alPresionar,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: colores.primary,
                foregroundColor: colores.onPrimary,
                child: Text('$numero'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parada.destinatario, style: textos.titleMedium),
                    const SizedBox(height: 2),
                    Text('${parada.direccion}, ${parada.distrito}'),
                    const SizedBox(height: 2),
                    Text(
                      'Carpeta: ${parada.carpetaFiscal}',
                      style: textos.bodySmall?.copyWith(
                        color: colores.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ChipEstado(estado: parada.estado),
                  ],
                ),
              ),
              if (alPresionar != null)
                Icon(Icons.chevron_right, color: colores.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
