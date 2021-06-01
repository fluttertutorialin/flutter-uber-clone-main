import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:clone_uber_app/src/pages/driver/driver_calification/driver_travel_calification_controller.dart';

import 'package:clone_uber_app/src/widgets/button_app.dart';

class DriverTravelCalificationPage extends StatefulWidget {
  @override
  _DriverTravelCalificationPageState createState() => _DriverTravelCalificationPageState();
}

class _DriverTravelCalificationPageState extends State<DriverTravelCalificationPage> {

  DriverTravelCalificationController _controller = new DriverTravelCalificationController();

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
      key: _controller.key,
      bottomNavigationBar: _buttonCalificate(),
      body: Column(
        children: [

          _bannerPriceInfo(),
          _listTileTravelInfo('Desde', _controller.travelHistory?.from ?? '', Icons.location_on),
          _listTileTravelInfo('Hasta', _controller.travelHistory?.to ?? '', Icons.directions_subway),
          SizedBox(height: 30),
          _textoCalificateYourDriver(),
          SizedBox(height: 15),
          _ratingBar()

        ],
      ),
    );
  }

  Widget _buttonCalificate() {
    return Container(
      height: 50,
      margin: EdgeInsets.all(30),
      child: ButtonApp(
        onPressed: _controller.calificate,
        text: 'CALIFICAR',
        color: Colors.amber,
      ),
    );
  }

  Widget _ratingBar() {
    return Center(
      child: RatingBar.builder(
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        initialRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemPadding: EdgeInsets.symmetric(horizontal: 4),
        unratedColor: Colors.grey[300],
        onRatingUpdate: (rating) {
          _controller.calification = rating;
          print('Rating $rating');
        }
      ),
    );
  }

  Widget _textoCalificateYourDriver() {
    return Text(
      'Califica a tu cliente',
      style: TextStyle(
        color: Colors.cyan,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }

  Widget _listTileTravelInfo(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
          maxLines: 1,
        ),
        subtitle: Text(
          value,
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14
          ),
          maxLines: 2,
        ),
        leading: Icon(icon, color: Colors.grey,),
      ),
    );
  }

  Widget _bannerPriceInfo() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        height: 280,
        color: Colors.amber,
        child: SafeArea(
          child: Column(
            children: [

              Icon(Icons.check_circle, color: Colors.grey[800], size: 100),
              SizedBox(height: 20),
              Text(
                'TU VIAJE A FINALIZADO',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Valor del viaje',
                style: TextStyle(
                    fontSize: 16,
                ),
              ),
              SizedBox(height: 1),
              Text(
                '${_controller.travelHistory?.price ?? ''}\$',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {

    });
  }
}
