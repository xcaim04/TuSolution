# Tu Solution · Taller de reparaciones

App Android offline-first para gestionar un taller de reparación de equipos:
órdenes, asignación de técnicos, trabajos, repuestos, totales, historial e
inventario. Todo se guarda en SQLite en el dispositivo; no requiere login,
internet ni backend.

## stack

- Flutter 3.44 / Dart 3.12
- Drift 2.35 (SQLite + DAOs + migraciones)
- Riverpod 3 (providers, StreamNotifier y Notifier como ViewModels)
- MVVM: `lib/data` (persistencia), `lib/domain` (reglas), `lib/presentation` (UI)
- Material 3 con tema propio

## Ejecutar

```bash
flutter pub get
dart run build_runner build
flutter run
```

Para verificar:

```bash
flutter analyze
flutter test
flutter build apk --debug
```

El código generado (`*.g.dart`) ya está incluido; `build_runner` solo es
necesario si cambias tablas, DAOs o providers Drift.

## Funcionalidades

### Panel
- Métricas: órdenes abiertas, en reparación, listas y repuestos críticos.
- Carga de trabajo por técnico.
- Órdenes recientes y accesos rápidos por sección.

### Órdenes
- Alta con cliente existente o nuevo, equipo y falla reportada.
- Filtros por estado y técnico.
- Detalle con trabajos, repuestos, total en vivo y botones de acción.
- Cancelación con reglas de negocio.

### Inventario
- Alta, edición y eliminación de repuestos.
- Filtro de "solo críticos".
- Código único, precio y existencias.

### Historial
- Consulta por equipo o por cliente.
- Acceso directo a cada orden anterior.

## Decisiones de negocio

1. **Umbral de stock crítico:** `existencias <= 2` (`lib/core/constants.dart`).
2. **Asignación:** nadie asigna automáticamente. El usuario elige técnico al
   "tomar" una orden. La operación usa un `UPDATE` condicional dentro de una
   transacción, así dos técnicos no pueden tomar la misma orden.
3. **Precio congelado:** al usar un repuesto se guarda `precio_unitario` en
   `repuestos_usados`. Cambiar el precio del catálogo no altera órdenes
   anteriores.
4. **Total calculado:** `Σ costo mano de obra + Σ(cantidad × precio_unitario)`.
   No se persiste; siempre se deriva del detalle.
5. **Estados:** `recibida → en_reparacion → lista → entregada`, con
   `cancelada` permitida desde `recibida` o `en_reparacion`. En
   `en_reparacion`, cancelar solo funciona si aún no hay trabajos ni repuestos
   registrados.
6. **Modificaciones:** solo se pueden agregar trabajos/repuestos cuando la
   orden está `en_reparacion`.
7. **Datos demo:** la primera vez se insertan técnicos, clientes, equipos,
   órdenes y repuestos de ejemplo. El seed solo corre si no hay técnicos.

## Estructura

```
lib/
  app.dart                       Shell, navegación y arranque tras el seed
  main.dart                      ProviderScope + TuSolutionApp
  core/                          Constantes y formato de moneda/fechas
  data/
    tables.dart                  Tablas Drift
    dao.dart                     Consultas y streams
    database.dart                AppDatabase y migración v1
    repository_impl.dart         Transacciones y reglas
    seed.dart                    Datos demo
  domain/
    models.dart                  Modelos de UI desacoplados de Drift
    order_status.dart            Máquina de estados
    exceptions.dart              Errores de dominio
    repository.dart              Contrato del repositorio
  presentation/
    providers.dart               DB, repositorio y seed
    viewmodels/                  Estado de pantallas con Riverpod
    screens/                     Panel, órdenes, detalle, inventario, historial
    theme.dart / widgets.dart    Tema y componentes compartidos
test/
  repository_test.dart           Reglas transaccionales con DB en memoria
  widget_test.dart               Transiciones y smoke de UI
screenshots/                     Capturas reales de la app en Android
```

## Capturas

Las capturas se generan desde un emulador Android y se guardan en
`screenshots/`: panel, órdenes, detalle de orden, inventario e historial.

## Notas

- La app es completamente local: desinstalarla borra la base de datos.
- No hay autenticación; el responsable se elige explícitamente por orden.
- Los montos se muestran con `Q` (quetzales) como moneda de ejemplo.
