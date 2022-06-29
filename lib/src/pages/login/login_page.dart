import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:taxi_service/src/pages/login/login_controller.dart';
import 'package:taxi_service/src/utils/colors.dart' as utils;
import 'package:taxi_service/src/widgets/button_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  LoginController _con=new LoginController();


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
            _textDescription(),
            _textLogin(),
            SizedBox(height: MediaQuery.of(context).size.height *0.1,),
            _textFielEmail(),
            _textFielContrasena(),
            _buttonLogin(),
            _textNoTienesCuenta()

          ],
        ),
      ),
    );
  }

  Widget _textNoTienesCuenta(){
    return GestureDetector(
      onTap: _con.goToRegisterPage,
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Text(
          "No tengo cuenta",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),

      ),
    );
  }



  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(text: "Iniciar Sesion",
        color: utils.Colors.TaxiServiceColor,
      textColor: Colors.white,
        onPressed: _con.login,
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
  Widget _textFielContrasena(){
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

  Widget _textDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text("Continua con tu",
            style: TextStyle(
                color: Colors.black45,
                fontSize: 24,
                fontFamily: "NimbusSans"
            ),
          ),
    );

  }
  Widget _textLogin(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
      child: Text("Registro",
          style: TextStyle(
              color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
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
