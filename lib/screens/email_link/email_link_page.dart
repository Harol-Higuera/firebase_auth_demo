import 'package:fir_auth_demo/extensions/string+extension.dart';
import 'package:fir_auth_demo/screens/email_link/email_link_view_model.dart';
import 'package:fir_auth_demo/styles/button_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailLinkPage extends ConsumerStatefulWidget {
  const EmailLinkPage({Key? key}) : super(key: key);

  @override
  _EmailLinkPageState createState() => _EmailLinkPageState();
}

class _EmailLinkPageState extends ConsumerState<EmailLinkPage> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(emailViewModelProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(emailViewModelProvider);
    final _description = state.description;
    final _isUserLoggedIn = state.isUserLoggedIn;

    var buttonText = _isUserLoggedIn ? 'Logout' : 'Send Email to Login';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Email Link'),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _description,
            ),
            const SizedBox(height: 20),
            if (!_isUserLoggedIn)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  onChanged: (_text) {
                    ref
                        .read(emailViewModelProvider.notifier)
                        .setEntryEmailAddress(_text);
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
              onPressed: () async {
                if (!_isUserLoggedIn) {
                  final entry = state.entryEmailAddress;
                  if (entry.isValidEmail()) {
                    await ref
                        .read(emailViewModelProvider.notifier)
                        .sendEmailToAuthenticate(onDone: () {
                      myController.clear();
                    });
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
