import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:taxi_service/src/pages/driver/edit/driver_edit_controller.dart';
import 'package:taxi_service/src/pages/login/login_controller.dart';
import 'package:taxi_service/src/pages/driver/register/driver_register_controller.dart';
import 'package:taxi_service/src/utils/colors.dart' as utils;
import 'package:taxi_service/src/utils/otp_widget.dart';
import 'package:taxi_service/src/widgets/button_app.dart';

class DriverEditPage extends StatefulWidget {
  @override
  _DriverEditPageState createState() => _DriverEditPageState();
}

class _DriverEditPageState extends State<DriverEditPage> {

  DriverEditController _con = new DriverEditController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT STATE');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

  }

  @override
  Widget build(BuildContext context) {

    print('METODO BUILD');

    return Scaffold(
      key: _con.key,
      appBar: AppBar(backgroundColor: utils.Colors.TaxiServiceColor),
      bottomNavigationBar: _buttonRegister(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerApp(),
            _textLogin(),
            _textLicencePlate(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: OTPFields(
                pin1: _con.pin1Controller,
                pin2: _con.pin2Controller,
                pin3: _con.pin3Controller,
                pin4: _con.pin4Controller,
                pin5: _con.pin5Controller,
                pin6: _con.pin6Controller,
              ),
            ),

            _textFieldUsername(),

          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.register,
        text: 'Actualizar ahora',
        color: utils.Colors.TaxiServiceColor,
        textColor: Colors.white,
      ),
    );
  }


  Widget _textFieldUsername() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.usernameController,
        decoration: InputDecoration(
            hintText: 'Pepito Perez',
            labelText: 'Nombre de usuario',
            suffixIcon: Icon(
              Icons.person_outline,
              color: utils.Colors.TaxiServiceColor,
            )
        ),
      ),
    );
  }


  Widget _textLicencePlate() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
          'Placa del vehiculo',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 17
        ),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        'Editar perfil',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.TaxiServiceColor,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('asset/profile.jpg'),
              radius: 50,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'Facil y Rapido',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
