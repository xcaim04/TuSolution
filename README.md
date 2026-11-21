# Tu Solution

[![Flutter CI](https://github.com/xcaim04/TuSolution/actions/workflows/flutter.yml/badge.svg)](https://github.com/xcaim04/TuSolution/actions/workflows/flutter.yml)

Aplicación Android para gestionar un taller de reparación de equipos: órdenes,
asignación de técnicos, trabajos, repuestos, totales, historial e inventario.
Funciona completamente offline: la información se guarda en SQLite en el
dispositivo y no necesita usuario, contraseña ni servidor.

## Contenido

- [Stack](#stack)
- [Puesta en marcha](#puesta-en-marcha)
- [CI y artefactos](#ci-y-artefactos)
- [Funcionalidades](#funcionalidades)
- [Reglas de negocio](#reglas-de-negocio)
- [Datos de ejemplo](#datos-de-ejemplo)
- [Arquitectura](#arquitectura)
- [Pruebas](#pruebas)
- [Capturas](#capturas)
- [Solución de problemas](#solución-de-problemas)

## Stack

- **Flutter 3.44.9** / **Dart 3.12.2**
- **Drift 2.35** para SQLite, DAOs y migraciones
- **Riverpod 3** para providers y ViewModels
- **MVVM** con separación clara entre persistencia, dominio y presentación
- **Material 3** con tema visual propio (teal/ámbar)

## Puesta en marcha

Requisitos: Flutter 3.44.9, Dart 3.12.2, JDK 17 y Android SDK.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

El código generado por Drift (`lib/data/*.g.dart`) ya está versionado. Solo es
necesario regenerarlo si cambias tablas o DAOs.

Verificación local completa:

```bash
flutter analyze
flutter test
flutter build apk --debug
flutter build apk --release
```

## CI y artefactos

El workflow [`.github/workflows/flutter.yml`](.github/workflows/flutter.yml) se
ejecuta en cada push y pull request a `main`. Hace lo siguiente:

1. Instala Flutter 3.44.9 y JDK 17.
2. Restaura dependencias Dart y caché de Gradle.
3. Regenera el código Drift.
4. Ejecuta `flutter analyze` y `flutter test`.
5. Compila APKs debug y release.
6. Publica ambos APKs como artefactos de GitHub Actions.

Puedes descargar los artefactos desde la pestaña **Actions** del repositorio o
disparar el workflow manualmente con **Run workflow**.

## Funcionalidades

### Panel

- Métricas de órdenes abiertas, en reparación, listas y repuestos críticos.
- Distribución de carga por técnico.
- Órdenes recientes con acceso directo al detalle.

### Órdenes

- Alta de órdenes con cliente existente o nuevo, equipo y falla reportada.
- Filtros por estado y técnico.
- Detalle con trabajos, repuestos, responsable y total en vivo.
- Acciones: tomar orden, cambiar estado, cancelar, agregar trabajos y repuestos.

### Inventario

- Alta, edición y eliminación de repuestos.
- Control de existencias, precio y código único.
- Filtro rápido de repuestos críticos.

### Historial

- Consulta de órdenes por equipo o por cliente.
- Acceso directo a cualquier orden anterior.

## Reglas de negocio

1. **Stock crítico:** `existencias <= 2`.
2. **Asignación explícita:** ninguna orden se asigna automáticamente. Al tomar
   una orden se elige técnico y se ejecuta un `UPDATE` condicional dentro de
   una transacción, evitando asignaciones dobles.
3. **Precio congelado:** al consumir un repuesto se guarda su precio unitario
   en `repuestos_usados`. Cambiar el catálogo no modifica órdenes anteriores.
4. **Total derivado:** `Σ trabajo + Σ(cantidad × precio unitario)`. Nunca se
   persiste; siempre se calcula desde el detalle.
5. **Estados:** `recibida → en_reparacion → lista → entregada`. `cancelada` es
   válida desde `recibida` o `en_reparacion`, pero en `en_reparacion` solo si
   aún no hay trabajos ni repuestos registrados.
6. **Modificaciones:** trabajos y repuestos solo se pueden agregar mientras la
   orden está `en_reparacion`.

## Datos de ejemplo

El primer arranque inserta técnicos, clientes, equipos, órdenes y repuestos de
demostración. El seed se ejecuta únicamente cuando no hay técnicos guardados,
así que tus cambios posteriores no se sobrescriben.

## Arquitectura

```
lib/
  app.dart                       Shell, navegación y arranque
  main.dart                      ProviderScope + TuSolutionApp
  core/                          Constantes y formato de moneda/fechas
  data/
    tables.dart                  Tablas Drift
    dao.dart                     Consultas reactivas y joins
    database.dart                AppDatabase y migración v1
    repository_impl.dart         Transacciones y reglas críticas
    seed.dart                    Datos de demostración
  domain/
    models.dart                  Modelos consumidos por la UI
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
  widget_test.dart               Transiciones de estado y smoke de UI
```

## Pruebas

- `test/repository_test.dart` valida creación de órdenes, asignación atómica,
  precios congelados, cancelación restringida, stock insuficiente y
  transiciones inválidas.
- `test/widget_test.dart` cubre la máquina de estados y el renderizado de
  etiquetas de estado.

```bash
flutter test
```

## Capturas

Las capturas de la aplicación se guardan en [`screenshots/`](screenshots/):
panel, órdenes, detalle de orden, inventario e historial. Para generarlas,
ejecuta la app en un emulador o dispositivo Android y toma una captura por
pantalla en cada sección.

## Solución de problemas

- **Error de Gradle con repositorios globales:** si tu `~/.gradle/init.gradle`
  agrega repositorios con `allprojects`, Gradle 9 puede rechazarlos. Usa un
  `GRADLE_USER_HOME` aislado para este proyecto o elimina esa configuración
  global.
- **Artefactos del motor Flutter no encontrados:** errores como
  `Could not find io.flutter:flutter_embedding_debug` indican que faltan los
  repositorios `https://storage.googleapis.com/download.flutter.io` y
  `https://storage.flutter-io.cn/download.flutter.io` en
  `android/settings.gradle.kts`.
- **Código Drift desactualizado:** ejecuta
  `dart run build_runner build --delete-conflicting-outputs`.
- **APK en CI:** revisa los artefactos del workflow; no es necesario compilar
  localmente si tu entorno tiene limitaciones de red o Android SDK.
