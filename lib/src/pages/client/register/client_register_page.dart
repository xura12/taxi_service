import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:taxi_service/src/pages/client/register/client_register_controller.dart';
import 'package:taxi_service/src/utils/colors.dart' as utils;
import 'package:taxi_service/src/widgets/button_app.dart';

class ClientRegisterPage extends StatefulWidget {
  const ClientRegisterPage({Key key}) : super(key: key);

  @override
  State<ClientRegisterPage> createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {

  ClientRegisterController _con=new ClientRegisterController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.unit(context);
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        title: Text("BIENVENIDO"),centerTitle: true,
        backgroundColor: utils.Colors.TaxiServiceColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _BannerApp(),
            _textLogin(),
            _textFielUserName(),
            _textFielEmail(),
            _textFielPassword(),
            _textFielConfirmPassword(),
            _buttonRegister(),


          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(text: "Registrar ahora",
        color: utils.Colors.TaxiServiceColor,
      textColor: Colors.white,
        onPressed: _con.register,
      ),
    );
  }

  Widget _textFielEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: TextField(
          controller: _con.emailController ,
          decoration: InputDecoration(
            hintText: "Ejemplo@gmail.com",
            labelText: "Correo Electronico",
              suffixIcon: Icon(
                Icons.email_outlined,
                color: utils.Colors.TaxiServiceColor,
              ),
          ),
        ),
    );
  }
  Widget _textFielUserName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.usernameController ,
          decoration: InputDecoration(
            hintText: "Maria Lopez",
            labelText: "Nombre de Usuario",
              suffixIcon: Icon(
                Icons.person_outline,
                color: utils.Colors.TaxiServiceColor,
              ),
          ),
        ),
    );
  }


  Widget _textFielPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          controller: _con.passwordController ,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Contraseña",
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.Colors.TaxiServiceColor,
              ),
          ),
        ),
    );
  }
  Widget _textFielConfirmPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          controller: _con.confirmPasswordController ,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirmar Contraseña",
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.Colors.TaxiServiceColor,
              ),
          ),
        ),
    );
  }

  Widget _textLogin(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
      child: Text("REGISTRO",
          style: TextStyle(
              color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
      ),

      ),

    );
  }



//diseño del banner
  Widget _BannerApp(){
    return ClipPath(
      clipper: WaveClipperOne(),


      child: Container(
        color: utils.Colors.TaxiServiceColor,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center ,

          children: [
            Image.asset(
              "asset/log2.png",
              width: 250,
              height: 200,
            ),


            Text("Facil y Rapido",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Pacifico",
                  fontSize: 20,
                  fontWeight: FontWeight.normal
              ),
            )
          ],
        ),
      ),
    );
  }

}
