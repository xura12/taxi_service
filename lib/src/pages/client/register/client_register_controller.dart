import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:taxi_service/src/providers/auth_provider.dart';
import 'package:taxi_service/src/providers/client_provider.dart';
import 'package:taxi_service/src/utils/my_progress_dialog.dart';
import 'package:taxi_service/src/utils/snackbar.dart ' as utils;


import '../../../models/client.dart';

class ClientRegisterController{

  BuildContext context;
  TextEditingController usernameController=new TextEditingController();
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController confirmPasswordController=new TextEditingController();

   AuthProvider _authProvider;
   ClientProvider _clientProvider;
   ProgressDialog _progressDialog;

  GlobalKey<ScaffoldState> key= new GlobalKey<ScaffoldState>();


  Future unit (BuildContext context){
    this.context =context;
    _authProvider=new AuthProvider();
    _clientProvider=new ClientProvider();
    _progressDialog=MyProgressDialog.createProgressDialog(context, "Espere un momento...");
  }
  void register ()async{
    String username= usernameController.text;
    String email= emailController.text.trim();
    String confirmPassword= confirmPasswordController.text.trim();
    String password= passwordController.text.trim();

    print("Email: $email");
    print("Password: $password");


    //validaciones de los campos de la pantalla de registro

    if(username.isEmpty && email.isEmpty && password.isEmpty && confirmPassword.isEmpty){
      print("Debes ingresar todos los campos");
      utils.Snackbar.showSnackbar(context, key, "Debes ingresar todos los campos");
      return;
    }
    if(confirmPassword != password) {
      print("Las contraseñas NO coinciden");
      utils.Snackbar.showSnackbar(context, key, "Las contraseñas NO coinciden");
      return;
    }
    if (password.length < 6){
      print("La contraseña debe tener al menos 6 caracteres");
      utils.Snackbar.showSnackbar(context, key, "La contraseña debe tener al menos 6 caracteres");
      return;
    }
    _progressDialog.show();


    try{
      bool isRegister= await _authProvider.register(email, password);

      if(isRegister){
        Client client =Client(

          id:_authProvider.getUser().uid,
            email:_authProvider.getUser().email,
          username: username,
          password: password

        );

        await _clientProvider.create(client);
        Navigator.pushNamedAndRemoveUntil(context, "client/map",(route) =>false);
        utils.Snackbar.showSnackbar(context, key, "El usuario se registro correctamente");
        _progressDialog.hide();
        print("El usuario se registro correctamente");
      }
      else{
        _progressDialog.hide();
        print("El usuario no se pudo registrar");
      }

    }catch(error){
      utils.Snackbar.showSnackbar(context, key, "Error: $error");
      _progressDialog.hide();
      print("Error: $error");
    }

  }

}
