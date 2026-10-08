import '../models/parada.dart';

/// Diez paradas de PRUEBA en Lima. Los nombres, direcciones y carpetas
/// son inventados; las coordenadas son aproximadas.
///
/// Están desordenadas a propósito (saltan de un distrito a otro) para que en
/// el Paso 3 se note cuántos kilómetros ahorra el optimizador de ruta.
///
/// Cada llamada devuelve una lista nueva, así cada prueba empieza de cero.
List<Parada> paradasDemo() => [
  Parada(
    id: 'P01',
    carpetaFiscal: 'CF-2026-0101',
    destinatario: 'Juan Pérez Quispe',
    direccion: 'Av. Larco 600',
    distrito: 'Miraflores',
    latitud: -12.1250,
    longitud: -77.0300,
  ),
  Parada(
    id: 'P02',
    carpetaFiscal: 'CF-2026-0102',
    destinatario: 'María López Huamán',
    direccion: 'Av. Venezuela 900',
    distrito: 'Breña',
    latitud: -12.0560,
    longitud: -77.0520,
  ),
  Parada(
    id: 'P03',
    carpetaFiscal: 'CF-2026-0103',
    destinatario: 'Carlos Rojas Mendoza',
    direccion: 'Av. San Luis 2500',
    distrito: 'San Borja',
    latitud: -12.0990,
    longitud: -76.9990,
  ),
  Parada(
    id: 'P04',
    carpetaFiscal: 'CF-2026-0104',
    destinatario: 'Rosa Flores Chávez',
    direccion: 'Jr. Lampa 500',
    distrito: 'Cercado de Lima',
    latitud: -12.0510,
    longitud: -77.0340,
  ),
  Parada(
    id: 'P05',
    carpetaFiscal: 'CF-2026-0105',
    destinatario: 'Luis Torres Vargas',
    direccion: 'Av. República de Panamá 4500',
    distrito: 'Surquillo',
    latitud: -12.1120,
    longitud: -77.0180,
  ),
  Parada(
    id: 'P06',
    carpetaFiscal: 'CF-2026-0106',
    destinatario: 'Ana Gutiérrez Ramos',
    direccion: 'Av. Bolívar 1000',
    distrito: 'Pueblo Libre',
    latitud: -12.0750,
    longitud: -77.0630,
  ),
  Parada(
    id: 'P07',
    carpetaFiscal: 'CF-2026-0107',
    destinatario: 'Pedro Ramírez Salazar',
    direccion: 'Av. Canadá 1200',
    distrito: 'La Victoria',
    latitud: -12.0840,
    longitud: -77.0130,
  ),
  Parada(
    id: 'P08',
    carpetaFiscal: 'CF-2026-0108',
    destinatario: 'Elena Díaz Paredes',
    direccion: 'Av. Javier Prado Oeste 800',
    distrito: 'San Isidro',
    latitud: -12.0950,
    longitud: -77.0460,
  ),
  Parada(
    id: 'P09',
    carpetaFiscal: 'CF-2026-0109',
    destinatario: 'Jorge Sánchez Medina',
    direccion: 'Av. Brasil 1500',
    distrito: 'Jesús María',
    latitud: -12.0760,
    longitud: -77.0490,
  ),
  Parada(
    id: 'P10',
    carpetaFiscal: 'CF-2026-0110',
    destinatario: 'Lucía Morales Cruz',
    direccion: 'Av. Arequipa 2000',
    distrito: 'Lince',
    latitud: -12.0840,
    longitud: -77.0350,
  ),
];
