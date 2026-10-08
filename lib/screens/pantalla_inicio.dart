import 'package:flutter/material.dart';

import '../services/ruta_del_dia.dart';
import '../utils/formato_fecha.dart';
import 'pantalla_registro.dart';
import 'pantalla_ruta.dart';

/// Primera pantalla: resumen del día y acceso a los dos módulos.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key, required this.ruta});

  final RutaDelDia ruta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppFiscal')),
      body: ListenableBuilder(
        listenable: ruta,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ResumenDelDia(ruta: ruta),
            const SizedBox(height: 16),
            _TarjetaModulo(
              numero: 1,
              titulo: 'Ruta del día',
              descripcion:
                  'Ver las paradas de hoy en orden de visita. '
                  'El botón "Optimizar ruta" se activa en el Paso 3.',
              icono: Icons.alt_route,
              alPresionar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PantallaRuta(ruta: ruta)),
              ),
            ),
            const SizedBox(height: 12),
            _TarjetaModulo(
              numero: 2,
              titulo: 'Registrar notificación',
              descripcion:
                  'Registrar la entrega con el DNI y nombre de quien recibe. '
                  'La foto y el GPS se activan en el Paso 2.',
              icono: Icons.assignment_turned_in_outlined,
              alPresionar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PantallaRegistro(ruta: ruta)),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Prototipo con datos de prueba. Todavía no se guarda ni se envía '
              'nada a internet: al cerrar la app, todo vuelve a empezar.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta superior con la fecha y el avance del día.
class _ResumenDelDia extends StatelessWidget {
  const _ResumenDelDia({required this.ruta});

  final RutaDelDia ruta;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;
    final avance = ruta.total == 0 ? 0.0 : ruta.atendidas / ruta.total;

    return Card(
      color: colores.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hoy, ${fechaLarga(DateTime.now())}',
              style: textos.bodyMedium?.copyWith(
                color: colores.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${ruta.atendidas} de ${ruta.total} paradas atendidas',
              style: textos.titleLarge?.copyWith(
                color: colores.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: avance, minHeight: 8),
            ),
            const SizedBox(height: 12),
            Text(
              'Entregadas: ${ruta.entregadas}   ·   '
              'No notificadas: ${ruta.noNotificadas}   ·   '
              'Pendientes: ${ruta.pendientes.length}',
              style: textos.bodySmall?.copyWith(
                color: colores.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Botón grande para entrar a un módulo.
class _TarjetaModulo extends StatelessWidget {
  const _TarjetaModulo({
    required this.numero,
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.alPresionar,
  });

  final int numero;
  final String titulo;
  final String descripcion;
  final IconData icono;
  final VoidCallback alPresionar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: alPresionar,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icono, size: 40, color: colores.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MÓDULO $numero',
                      style: textos.labelSmall?.copyWith(
                        color: colores.primary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(titulo, style: textos.titleMedium),
                    const SizedBox(height: 4),
                    Text(descripcion, style: textos.bodySmall),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colores.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
