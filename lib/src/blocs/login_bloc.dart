

import 'dart:async';

import 'package:formvalidation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';


class LoginBloc with Validators{

  //final _emailController = StreamController<String>.broadcast();
  //final _passwordController = StreamController<String>.broadcast();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();


  //Recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);


  //Combinar email y pass
  Stream<bool> get formValidStream => 
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);


  //Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  //Obtener el ultimo valor ingresado al stream
  String get email => _emailController.value;
  String get password => _passwordController.value;




  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}