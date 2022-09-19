import 'package:fir_auth_demo/enums/dynamic_link_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicLinksService {
  late FirebaseDynamicLinks firebaseDynamicLinks;
  final Ref reader;
  bool _hasShownInitialLink = false;
  var auth = FirebaseAuth.instance;

  DynamicLinksService(this.reader) {
    firebaseDynamicLinks = FirebaseDynamicLinks.instance;
    _startListeningDynamicLinks();
  }

  /// ::: Starts Listening to Dynamic Links
  /// Used when the app is opened by a Dynamic Link and the app is running
  /// in the background
  ///
  void _startListeningDynamicLinks() {
    try {
      firebaseDynamicLinks.onLink.listen((dynamicLinkData) {
        final deepLink = dynamicLinkData.link;
        handleLink(deepLink);
      }).onError((error) {
        print('Dynamic Links Listener Error: ${error.toString()}');
      });
    } catch (e) {
      print('Dynamic Links Listener initializer Error: ${e.toString()}');
    }
  }

  /// ::: Retrieve initial Link
  /// Used when the app is opened by a Dynamic Link
  ///
  Future<void> retrieveInitialLink() async {
    if (_hasShownInitialLink) {
      return;
    }
    var data = await firebaseDynamicLinks.getInitialLink();
    final uri = data?.link;
    if (uri != null) {
      handleLink(uri);
    }
    _hasShownInitialLink = true;
  }

  void handleLink(Uri link) async {
    if (auth.isSignInWithEmailLink(link.toString())) {
      final prefs = await SharedPreferences.getInstance();
      final emailAddress = prefs.getString('email_address');
      if (emailAddress != null) {
        print('Harol...LINK EXISTS!!');
        if (link.toString().contains(DynamicLinkType.emailLink.subDomain)) {
          /// CASE: Email Link
          ///
          auth
              .signInWithEmailLink(
                  email: emailAddress, emailLink: link.toString())
              .then((_) {})
              .catchError((onError) {
            print('Harol..Error signing in with email link $onError');
          });
        } else {
          /// CASE: Anonymous
          ///
        }
      } else {
        print('Harol...LINK DOES NOT EXISTS!!');
      }
    }
  }
}
