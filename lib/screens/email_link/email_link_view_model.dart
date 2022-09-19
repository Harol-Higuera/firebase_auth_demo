import 'dart:async';
import 'dart:ui';

import 'package:fir_auth_demo/Constants.dart';
import 'package:fir_auth_demo/enums/dynamic_link_type.dart';
import 'package:fir_auth_demo/screens/email_link/email_link_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final emailViewModelProvider =
    StateNotifierProvider.autoDispose<EmailLinkViewModel, EmailLinkState>(
  (ref) => EmailLinkViewModel(
    ref: ref,
  ),
);

class EmailLinkViewModel extends StateNotifier<EmailLinkState> {
  EmailLinkViewModel({required this.ref}) : super(EmailLinkState());

  final Ref ref;
  var auth = FirebaseAuth.instance;

  StreamSubscription<User?>? _onLoginStateChanged;

  var acs = ActionCodeSettings(
      url: 'https://harol.page.link/${DynamicLinkType.emailLink.subDomain}',
      handleCodeInApp: true,
      iOSBundleId: 'com.harol.fir.auth.demo',
      androidPackageName: 'com.harol.fir.auth.demo',
      androidInstallApp: true,
      androidMinimumVersion: '12');

  void init() async {
    /// Get If User Is logged in
    ///
    _subscribeForAuthState();

    /// Check If User Is logged in
    ///
    final user = auth.currentUser;
    final email = user?.email;
    final isUserLoggedIn = user != null && email != null;
    if (isUserLoggedIn) {
      state = state.copyWith(
          isUserLoggedIn: true,
          description: 'User logged in with email: $email');
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(sharedPrefsPendingEmail);
    } else {
      /// Get Pending Email address
      ///
      final prefs = await SharedPreferences.getInstance();
      final pendingEmailAddress = prefs.getString(sharedPrefsPendingEmail);
      var text = '';
      if (pendingEmailAddress == null) {
        text = 'No User logged in';
      } else {
        text = 'Waiting for link for email: $pendingEmailAddress';
      }
      state = state.copyWith(
        isUserLoggedIn: false,
        description: text,
      );
    }
  }

  @override
  void dispose() {
    _onLoginStateChanged?.cancel();
    super.dispose();
  }

  void _subscribeForAuthState() {
    _onLoginStateChanged = auth.authStateChanges().listen((User? user) async {
      final email = user?.email;
      if (user != null && email != null) {
        /// CASE: User just logged in
        ///
        state = state.copyWith(
            isUserLoggedIn: true,
            description: 'User logged in with email: $email');
        final prefs = await SharedPreferences.getInstance();
        prefs.remove(sharedPrefsPendingEmail);
      } else {
        /// CASE: User just logged out
        ///
        if (state.isUserLoggedIn) {
          state = state.copyWith(
            isUserLoggedIn: false,
            description: 'No User logged in',
          );
        }
      }
    });
  }

  Future<void> sendEmailToAuthenticate({
    required VoidCallback onDone,
  }) async {
    auth
        .sendSignInLinkToEmail(
          email: state.entryEmailAddress,
          actionCodeSettings: acs,
        )
        .catchError(
          (onError) => print('Error sending email verification $onError'),
        )
        .then(
      (value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(sharedPrefsPendingEmail, state.entryEmailAddress);
        state = state.copyWith(
          description: 'Waiting for link for email: ${state.entryEmailAddress}',
          entryEmailAddress: '',
        );
        onDone();
      },
    );
  }

  void setEntryEmailAddress(String entry) {
    state = state.copyWith(
      entryEmailAddress: entry,
    );
  }
}
