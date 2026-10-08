import 'package:flutter/material.dart';

import '../models/parada.dart';
import '../services/ruta_del_dia.dart';
import '../utils/formato_fecha.dart';
import '../widgets/tarjeta_parada.dart';
import 'pantalla_registro.dart';

/// MÓDULO 1: lista de paradas del día, en orden de visita.
class PantallaRuta extends StatelessWidget {
  const PantallaRuta({super.key, required this.ruta});

  final RutaDelDia ruta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta del día')),
      body: ListenableBuilder(
        listenable: ruta,
        builder: (context, _) {
          final paradas = ruta.paradas;
          return ListView.builder(
            // Espacio extra abajo para que el botón flotante no tape la última parada.
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
            itemCount: paradas.length,
            itemBuilder: (context, i) => TarjetaParada(
              parada: paradas[i],
              numero: i + 1,
              alPresionar: () => _abrirParada(context, paradas[i]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'La optimización de ruta (mapa + OSRM) se activa en el Paso 3.',
            ),
          ),
        ),
        icon: const Icon(Icons.auto_fix_high),
        label: const Text('Optimizar ruta'),
      ),
    );
  }

  /// Si la parada está pendiente, abre el formulario de registro.
  /// Si ya se atendió, muestra lo que se registró.
  void _abrirParada(BuildContext context, Parada parada) {
    if (parada.estado == EstadoParada.pendiente) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PantallaRegistro(ruta: ruta, parada: parada),
        ),
      );
    } else {
      showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (_) => _DetalleRegistro(parada: parada),
      );
    }
  }
}

/// Panel inferior con los datos registrados en una parada ya atendida.
class _DetalleRegistro extends StatelessWidget {
  const _DetalleRegistro({required this.parada});

  final Parada parada;

  @override
  Widget build(BuildContext context) {
    final registro = parada.registro!;
    final textos = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(parada.destinatario, style: textos.titleLarge),
            Text('${parada.direccion}, ${parada.distrito}'),
            const Divider(height: 24),
            _fila('Resultado', parada.estado.etiqueta),
            _fila('Fecha y hora', fechaHora(registro.fechaHora)),
            if (registro.fueEntregada) ...[
              _fila('Recibió', registro.nombreReceptor!),
              _fila('DNI', registro.dniReceptor!),
              _fila('Relación', registro.relacionConDestinatario!),
            ] else
              _fila('Motivo', registro.motivo!),
            if (registro.observaciones.isNotEmpty)
              _fila('Observaciones', registro.observaciones),
          ],
        ),
      ),
    );
  }

  Widget _fila(String etiqueta, String valor) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            etiqueta,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(child: Text(valor)),
      ],
    ),
  );
}
