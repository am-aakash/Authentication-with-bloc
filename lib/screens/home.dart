import 'package:authentication_with_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:authentication_with_bloc/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text('HomePage'), centerTitle: true),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user.name}',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 12,
              ),
              MaterialButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Logout'),
                onPressed: () {
                  // Add UserLoggedOut to authentication event stream.
                  authBloc.add(UserLoggedOut());
                },
              )
            ],
          ),
        ));
  }
}
