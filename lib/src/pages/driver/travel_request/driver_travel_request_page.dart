import 'package:clone_uber_app/src/pages/driver/travel_request/driver_travel_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:clone_uber_app/src/utils/colors.dart' as utils;

import 'package:clone_uber_app/src/widgets/button_app.dart';

class DriverTravelRequestPage extends StatefulWidget {
  @override
  _DriverTravelRequestPageState createState() => _DriverTravelRequestPageState();
}

class _DriverTravelRequestPageState extends State<DriverTravelRequestPage> {

  DriverTravelRequestController _controller = new DriverTravelRequestController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _bannerClientInfo(),
          _textFromTo(_controller.from ?? '', _controller.to ?? ''),
          _textTimeLimit()
        ],
      ),
      bottomNavigationBar: _buttonAction(),
    );
  }

  Widget _buttonAction() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ButtonApp(
              onPressed: _controller.cancelTravel,
              text: 'Cancelar',
              color: Colors.red,
              textColor: Colors.white,
              icon: Icons.cancel_outlined,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ButtonApp(
              onPressed: _controller.acceptTravel,
              text: 'Aceptar',
              color: Colors.cyan,
              textColor: Colors.white,
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textTimeLimit() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Text(
        _controller.seconds.toString(),
        style: TextStyle(
          fontSize: 50
        ),
      ),
    );

  }

  Widget _textFromTo(String from, String to) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Recoger en',
            style: TextStyle(
              fontSize: 20
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              from,
              style: TextStyle(
                  fontSize: 17
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Llevar a',
            style: TextStyle(
                fontSize: 20
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              to,
              style: TextStyle(
                  fontSize: 17
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bannerClientInfo() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        color: utils.Colors.uber_clone_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/profile.jpg'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text(
                _controller.client?.username?? '',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {

    });
  }

}
