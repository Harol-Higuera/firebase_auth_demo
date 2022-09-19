import 'package:auto_route/auto_route.dart';
import 'package:fir_auth_demo/providers/dynamic_links_service_provider.dart';
import 'package:fir_auth_demo/router/app_router.dart';
import 'package:fir_auth_demo/styles/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(dynamicLinksServiceProvider).retrieveInitialLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Auth Demo'),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                AutoRouter.of(context).push(
                  const EmailLinkRoute(),
                );
              },
              child: const Text('Email Link'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                AutoRouter.of(context).push(
                  const AnonymousRoute(),
                );
              },
              child: const Text('Anonymous'),
            ),
          ],
        ),
      ),
    );
  }
}
