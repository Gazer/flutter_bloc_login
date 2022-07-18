import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/LoginLogic.dart';
import 'login_bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => LoginBlocBloc(
          logic: SimpleLoginLogic(),
        ),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Lo Logramos!"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Demoi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<LoginBlocBloc, LoginBlocState>(
          listener: (context, state) {
            if (state is ErrorBlocState) {
              _showError(context, state.message);
            }
            if (state is LoggedInBlocState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()));
            }
          },
          child: BlocBuilder<LoginBlocBloc, LoginBlocState>(
            builder: (context, state) {
              return Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "email"),
                      controller: emailController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "password"),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    if (state is LogginInBlocState)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      )
                    else
                      RaisedButton(
                        child: Text("Login"),
                        onPressed: _doLogin,
                      )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _doLogin() {
    BlocProvider.of<LoginBlocBloc>(context).add(
      DoLoginEvent(emailController.text, passwordController.text),
    );
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
