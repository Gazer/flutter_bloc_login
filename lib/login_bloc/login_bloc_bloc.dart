import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../LoginLogic.dart';
import './bloc.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final LoginLogic logic;

  // los eventos ahora se mapean en el constructor
  LoginBlocBloc({@required this.logic}) : super(InitialLoginBlocState()) {
    // la syntaxis no es la mas intuitiva, pero es algo como:
    on<DoLoginEvent>(
      // el metodo on recibe el callback que se ejecuta cuando se recibe el evento DoLoginEvent
      (event, emit) async {
        // acá ejecutamos nuestro código
        // ahora no se usa más yield para emeitir eventos, por lo que debemos pasar
        // el valor de emit a la función.
        await _doLogin(event, emit);
      },
    );
  }

  Future<void> _doLogin(
      DoLoginEvent event, Emitter<LoginBlocState> emit) async {
    //simplemente reemplazamos el yield del generato por la llamada a emit, simple :)
    emit(LogginInBlocState());

    try {
      var token = await logic.login(event.email, event.password);
      emit(LoggedInBlocState(token));
    } on LoginException {
      emit(ErrorBlocState("No se pudo loggear"));
    }
  }
}
