import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fir_auth_demo/screens/anonymous/anonymous_page.dart';
import 'package:fir_auth_demo/screens/email_link/email_link_page.dart';
import 'package:fir_auth_demo/screens/home/home_page.dart';
import 'package:flutter/widgets.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: AnonymousPage),
    AutoRoute(page: EmailLinkPage),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
