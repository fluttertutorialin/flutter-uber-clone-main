import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:clone_uber_app/src/pages/login/login_controller.dart';
import 'package:clone_uber_app/src/utils/colors.dart' as utils;
import 'package:clone_uber_app/src/widgets/button_app.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _controller = new LoginController();

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

            _textDescription(),

            _textLogin(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.17),

            _textFieldEmail(),

            _textFieldPassword(),

            _buttonLogin(),

            _textDontHaveAccount()

          ],
        ),
      ),
    );
  }

  Widget _textDontHaveAccount(){
    return GestureDetector(
      onTap: _controller.goToRegisterPage,
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Text(
          'No tienes cuenta?',
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
      margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25
      ),
      child: ButtonApp(
        onPressed: _controller.login,
        text:  'Iniciar sesión',
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

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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

  Widget _textLogin(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Text(
        'Login',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28
        ),
      ),
    );
  }

  Widget _textDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Continua con tu',
        style: TextStyle(
            color: Colors.black54,
            fontSize: 24,
            fontFamily: 'NimbusSans'
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
