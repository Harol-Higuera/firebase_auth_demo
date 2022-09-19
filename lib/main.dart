import 'package:fir_auth_demo/Constants.dart';
import 'package:fir_auth_demo/extensions/string+extension.dart';
import 'package:fir_auth_demo/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String? _emailAddress;
  String _entryEmailAddress = '';
  bool _isUserLoggedIn = false;
  var dynamicLinks = FirebaseDynamicLinks.instance;
  var auth = FirebaseAuth.instance;
  final myController = TextEditingController();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  /// 1::::::: SEND EMAIL TO AUTHENTICATE
  ///
  ///
  var acs = ActionCodeSettings(
      url: 'https://harol.page.link',
      handleCodeInApp: true,
      iOSBundleId: 'com.harol.fir.auth.demo',
      androidPackageName: 'com.harol.fir.auth.demo',
      androidInstallApp: true,
      androidMinimumVersion: '12');

  void sendEmailToAuthenticate() {
    auth
        .sendSignInLinkToEmail(
          email: _entryEmailAddress,
          actionCodeSettings: acs,
        )
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then(
      (value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(sharedPrefsPendingEmail, _entryEmailAddress);
        setState(() {
          _emailAddress = _entryEmailAddress;
          _entryEmailAddress = '';
        });
        myController.clear();
      },
    );
  }

  /// 2::::::: RECEIVE LINK TO AUTHENTICATE
  ///
  ///
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('Harol.....didChangeAppLifecycleState... ${state.toString()}');
    if (state == AppLifecycleState.resumed) {
      print('Harol.....resumed');
      checkIfPendingLinks();
    }
  }

  void checkIfPendingLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final link = data?.link;
    if (link != null) {
      handleLink(link);
    }
  }

  void handleLink(Uri link) async {
    if (auth.isSignInWithEmailLink(link.toString())) {
      final prefs = await SharedPreferences.getInstance();
      final emailAddress = prefs.getString(sharedPrefsPendingEmail);
      if (emailAddress != null) {
        print('Harol...LINK EXISTS!!');
        auth
            .signInWithEmailLink(
                email: emailAddress, emailLink: link.toString())
            .then((_) {})
            .catchError((onError) {
          print('Harol..Error signing in with email link $onError');
        });
      } else {
        print('Harol...LINK DOES NOT EXISTS!!');
      }
    }
  }

  void _readPendingEmailAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailAddress = prefs.getString('email_address');
    });
  }

  void _subscribeForAuthState() {
    auth.authStateChanges().listen((User? user) async {
      final email = user?.email;
      if (user == null && email != null) {
        setState(() {
          _isUserLoggedIn = true;
          _emailAddress = email;
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('email_address');
      } else {
        if (_isUserLoggedIn) {
          setState(() {
            _isUserLoggedIn = false;
            _emailAddress = '';
          });
        }
      }
    });
  }

  void _subscribeToDynamicLinks() {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      handleLink(deepLink);
    }).onError((error) {
      print('Harol... onLink error... ${error.message}');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _readPendingEmailAddress();
    _subscribeForAuthState();
    _subscribeToDynamicLinks();
  }

  @override
  void dispose() {
    myController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = '';
    if (_emailAddress == null) {
      text = 'No User logged in';
    } else {
      if (!_isUserLoggedIn) {
        text = 'Waiting for link for email: $_emailAddress';
      } else {
        text = 'User logged in with email: $_emailAddress';
      }
    }

    var buttonText = _isUserLoggedIn ? 'Logout' : 'Send Email to Login';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
            ),
            const SizedBox(height: 20),
            if (!_isUserLoggedIn)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  onChanged: (_text) {
                    setState(() {
                      _entryEmailAddress = _text;
                    });
                  },
                  controller: myController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter an email',
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                if (!_isUserLoggedIn) {
                  if (_entryEmailAddress.isValidEmail()) {
                    sendEmailToAuthenticate();
                  }
                } else {
                  FirebaseAuth.instance.signOut();
                }
              },
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
