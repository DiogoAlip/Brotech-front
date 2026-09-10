# Brotec - Agronomic Seed Marketplace & Farm Management

Aplicación móvil y web en **Flutter** desarrollada con arquitectura **Feature-First Clean Architecture** siguiendo las especificaciones de diseño agronómico de **TerraSemillas / Brotec**.

## 🚀 Pila Tecnológica

- **Framework:** Flutter 3.x (Dart 3.x)
- **Gestor de Estado:** [Riverpod](https://riverpod.dev/) (`flutter_riverpod`)
- **Enrutamiento:** [GoRouter](https://pub.dev/packages/go_router) con `StatefulShellRoute.indexedStack`
- **Sistema de Diseño:** Material Design 3 corporativo basado en los tokens de `stitch_agronomic_seed_marketplace/terrasemillas/DESIGN.md`
- **Tipografía:** Domine (títulos y marcas editoriales) y Manrope (métricas analíticas y lectura de datos) mediante `google_fonts`

---

## 📱 Rutas y Vistas

La aplicación implementa las 5 vistas completas del marketplace y gestión agronómica:

| Destino | Ruta | Icono | Descripción |
| :--- | :--- | :--- | :--- |
| **Finca** | `/finca` | `inventory_2` | Registro catastral de parcelas, cálculo dinámico Ha/Acres, ortofoto satelital HD y telemetría de suelo. |
| **Calendario** | `/calendario` | `calendar_today` | Calendario agronómico mensual interactivo, selector Mes/Semana, agenda de labores (siembra, fertirrigación, ensayos ISTA) y bitácoras de campo. |
| **Chatbot** | `/chatbot` | `smart_toy` | Copiloto IA agronómico con análisis de sensores en tiempo real, fichas botánicas enriquecidas y programación de tareas. |
| **Tienda** | `/tienda` | `shopping_cart` (Badge: 3) | Marketplace de semillas certificadas de alto vigor, filtros por categorías biológicas y banners de temporada. |
| **Perfil** | `/perfil` | `person` | Credenciales de agrónomo certificado, bento grid de métricas clave (Ha, ISTA, IoT) y configuración. |

---

## 🎨 Header y Barra de Navegación Compartida

Basada fielmente en `@stitch_agronomic_seed_marketplace/calendario_agron_mico`:
- **Header Superior (`AppHeader`):**
  - Logotipo oficial de Brotec (`assets/images/brotec_title_logo.png`).
  - Botón de notificaciones con punto indicador de alertas agronómicas.
  - Botón de configuración del sistema.
- **Barra de Navegación Inferior (`AppBottomNavBar`):**
  - **Detección de ruta activa en verde:** La ruta seleccionada resalta con el icono relleno, color verde esmeralda botánico (`#006B54`), etiqueta en negrita y un indicador de punto activo verde.
  - Las rutas inactivas se muestran en tono gris/pizarra (`#78716C`).
  - Badge numérico en la pestaña de **Tienda**.

---

## 📂 Estructura del Proyecto

```text
client/
├── assets/
│   └── images/
│       ├── brotec_logo.png
│       ├── brotec_title_logo.png
│       └── farm_landscape.png
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   ├── theme/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_typography.dart
│   │   │   └── app_theme.dart
│   │   └── widgets/
│   │       ├── app_header.dart
│   │       ├── app_bottom_nav_bar.dart
│   │       └── scaffold_with_nav_bar.dart
│   └── features/
│       ├── farm/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── calendar/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── chatbot/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── shop/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       └── profile/
│           ├── data/
│           ├── domain/
│           └── presentation/
├── pubspec.yaml
├── analysis_options.yaml
└── test/
    └── widget_test.dart
```

---

## 🛠️ Ejecución y Pruebas

Para instalar dependencias y ejecutar la aplicación:

```bash
# Obtener paquetes
flutter pub get

# Ejecutar pruebas unitarias y de widgets
flutter test

# Ejecutar la aplicación en Chrome o emulador
flutter run -d chrome
```
