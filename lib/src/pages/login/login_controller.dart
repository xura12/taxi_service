import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:taxi_service/src/models/client.dart';
import 'package:taxi_service/src/models/driver.dart';
import 'package:taxi_service/src/providers/auth_provider.dart';
import 'package:taxi_service/src/providers/client_provider.dart';
import 'package:taxi_service/src/providers/driver_provider.dart';
import 'package:taxi_service/src/utils/shared_pref.dart';
import 'package:taxi_service/src/utils/snackbar.dart ' as utils;

import '../../utils/my_progress_dialog.dart';

class LoginController{

  BuildContext context;
  GlobalKey<ScaffoldState> key= new GlobalKey<ScaffoldState>();


  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

   AuthProvider _authProvider;
   ProgressDialog _progressDialog;
   DriverProvider _driverProvider;
   ClientProvider _clientProvider;

   SharedPref _sharedPref;
   String _typeUser;


  Future unit (BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    _driverProvider= new DriverProvider();
    _clientProvider=new ClientProvider();
    _progressDialog=MyProgressDialog.createProgressDialog(context, "Espere un memento...");
    _sharedPref=new SharedPref();
    _typeUser= await _sharedPref.read("typeUser");

    print("==========TIPO DE SUSUARIO==========");
    print(_typeUser);
  }
  void goToRegisterPage(){
    if(_typeUser == "client"){
    Navigator.pushNamed(context, "client/register");
  }
    else{
      Navigator.pushNamed(context, "driver/register");

    }
    }
  void login ()async{
    String email= emailController.text.trim();
    String password= passwordController.text.trim();

    print("Email: $email");
    print("Password: $password");

    _progressDialog.show();

    try {
      bool isLogin= await _authProvider.login(email, password);
      _progressDialog.hide();

      if(isLogin){
        print("El usuario esta logeado");

        if (_typeUser == "client"){
          Client client=await _clientProvider.getById(_authProvider.getUser().uid);
          print("CLIENT: $client");


          if (client != null) {
            Navigator.pushNamedAndRemoveUntil(context, "client/map", (route) => false);
          }
            else {
            utils.Snackbar.showSnackbar(
                context, key, "El usuario no es valido");
            await _authProvider.signOut();
          }
          }
            else if (_typeUser == "driver"){
          Driver driver=await _driverProvider.getById(_authProvider.getUser().uid);
          print("DRIVER: $driver");

          if (driver != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, "driver/map", (route) => false);
          }
            else{
            utils.Snackbar.showSnackbar(context, key, "El usuario no es valido");
            await _authProvider.signOut();
          }

          }
      }
      else{
        print("El usuario no se pudo autenticar");
        utils.Snackbar.showSnackbar(context, key, "El usuario no se pudo autenticar");

      }

    }catch(error){
      utils.Snackbar.showSnackbar(context, key, "Error: $error");
      _progressDialog.hide();
      print("Error: $error");
    }

  }

}
