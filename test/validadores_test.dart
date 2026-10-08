import 'package:app_fiscal/utils/validadores.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validarDni', () {
    test('acepta 8 dígitos', () {
      expect(validarDni('12345678'), isNull);
      expect(validarDni(' 12345678 '), isNull);
    });

    test('rechaza vacío, cortos, largos y letras', () {
      expect(validarDni(''), isNotNull);
      expect(validarDni(null), isNotNull);
      expect(validarDni('1234567'), isNotNull);
      expect(validarDni('123456789'), isNotNull);
      expect(validarDni('1234567a'), isNotNull);
    });
  });

  group('validarNombre', () {
    test('acepta un nombre normal', () {
      expect(validarNombre('Juan Pérez'), isNull);
    });

    test('rechaza vacío o muy corto', () {
      expect(validarNombre('  '), isNotNull);
      expect(validarNombre('Jo'), isNotNull);
    });
  });
}
