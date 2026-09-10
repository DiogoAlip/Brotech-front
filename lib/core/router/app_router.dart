import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/farm/presentation/screens/farm_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/consultas/presentation/screens/consultas_screen.dart';
import '../../features/shop/presentation/screens/shop_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../widgets/scaffold_with_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/finca',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Destination 0: Shop / Tienda
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tienda',
              builder: (context, state) => const ShopScreen(),
            ),
          ],
        ),

        // Destination 1: Calendar / Calendario
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendario',
              builder: (context, state) => const CalendarScreen(),
            ),
          ],
        ),

        // Destination 2: Farm / Finca (Middle)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/finca',
              builder: (context, state) => const FarmScreen(),
            ),
          ],
        ),

        // Destination 3: Consultas / Consultoría Integrada
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/consultas',
              builder: (context, state) => const ConsultasScreen(),
            ),
          ],
        ),

        // Destination 4: Profile / Perfil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/perfil',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
