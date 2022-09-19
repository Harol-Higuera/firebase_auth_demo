import 'package:fir_auth_demo/services/dynamic_links_service.dart';
import 'package:riverpod/riverpod.dart';

final dynamicLinksServiceProvider =
    Provider<DynamicLinksService>((ref) => DynamicLinksService(
          ref,
        ));
