
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:taxi_service/src/pages/home/home_controller.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con=new HomeController();
  //Iniciando nuestro controlador

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
               //fila
          child:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.deepPurpleAccent[100]]
              )
            ),

            //Columnas
            child: Column(
              children:[
                _BannerApp(context),
                  //texto selecciona tu rol
                  SizedBox(height: 60,),
                  _textSelectYourRol(),
                  SizedBox(height: 10,),

                  //diseño del cliente
                  _imageTypeUser(context,"asset/pasajero.png","client"),
                  //texto cliente
                  SizedBox(height: 10,),

                  _textTypeUser("Cliente"),
                  SizedBox(height: 30,),

                   _imageTypeUser(context,"asset/driver.png", "driver"),
                  SizedBox(height: 10,),
                _textTypeUser("Conductor")

        ],
      ),
        ),
    ),
    );
  }

  Widget _BannerApp(BuildContext context){
    return ClipPath(
      clipper: WaveClipperOne(),


      child: Container(
        color: Colors.deepPurple [400],
        height: MediaQuery.of(context).size.height * 0.30,
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

  Widget _textSelectYourRol(){
    return Text("SELECCIONA TU ROL",
      style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: "OneDay"
      ),

    );
  }

//diseño del conductor
  Widget _imageTypeUser(BuildContext context, String image, String typeUser){
    return  GestureDetector(
      onTap: () => _con.goToLoginPage(typeUser),
         child: CircleAvatar(
          backgroundImage: AssetImage(image),
    radius: 50,
    backgroundColor: Colors.deepPurple[400]
      ),
       );

  }

  Widget _textTypeUser(String typeUser){
    return Text(typeUser,
        style: TextStyle(
        color: Colors.black,
        fontSize: 16
    ),
    );

  }
}
