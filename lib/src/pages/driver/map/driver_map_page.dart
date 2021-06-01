import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:clone_uber_app/src/pages/driver/map/driver_map_controller.dart';
import 'package:clone_uber_app/src/widgets/button_app.dart';

class DriverMapPage extends StatefulWidget {
  @override
  _DriverMapPageState createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {

  DriverMapController _controller = new DriverMapController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonDrawer(),
                    _buttonCenterPosition()
                  ],
                ),
                Expanded(child: Container() ),
                _buttonConnect()
              ],
            ),
          )

        ],
      ),
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
                        _controller.driver?.username ?? 'Nombre de usuario',
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
                      _controller.driver?.email ?? 'Correo electronico',
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

  Widget _buttonDrawer(){
    return Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: _controller.openDrawer,
          icon: Icon(Icons.menu, color: Colors.white ),
        ),
      );

  }

  Widget _buttonConnect() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: ButtonApp(
        onPressed: _controller.connect,
        text: _controller.isConnect ? 'DESCONECTARSE' : 'CONECTARSE',
        color: _controller.isConnect ? Colors.grey[300] : Colors.amber,
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
    );
  }

  void refresh() {
    setState(() {

    });
  }
}
