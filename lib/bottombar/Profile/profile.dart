import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Inner components
import './components/rlpage.dart';
import './components/user.dart';

// State
import '../../state/global_variables.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, state, _) {
        if (GlobalState.user['isLogged']) {
          return const Scaffold(
            body: UserView(),
          );
        } else {
          return const Scaffold(
            body: RegisterLoginPage(),
          );
        }
      },
    );
  }
}
