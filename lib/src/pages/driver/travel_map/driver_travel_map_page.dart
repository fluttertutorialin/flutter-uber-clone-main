import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:clone_uber_app/src/pages/driver/travel_map/driver_tavel_map_controller.dart';
import 'package:clone_uber_app/src/widgets/button_app.dart';


class DriverTravelMapPage extends StatefulWidget {
  @override
  _DriverTravelMapPageState createState() => _DriverTravelMapPageState();
}

class _DriverTravelMapPageState extends State<DriverTravelMapPage> {

  DriverTravelMapController _controller = new DriverTravelMapController();

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
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonUserInfo(),
                    Column(
                      children: [
                        _cardKmInfo(_controller.km?.toStringAsFixed(1)),
                        _cardMinInfo(_controller.seconds?.toString())
                      ],
                    ),

                    _buttonCenterPosition()
                  ],
                ),
                Expanded(child: Container() ),
                _buttonStatus()
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _cardMinInfo(String min) {
    return SafeArea(
      child: Container(
        width: 110,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text(
          '${min ?? ''} seg',
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _cardKmInfo(String km) {
    return SafeArea(
      child: Container(
        width: 110,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text(
          '${km ?? ''} km',
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buttonUserInfo(){
    return GestureDetector(
      onTap: _controller.openBottomSheet,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 20
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCenterPosition(){
    return GestureDetector(
      onTap: _controller.centerPosition,
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
                Icons.location_searching,
                color: Colors.grey[600],
                size: 20
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonStatus() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: ButtonApp(
        onPressed: _controller.updateStatus,
        text: _controller.currentStatus,
        color: _controller.colorStatus,
        textColor: Colors.black,
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _controller.initialPosition,
      onMapCreated: _controller.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      markers: Set<Marker>.of(_controller.markers.values),
      polylines: _controller.polylines,
    );
  }

  void refresh() {
    setState(() {

    });
  }

}
