import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_dotted_polygon/google_map_dotted_polygon.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapExample extends StatefulWidget {
  const MapExample({super.key});

  @override
  State<MapExample> createState() => _MapExampleState();
}

class _MapExampleState extends State<MapExample> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polylines = {};
  final CameraPosition _initialCamera = const CameraPosition(
    target: LatLng(11.57, 104.90),
    zoom: 12,
  );

  final List<LatLng> toulKorkArea = [
    LatLng(11.590461201325226, 104.89694609018666),
    LatLng(11.58610369496405, 104.90035914072371),
    LatLng(11.585616861544324, 104.90036604293218),
    LatLng(11.585556007307225, 104.90062832685328),
    LatLng(11.58570809142832, 104.90078800652594),
    LatLng(11.58334717767906, 104.90785315606841),
    LatLng(11.583117803135286, 104.9074572905893),
    LatLng(11.574534476715868, 104.90463071669102),
    LatLng(11.57454824298762, 104.90398040839905),
    LatLng(11.574358433263592, 104.90386685665676),
    LatLng(11.570201511350664, 104.90474490546278),
    LatLng(11.570451223676981, 104.90641878531095),
    LatLng(11.557700949071673, 104.90823398072956),
    LatLng(11.548308655431223, 104.89849643256107),
    LatLng(11.548605198449984, 104.89775867361395),
    LatLng(11.54812331588525, 104.89716279138742),
    LatLng(11.548151116824965, 104.89720062517958),
    LatLng(11.54961529575409, 104.89570619038922),
    LatLng(11.549610503500295, 104.8908724718388),
    LatLng(11.551746863070575, 104.88801982388168),
    LatLng(11.553404924566475, 104.88722609805107),
    LatLng(11.55632394984418, 104.88685910416457),
    LatLng(11.558313506566718, 104.88758098750783),
    LatLng(11.56150783084864, 104.8904775289406),
    LatLng(11.56579048573776, 104.88853401289727),
    LatLng(11.58347854697344, 104.88744080496352),
    LatLng(11.584869080702525, 104.88839859901655),
    LatLng(11.590701698093422, 104.89686882756727),
    LatLng(11.59076188575557, 104.89731103007699),
  ];

  @override
  void initState() {
    super.initState();
    _loadPolygon();
  }

  void _loadPolygon() {
    final polygon = GoogleMapDottedPolygon.createDottedPolygon(
      points: toulKorkArea,
      color: Colors.red,
      gap: 0.0007,
      width: 2,
    );
    _polylines.addAll(polygon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dotted Polygon Example')),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        onMapCreated: (controller) => _controller.complete(controller),
        polylines: _polylines,
        zoomControlsEnabled: false,
        gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_map_dotted_polygon/google_map_dotted_polygon.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MapExample(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class MapExample extends StatefulWidget {
//   const MapExample({super.key});
//
//   @override
//   State<MapExample> createState() => _MapExampleState();
// }
//
// class _MapExampleState extends State<MapExample> {
//   final Completer<GoogleMapController> _controller = Completer();
//   final Set<Polyline> _polylines = {};
//   final CameraPosition _initialCamera = const CameraPosition(
//     target: LatLng(11.57, 104.90),
//     zoom: 12,
//   );
//
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPolygonFromAPI();
//   }
//
//   Future<void> _fetchPolygonFromAPI() async {
//     try {
//       // Replace this URL with your own API endpoint
//       final url = Uri.parse('https://example.com/api/zones/toulkork');
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//
//         // Example expected API response:
//         // [
//         //   {"lat": 11.59046, "lng": 104.89694},
//         //   {"lat": 11.58610, "lng": 104.90035},
//         //   ...
//         // ]
//
//         final List<LatLng> toulKorkArea = data
//             .map((e) => LatLng(
//           double.parse(e['lat'].toString()),
//           double.parse(e['lng'].toString()),
//         ))
//             .toList();
//
//         _createDottedPolygon(toulKorkArea);
//       } else {
//         debugPrint('Failed to load coordinates. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching polygon: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _createDottedPolygon(List<LatLng> points) {
//     final polygon = GoogleMapDottedPolygon.createDottedPolygon(
//       points: points,
//       color: Colors.red,
//       gap: 0.0007,
//       width: 2,
//     );
//     setState(() {
//       _polylines.clear();
//       _polylines.addAll(polygon);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dotted Polygon from API')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         initialCameraPosition: _initialCamera,
//         onMapCreated: (controller) => _controller.complete(controller),
//         polylines: _polylines,
//         zoomControlsEnabled: false,
//         gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
//       ),
//     );
//   }
// }
