import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication/auth_service.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'models/user.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() {
  runApp(RepositoryProvider<AuthenticationService>(
    create: (context) {
      return FakeAuthenticationService();
    },
    // Injects the Authentication BLoC
    child: BlocProvider<AuthBloc>(
      create: (context) {
        final authService =
            RepositoryProvider.of<AuthenticationService>(context);
        return AuthBloc(authService)..add(AppLoaded());
      },
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final User? user;

  MyApp({Key? key, this.user}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication With BLoC',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return HomePage(
              user: state.user,
            );
          }
          return LoginPage();
        },
      ),
    );
  }
}
