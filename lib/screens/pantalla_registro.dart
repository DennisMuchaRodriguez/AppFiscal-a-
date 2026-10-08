import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/parada.dart';
import '../models/registro_notificacion.dart';
import '../services/ruta_del_dia.dart';
import '../utils/formato_fecha.dart';
import '../utils/validadores.dart';
import '../widgets/tarjeta_parada.dart';

/// MÓDULO 2: formulario para registrar una notificación.
///
/// Si se abre desde la ruta, la [parada] ya viene elegida.
/// Si se abre desde el inicio, el notificador la elige de una lista.
class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key, required this.ruta, this.parada});

  final RutaDelDia ruta;
  final Parada? parada;

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  // La "llave" del formulario permite validar todos los campos a la vez.
  final _formulario = GlobalKey<FormState>();

  // Los "controllers" guardan lo que se escribe en cada caja de texto.
  final _dni = TextEditingController();
  final _nombre = TextEditingController();
  final _observaciones = TextEditingController();

  Parada? _parada;
  String? _relacion;

  @override
  void initState() {
    super.initState();
    _parada = widget.parada;
  }

  @override
  void dispose() {
    _dni.dispose();
    _nombre.dispose();
    _observaciones.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendientes = widget.ruta.pendientes;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar notificación')),
      body: (widget.parada == null && pendientes.isEmpty)
          ? const _SinPendientes()
          : Form(
              key: _formulario,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _Titulo('1. Parada'),
                  if (widget.parada != null)
                    TarjetaParada(
                      parada: widget.parada!,
                      numero: widget.ruta.numeroDe(widget.parada!),
                    )
                  else
                    DropdownButtonFormField<Parada>(
                      initialValue: _parada,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Elige la parada',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (final p in pendientes)
                          DropdownMenuItem(
                            value: p,
                            child: Text(
                              '${widget.ruta.numeroDe(p)}. ${p.destinatario} '
                              '(${p.distrito})',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (p) => setState(() => _parada = p),
                      validator: (p) => p == null ? 'Elige una parada' : null,
                    ),
                  const SizedBox(height: 24),
                  _Titulo('2. ¿Quién recibe?'),
                  TextFormField(
                    controller: _dni,
                    decoration: const InputDecoration(
                      labelText: 'DNI de quien recibe',
                      prefixIcon: Icon(Icons.badge_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    // Solo deja escribir números, máximo 8.
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                    ],
                    validator: validarDni,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nombre,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo de quien recibe',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: validarNombre,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _relacion,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Relación con el destinatario',
                      prefixIcon: Icon(Icons.people_outline),
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (final r in relacionesConDestinatario)
                        DropdownMenuItem(value: r, child: Text(r)),
                    ],
                    onChanged: (r) => setState(() => _relacion = r),
                    validator: (r) => r == null ? 'Elige una opción' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _observaciones,
                    decoration: const InputDecoration(
                      labelText: 'Observaciones (opcional)',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  _Titulo('3. Evidencias'),
                  const _EvidenciaPendiente(
                    icono: Icons.photo_camera_outlined,
                    texto: 'Foto del cargo firmado',
                  ),
                  const _EvidenciaPendiente(
                    icono: Icons.my_location,
                    texto: 'Ubicación GPS',
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _registrarEntrega,
                    icon: const Icon(Icons.check),
                    label: const Text('Registrar notificación'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _registrarNoNotificada,
                    icon: const Icon(Icons.block),
                    label: const Text('No se pudo notificar'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _registrarEntrega() async {
    // validate() revisa todos los campos y muestra los errores en rojo.
    if (!_formulario.currentState!.validate()) return;

    final parada = _parada!;
    widget.ruta.registrarEntrega(
      parada,
      dni: _dni.text.trim(),
      nombre: _nombre.text.trim(),
      relacion: _relacion!,
      observaciones: _observaciones.text.trim(),
    );

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Notificación registrada'),
        content: Text(
          'Parada: ${parada.destinatario}\n'
          'Recibió: ${_nombre.text.trim()}\n'
          'DNI: ${_dni.text.trim()}\n'
          'Hora: ${hora(parada.registro!.fechaHora)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );

    // Después de cerrar el aviso, volvemos a la pantalla anterior.
    if (mounted) Navigator.pop(context);
  }

  Future<void> _registrarNoNotificada() async {
    final parada = _parada;
    if (parada == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Primero elige la parada.')));
      return;
    }

    final motivo = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('¿Por qué no se pudo notificar?'),
        children: [
          for (final m in motivosNoNotificada)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, m),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(m),
              ),
            ),
        ],
      ),
    );
    if (motivo == null || !mounted) return; // Cerró el diálogo sin elegir.

    widget.ruta.registrarNoNotificada(
      parada,
      motivo: motivo,
      observaciones: _observaciones.text.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Parada marcada como no notificada: $motivo')),
    );
    Navigator.pop(context);
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(texto, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// Fila gris que indica que esta evidencia todavía no está disponible.
class _EvidenciaPendiente extends StatelessWidget {
  const _EvidenciaPendiente({required this.icono, required this.texto});

  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: ListTile(
        enabled: false,
        leading: Icon(icono),
        title: Text(texto),
        subtitle: const Text('Se activa en el Paso 2'),
      ),
    );
  }
}

/// Se muestra cuando ya no queda ninguna parada por atender.
class _SinPendientes extends StatelessWidget {
  const _SinPendientes();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              '¡Ruta completa! No quedan paradas pendientes.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
