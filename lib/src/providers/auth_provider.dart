
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthProvider {
   FirebaseAuth _firebaseAuth;


  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }
User getUser(){
    return _firebaseAuth.currentUser;
}
bool isSignedIn() {
  final currentUser = _firebaseAuth.currentUser;
  if (currentUser == null){
    return false;
}
  return true;
}
void checkIfUserIsLogged(BuildContext context,String typeUser){
    FirebaseAuth.instance.authStateChanges().listen((User user){
      //que el usuario esta logeado
      if( user !=null && typeUser !=null ){
        if (typeUser == "client"){
          Navigator.pushNamedAndRemoveUntil(context, "client/map",(route) =>false);

        }
        else{
          Navigator.pushNamedAndRemoveUntil(context, "driver/map",(route) =>false);
        }
        print("el usuario esta logeado");
      }
      else{
        print("el usuario no esta logeado");

      }
    });
}


  Future<bool> login(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error);

      //Correo invalido
      //contraseña incorrecta
      //no hay conexion a internet
      dynamic errorMessage = error;
      //return false;

    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }
  Future<bool> register(String email, String password) async {
    String errorMessage;

    try {
      var userCredential = await _firebaseAuth?.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error);

      //Correo invalido
      //contraseña incorrecta
      //no hay conexion a internet
      errorMessage = error.code;
      //return false;

    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }
  Future<void>signOut()async{
    return Future.wait([_firebaseAuth.signOut()]);
  }

}

