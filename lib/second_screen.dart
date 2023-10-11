import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'third_screen.dart';
import 'first_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  PanelController panelController = PanelController();

  CameraPosition? _initialPosition;
  GoogleMapController? _mapController;
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _initialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
      });
    } catch (e) {
      print('位置情報の取得に失敗しました: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _moveToLocation(LatLng location) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(location));
    }
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mapWidth = MediaQuery.of(context).size.width * 1;
    final double mapHeight = MediaQuery.of(context).size.height * 0.775;
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '場所やキーワードを検索',
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
                autofocus: true,
              )
            : Text('探す'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: mapWidth,
              height: mapHeight,
              child: GoogleMap(
                initialCameraPosition:
                    _initialPosition ?? CameraPosition(target: LatLng(0, 0)),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: true,
                mapType: _currentMapType,
              ),
            ),
          ),
          SlidingUpPanel(
            panel: Column(
              children: [
                SizedBox(height: 10),
                Icon(Icons.maximize,
                    color: Colors.white, size: 40), // ドラッグハンドルのアイコン
                SizedBox(height: 10),
                Text(
                  '投稿内容を掲載', // ここにタイトルを追加
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 3.75),
                ),
              ],
            ),
            color: Colors.green,
            borderRadius: radius,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.green,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'メニュー一覧',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'タイトルに戻る',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FirstScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              ListTile(
                title: Text(
                  '投稿する',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  '地図のスタイルを切り替える',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  _toggleMapType(); // 地図のスタイルを切り替えるメソッドを呼び出す
                  Navigator.pop(context); // Drawerを閉じる
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
