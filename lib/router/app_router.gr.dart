// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    AnonymousRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AnonymousPage(),
      );
    },
    EmailLinkRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmailLinkPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        RouteConfig(
          AnonymousRoute.name,
          path: '/anonymous-page',
        ),
        RouteConfig(
          EmailLinkRoute.name,
          path: '/email-link-page',
        ),
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [AnonymousPage]
class AnonymousRoute extends PageRouteInfo<void> {
  const AnonymousRoute()
      : super(
          AnonymousRoute.name,
          path: '/anonymous-page',
        );

  static const String name = 'AnonymousRoute';
}

/// generated route for
/// [EmailLinkPage]
class EmailLinkRoute extends PageRouteInfo<void> {
  const EmailLinkRoute()
      : super(
          EmailLinkRoute.name,
          path: '/email-link-page',
        );

  static const String name = 'EmailLinkRoute';
}
