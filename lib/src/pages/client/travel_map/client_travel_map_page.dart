import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:clone_uber_app/src/pages/client/travel_map/client_tavel_map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientTravelMapPage extends StatefulWidget {
  @override
  _ClientTravelMapPageState createState() => _ClientTravelMapPageState();

}
class _ClientTravelMapPageState extends State<ClientTravelMapPage> {

  ClientTravelMapController _controller = new ClientTravelMapController();

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
                    _cardStatusInfo(_controller.currentStatus),
                    _buttonCenterPosition()
                  ],
                ),
                Expanded(child: Container() ),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _cardStatusInfo(String status) {
    return SafeArea(
      child: Container(
        width: 110,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: _controller.colorStatus,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text(
          '${status ?? ''}',
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
      onTap: (){},
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
