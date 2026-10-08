import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/paradas_demo.dart';
import 'screens/pantalla_inicio.dart';
import 'services/ruta_del_dia.dart';

/// Punto de entrada: Flutter empieza a ejecutar la app desde aquí.
void main() {
  runApp(AppFiscal(ruta: RutaDelDia(paradasDemo())));
}

/// Widget raíz de la app: define el nombre, los colores, el idioma
/// y cuál es la primera pantalla.
class AppFiscal extends StatelessWidget {
  const AppFiscal({super.key, required this.ruta});

  /// Las paradas del día y lo que se va registrando en cada una.
  /// Por ahora vive solo en la memoria del celular (Firebase llega en el Paso 4).
  final RutaDelDia ruta;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppFiscal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Azul marino como color base; Flutter genera el resto de tonos.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F3A5F)),
      ),
      // Español de Perú para los textos internos de Flutter.
      locale: const Locale('es', 'PE'),
      supportedLocales: const [Locale('es', 'PE')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: PantallaInicio(ruta: ruta),
    );
  }
}
