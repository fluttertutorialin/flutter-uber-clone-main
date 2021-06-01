import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:clone_uber_app/src/pages/client/register/client_register_controller.dart';
import 'package:clone_uber_app/src/utils/colors.dart' as utils;
import 'package:clone_uber_app/src/widgets/button_app.dart';

class ClientRegisterPage extends StatefulWidget {
  @override
  _ClientRegisterPageState createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {

  ClientRegisterController _controller = new ClientRegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('InitState');

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            _bannerApp(),

            _textLogin(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            _textFieldUserName(),

            _textFieldEmail(),

            _textFieldPassword(),

            _textFieldConfirmPassword(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            _buttonRegister(),

          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25
      ),
      child: ButtonApp(
        onPressed: _controller.register,
        text:  'Registrar ahora',
        color: utils.Colors.uber_clone_color,
        textColor: Colors.white,
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _controller.emailController,
        decoration: InputDecoration(
            hintText: 'correo@gmail.com',
            labelText: 'Correo electronico',
            suffixIcon: Icon(
              Icons.email_outlined,
              color: utils.Colors.uber_clone_color,
            )
        ),
      ),
    );
  }

  Widget _textFieldUserName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _controller.usernameController,
        decoration: InputDecoration(
            hintText: 'kitian perez',
            labelText: 'Nombre de usuario',
            suffixIcon: Icon(
              Icons.person_outline,
              color: utils.Colors.uber_clone_color,
            )
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _controller.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Contraseña',
            suffixIcon: Icon(
              Icons.lock_open_outlined,
              color: utils.Colors.uber_clone_color,
            )
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _controller.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Confirmar Contraseña',
            suffixIcon: Icon(
              Icons.lock_open_outlined,
              color: utils.Colors.uber_clone_color,
            )
        ),
      ),
    );
  }

  Widget _textLogin(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Text(
        'Registro',
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
        color: utils.Colors.uber_clone_color,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Image.asset(
              'assets/img/logo_app.png',
              width: 150,
              height: 100,
            ),

            Text(
              'Fácil y rapido',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            )

          ],
        ),
      ),
    );
  }

}
