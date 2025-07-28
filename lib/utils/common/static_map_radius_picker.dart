// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:latlong2/latlong.dart';
//
// class MapRadiusSelectorScreen extends StatelessWidget {
//   final RxDouble radius = 18.0.obs;
//   final List<String> addressSuggestions = ["E Cass Sl", "E Polk S"];
//   final LatLng centerLocation = LatLng(37.7749, -122.4194); // SF coordinates
//   final MapController mapController = MapController();
//
//   MapRadiusSelectorScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('REDIA'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Address suggestions
//             ...addressSuggestions.map((address) => Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Row(
//                 children: [
//                   const Icon(Icons.location_on_outlined, size: 20),
//                   const SizedBox(width: 8),
//                   Text(address),
//                 ],
//               ),
//             )).toList(),
//
//             const SizedBox(height: 16),
//
//             // Current location button
//             TextButton.icon(
//               onPressed: () => mapController.move(centerLocation, 15),
//               icon: const Icon(Icons.my_location, color: Colors.blue),
//               label: const Text(
//                   "Use my current location",
//                   style: TextStyle(color: Colors.blue)
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Interactive map
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Obx(() {
//                   return FlutterMap(
//                     mapController: mapController,
//                     options: MapOptions(
//                       center: centerLocation,
//                       zoom: 13,
//                       interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         subdomains: const ['a', 'b', 'c'],
//                       ),
//                       CircleLayer(
//                         circles: [
//                           CircleMarker(
//                             point: centerLocation,
//                             radius: radius.value * 100, // Convert miles to meters
//                             useRadiusInMeter: true,
//                             color: Colors.blue.withOpacity(0.2),
//                             borderColor: Colors.blue,
//                             borderStrokeWidth: 2,
//                           ),
//                         ],
//                       ),
//                       MarkerClusterLayerWidget(
//                         options: MarkerClusterLayerOptions(
//                           maxClusterRadius: 120,
//                           size: const Size(40, 40),
//                           markers: [
//                             Marker(
//                               point: centerLocation,
//                               width: 40,
//                               height: 40,
//                               builder: (ctx) => const Icon(
//                                 Icons.location_on,
//                                 color: Colors.blue,
//                                 size: 40,
//                               ), child: null,
//                             ),
//                           ],
//                           builder: (context, markers) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   markers.length.toString(),
//                                   style: const TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Distance selector
//             const Text(
//               "Select a distance",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16
//               ),
//             ),
//
//             const SizedBox(height: 4),
//
//             const Text(
//               "Show listings within a specific distance.",
//               style: TextStyle(color: Colors.grey),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Slider
//             Obx(() {
//               return Column(
//                 children: [
//                   Slider(
//                     value: radius.value,
//                     min: 1,
//                     max: 60,
//                     divisions: 59,
//                     onChanged: (value) {
//                       radius.value = value;
//                       mapController.move(centerLocation, mapController.zoom);
//                     },
//                   ),
//                   Text(
//                     "${radius.value.round()} mi",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }