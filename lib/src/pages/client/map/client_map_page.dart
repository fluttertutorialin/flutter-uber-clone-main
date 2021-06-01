import 'package:clone_uber_app/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:clone_uber_app/src/pages/client/map/client_map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientMapPage extends StatefulWidget {
  @override
  _ClientMapPageState createState() => _ClientMapPageState();
}

class _ClientMapPageState extends State<ClientMapPage> {

  ClientMapController _controller = new ClientMapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Se ejecuto el dispose');
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      drawer: _drawer(),
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                _buttonDrawer(),
                _cardGooglePlaces(),
                _buttonChangeTo(),
                _buttonCenterPosition(),
                Expanded(child: Container() ),
                _buttonRequest()
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          )
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/my_location.png',
      width: 65,
      height: 65,
    );
  }

  Widget _drawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      _controller.client?.username ?? 'Nombre de usuario',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    child: Text(
                      _controller.client?.email ?? 'Correo electronico',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/img/profile.jpg'),
                    radius: 40,
                  )
                ]
            ),
            decoration: BoxDecoration(
                color: Colors.amber
            ),
          ),
          ListTile(
            title: Text('Editar perfil'),
            trailing: Icon(Icons.edit),
            //leading: Icon(Icons.cancel),
            onTap: (){},
          ),
          ListTile(
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
            //leading: Icon(Icons.cancel),
            onTap: _controller.signOut,
          ),
        ],
      ),
    );
  }

  Widget _buttonCenterPosition(){
    return GestureDetector(
      onTap: _controller.centerPosition,
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 20),
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

  Widget _buttonChangeTo(){
    return GestureDetector(
      onTap: _controller.changeFromTo,
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
                Icons.refresh,
                color: Colors.grey[600],
                size: 20
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonDrawer(){
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: _controller.openDrawer,
        icon: Icon(Icons.menu, color: Colors.white ),
      ),
    );

  }

  Widget _buttonRequest() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: ButtonApp(
        onPressed: _controller.requestDriver,
        text: 'Solicitar',
        color: Colors.amber,
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
      onCameraMove: (position){
        _controller.initialPosition = position;
      },
      onCameraIdle: () async {
        await _controller.setLocationDraggableInfo();
      },
    );
  }

  Widget _cardGooglePlaces() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoCardLocation(
                  'Desde',
                  _controller.from ?? 'Lugar de recogida',
                () async {
                  _controller.showGoogleAutoComplete(true);
                }
              ),
              SizedBox(height: 5),
              Container(
                  child: Divider(color: Colors.grey,height: 10)
              ),
              SizedBox(height: 5),
              _infoCardLocation(
                  'Hasta',
                  _controller.to ?? 'Lugar de destino',
                      () async {
                    _controller.showGoogleAutoComplete(false);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCardLocation(String title, String value, Function function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 10
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {

    });
  }
}
