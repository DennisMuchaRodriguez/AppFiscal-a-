import 'package:app_fiscal/data/paradas_demo.dart';
import 'package:app_fiscal/main.dart';
import 'package:app_fiscal/services/ruta_del_dia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RutaDelDia ruta;

  Future<void> abrirApp(WidgetTester tester) async {
    // Pantalla del tamaño de un celular.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    ruta = RutaDelDia(paradasDemo());
    await tester.pumpWidget(AppFiscal(ruta: ruta));
  }

  /// Desplaza la pantalla hasta que [objetivo] se vea
  /// (paso positivo = hacia abajo, negativo = hacia arriba).
  Future<void> desplazarHasta(
    WidgetTester tester,
    Finder objetivo, {
    double paso = 200,
  }) => tester.scrollUntilVisible(
    objetivo,
    paso,
    scrollable: find.byType(Scrollable).first,
  );

  // El botón verde de registrar (el título de la pantalla tiene el mismo texto).
  final botonRegistrar = find.byIcon(Icons.check);

  testWidgets('el inicio muestra el resumen y los dos módulos', (tester) async {
    await abrirApp(tester);

    expect(find.text('0 de 10 paradas atendidas'), findsOneWidget);
    expect(find.text('Ruta del día'), findsOneWidget);
    expect(find.text('Registrar notificación'), findsOneWidget);
  });

  testWidgets('registrar una entrega desde la ruta la marca como entregada', (
    tester,
  ) async {
    await abrirApp(tester);

    await tester.tap(find.text('Ruta del día'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Juan Pérez Quispe'));
    await tester.pumpAndSettle();

    // Sin datos, el formulario no deja registrar.
    await desplazarHasta(tester, botonRegistrar);
    await tester.tap(botonRegistrar);
    await tester.pumpAndSettle();
    expect(find.text('Notificación registrada'), findsNothing);
    await desplazarHasta(
      tester,
      find.text('Ingresa el DNI de quien recibe'),
      paso: -200,
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'DNI de quien recibe'),
      '12345678',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nombre completo de quien recibe'),
      'Juan Pérez Quispe',
    );
    await desplazarHasta(tester, find.text('Relación con el destinatario'));
    await tester.tap(find.text('Relación con el destinatario'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('El mismo destinatario').last);
    await tester.pumpAndSettle();

    await desplazarHasta(tester, botonRegistrar);
    await tester.tap(botonRegistrar);
    await tester.pumpAndSettle();
    expect(find.text('Notificación registrada'), findsOneWidget);

    await tester.tap(find.text('Aceptar'));
    await tester.pumpAndSettle();

    // De vuelta en la ruta, la primera parada aparece como entregada.
    expect(find.text('Entregada'), findsOneWidget);
    expect(ruta.entregadas, 1);
    expect(ruta.paradas.first.registro!.dniReceptor, '12345678');
  });

  testWidgets('"No se pudo notificar" guarda el motivo', (tester) async {
    await abrirApp(tester);

    await tester.tap(find.text('Registrar notificación'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Elige la parada'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2. María López Huamán (Breña)').last);
    await tester.pumpAndSettle();

    await desplazarHasta(tester, find.text('No se pudo notificar'));
    await tester.tap(find.text('No se pudo notificar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Destinatario ausente'));
    await tester.pumpAndSettle();

    expect(find.text('1 de 10 paradas atendidas'), findsOneWidget);
    expect(ruta.noNotificadas, 1);
    expect(ruta.paradas[1].registro!.motivo, 'Destinatario ausente');
  });
}
