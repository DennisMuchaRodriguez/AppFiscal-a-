# Paso 1: esqueleto de la app

## Qué incluye

- **Inicio:** fecha de hoy, avance del día (cuántas paradas se atendieron) y acceso a los dos módulos.
- **Módulo 1: Ruta del día:** 10 paradas de prueba en Lima, numeradas, cada una con su estado (Pendiente, Entregada o No notificada).
- **Módulo 2: Registrar notificación:** formulario con DNI (solo acepta 8 números), nombre de quien recibe, relación con el destinatario y observaciones. También tiene la opción "No se pudo notificar", con motivo.
- Todo en español.

## Lo que todavía NO hace (es normal)

- No toma fotos ni usa el GPS (Paso 2).
- No muestra mapa ni optimiza la ruta (Paso 3).
- No guarda nada: al cerrar la app, todo vuelve a empezar (Paso 4).

## Lista de pruebas

Marca cada punto cuando lo compruebes. Si algo no coincide, avísame con el número del punto.

- [ ] 1. Al abrir la app, el inicio muestra la fecha de hoy en español, "0 de 10 paradas atendidas" y los dos módulos.
- [ ] 2. Al tocar **Módulo 1**, aparecen 10 paradas numeradas y todas dicen "Pendiente".
- [ ] 3. Al tocar **Optimizar ruta**, sale abajo un mensaje que dice que se activa en el Paso 3.
- [ ] 4. Al tocar la parada 1, se abre el formulario con esa parada arriba.
- [ ] 5. Si tocas **Registrar notificación** con el formulario vacío, salen mensajes en rojo debajo de los campos y no se registra nada.
- [ ] 6. En el DNI no se pueden escribir letras ni más de 8 números. Si pones solo 7 números y tocas **Registrar notificación**, sale "El DNI debe tener 8 dígitos".
- [ ] 7. Con DNI, nombre y relación completos, al registrar sale un aviso verde con la hora. Al presionar **Aceptar** vuelves a la ruta y la parada 1 dice "Entregada" en verde.
- [ ] 8. Al tocar la parada 1 (ya entregada), se abre un panel abajo con lo que se registró.
- [ ] 9. En la parada 2, toca **No se pudo notificar** y elige "Destinatario ausente". Vuelves a la ruta y la parada 2 dice "No notificada" en rojo.
- [ ] 10. De vuelta en el inicio dice "2 de 10 paradas atendidas", la barra avanzó y los contadores cambiaron.
- [ ] 11. Al entrar al **Módulo 2** desde el inicio, la lista "Elige la parada" ya no muestra las paradas 1 y 2.
- [ ] 12. Cuando atiendes las 10 paradas, el **Módulo 2** muestra "¡Ruta completa!".
- [ ] 13. Si cierras y vuelves a abrir la app, todo vuelve a 0. Eso es lo esperado por ahora.

## Preguntas para ti antes del Paso 2

1. ¿Solo se registra **DNI**, o también **Carné de Extranjería** o **Pasaporte**? En Lima hay muchos destinatarios extranjeros.
2. ¿Las opciones de **Relación** (titular, familiar, trabajador del hogar, portero) y de **Motivos** (ausente, dirección no encontrada, se negó a recibir) son las que usan en el Ministerio Público? ¿Falta alguna?
3. ¿Tienes un **celular Android** para las pruebas? El Paso 2 (cámara y GPS) lo necesita.
