import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart'; // Import FlutterMap
import 'package:latlong2/latlong.dart'; // Import latlong2 for coor
import 'package:cleanarchitecture/core/component/button/p_button.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/extensions/string_extensions.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:cleanarchitecture/core/services/url_launcher/url_launcher_manager.dart';
import 'package:cleanarchitecture/di.dart';
import 'package:cleanarchitecture/features/communication_map/data/model/map_response_model.dart';
import 'package:cleanarchitecture/features/communication_map/presentation/bloc/map_bloc.dart';
import 'package:cleanarchitecture/features/communication_map/presentation/bloc/map_event.dart';

class CommunicationMapScreen extends StatefulWidget {
  const CommunicationMapScreen({super.key});

  @override
  CommunicationMapScreenState createState() => CommunicationMapScreenState();
}

class CommunicationMapScreenState extends State<CommunicationMapScreen> {
  MapBloc mapBloc = MapBloc(mapUseCase: getIt());
  final List<Marker> _markers = [];
  MapController mapController = MapController(); // <-- Add the MapController
  String? selectedMarkerId;
  MapData? mapItem;
  MapData? zoomedMapData;
  List<MapData> mapDataList = [];

  @override
  void initState() {
    super.initState();
    mapBloc.add(const FetchPointsEvent());
  }

  loadMarkers(List<MapData> mapData) {
    _markers.addAll(
      mapData.map((point) {
        bool isSelected = selectedMarkerId == (point.id ?? '');
        return Marker(
          width: 35,
          height: 43,
          point: LatLng(point.latitude, point.longitude),
          child: GestureDetector(
            onTap: () {
              selectedMarkerId = point.id ?? '';
              mapItem = point;
              _markers.clear();
              loadMarkers(mapData);
              // zoomedMapData = mapDataList.first;
              mapController.move(
                LatLng(point.latitude, point.longitude),
                12, // Zoom level
              );
              setState(() {});
            },
            child: Image.asset(
              isSelected
                  ? isDarkContext(context)
                      // ? "assets/images/png/ic_selected_place.png"
                      ? "assets/images/png/location_map_dark.png"
                      : "assets/images/png/ic_selected_place.png"
                  : isDarkContext(context)
                  // ? "assets/images/png/location_map.png"
                  ? "assets/images/png/location_map_dark.png"
                  : "assets/images/png/location_map.png",
              width: isSelected ? 45 : 35,
              height: isSelected ? 45 : 35,
            ),
          ),
        );
      }).toList(),
    );

    if (mapData.isNotEmpty) {
      zoomedMapData = mapData.first;
      // Zoom and center the map on the first marker
      mapController.move(
        LatLng(zoomedMapData!.latitude, zoomedMapData!.longitude),
        10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mapBloc,
      child: BlocConsumer<MapBloc, BaseState>(
        listener: (context, state) async {
          if (state is LoadedState) {
            mapDataList =
                ((state.data.model?.model ?? []) as List<MapData>)
                    .where((e) => e.latitude > 0)
                    .toList();
            if (mapDataList.isNotEmpty) {
              zoomedMapData = mapDataList.first;
            }
            loadMarkers(mapDataList);
            if (zoomedMapData != null) {
              setState(() {});
            }
          }
        },
        builder: (context, state) {
          // Determine the current theme (dark or light)
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  color:
                      isDarkMode
                          ? AppColors.darkBackgroundColor
                          : AppColors.contentColor,
                  height: 1,
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController:
                          mapController, // <-- Pass the mapController
                      options: MapOptions(
                        initialCenter:
                            zoomedMapData != null
                                ? LatLng(
                                  zoomedMapData!.latitude,
                                  zoomedMapData!.longitude,
                                )
                                : const LatLng(0, 0),
                        initialZoom: 14,
                        maxZoom: 50,
                        minZoom: 3,
                        onTap: (_, __) {
                          setState(() {});
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          tileBuilder:
                              isDark
                                  ? customDarkModeTileBuilder
                                  : null, // customDarkModeTileBuilder defined below
                          userAgentPackageName: 'com.example.app',
                        ),
                        // TileLayer(tileBuilder: ,
                        //   // urlTemplate: 'https://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png',
                        //   urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                        //   subdomains: ['a', 'b', 'c'],
                        //   // tileProvider: NonCachingTileProvider(),
                        //   // urlTemplate: isDarkMode
                        //   //     ? 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
                        //   //     : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        // ),
                        MarkerLayer(markers: _markers),
                      ],
                    ),
                    if (mapItem != null)
                      Positioned(
                        bottom: 20,
                        left: 14,
                        right: 14,
                        child: buildInfoCard(mapItem!),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget customDarkModeTileBuilder(
    BuildContext context,
    Widget tileWidget,
    TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.3126, -0.9152, -0.0722, 0, 255, // Red channel
        -0.2126, -0.8152, -0.0722, 0, 255, // Green channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );
  }

  Widget buildInfoCard(MapData item) {
    // Get current theme
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: isDarkMode ? AppColors.darkFieldBackgroundColor : Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 85,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!item.attachmentUrl.isEmptyOrNull)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: PImage(
                            source: item.attachmentUrl ?? '',
                            width: 85,
                            height: 85,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: PText(
                              title: item.title ?? '',
                              size: PSize.text16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: PText(
                              title: item.text ?? '',
                              size: PSize.text16,
                              fontWeight: FontWeight.w400,
                              fontColor: AppColors.contentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              PButton(
                isFitWidth: true,
                onPressed: () {
                  UrlLauncherManager.redirectUrl(item.link ?? '');
                  setState(() {});
                },
                hasBloc: false,
                title: 'الانتقال للموقع',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class CommunicationMapScreen extends StatefulWidget {
//   static const String route = '/map_controller_animated';
//
//   const CommunicationMapScreen({super.key});
//
//   @override
//   AnimatedMapControllerPageState createState() =>
//       AnimatedMapControllerPageState();
// }
//
// class AnimatedMapControllerPageState extends State<CommunicationMapScreen>
//     with TickerProviderStateMixin {
//   static const _startedId = 'AnimatedMapController#MoveStarted';
//   static const _inProgressId = 'AnimatedMapController#MoveInProgress';
//   static const _finishedId = 'AnimatedMapController#MoveFinished';
//
//   static const _london = LatLng(51.5, -0.09);
//   static const _paris = LatLng(48.8566, 2.3522);
//   static const _dublin = LatLng(53.3498, -6.2603);
//
//   static const _markers = [
//     Marker(
//       width: 80,
//       height: 80,
//       point: _london,
//       child: FlutterLogo(key: ValueKey('blue')),
//     ),
//     Marker(
//       width: 80,
//       height: 80,
//       point: _dublin,
//       child: FlutterLogo(key: ValueKey('green')),
//     ),
//     Marker(
//       width: 80,
//       height: 80,
//       point: _paris,
//       child: FlutterLogo(key: ValueKey('purple')),
//     ),
//   ];
//
//   final mapController = MapController();
//
//   void _animatedMapMove(LatLng destLocation, double destZoom) {
//     // Create some tweens. These serve to split up the transition from one location to another.
//     // In our case, we want to split the transition be<tween> our current map center and the destination.
//     final camera = mapController.camera;
//     final latTween = Tween<double>(
//         begin: camera.center.latitude, end: destLocation.latitude);
//     final lngTween = Tween<double>(
//         begin: camera.center.longitude, end: destLocation.longitude);
//     final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);
//
//     // Create a animation controller that has a duration and a TickerProvider.
//     final controller = AnimationController(
//         duration: const Duration(milliseconds: 500), vsync: this);
//     // The animation determines what path the animation will take. You can try different Curves values, although I found
//     // fastOutSlowIn to be my favorite.
//     final Animation<double> animation =
//     CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
//
//     // Note this method of encoding the target destination is a workaround.
//     // When proper animated movement is supported (see #1263) we should be able
//     // to detect an appropriate animated movement event which contains the
//     // target zoom/center.
//     final startIdWithTarget =
//         '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
//     bool hasTriggeredMove = false;
//
//     controller.addListener(() {
//       final String id;
//       if (animation.value == 1.0) {
//         id = _finishedId;
//       } else if (!hasTriggeredMove) {
//         id = startIdWithTarget;
//       } else {
//         id = _inProgressId;
//       }
//
//       hasTriggeredMove |= mapController.move(
//         LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
//         zoomTween.evaluate(animation),
//         id: id,
//       );
//     });
//
//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         controller.dispose();
//       } else if (status == AnimationStatus.dismissed) {
//         controller.dispose();
//       }
//     });
//
//     controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Animated MapController')),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 children: <Widget>[
//                   MaterialButton(
//                     onPressed: () => _animatedMapMove(_london, 10),
//                     child: const Text('London'),
//                   ),
//                   MaterialButton(
//                     onPressed: () => _animatedMapMove(_paris, 5),
//                     child: const Text('Paris'),
//                   ),
//                   MaterialButton(
//                     onPressed: () => _animatedMapMove(_dublin, 5),
//                     child: const Text('Dublin'),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 children: <Widget>[
//                   MaterialButton(
//                     onPressed: () {
//                       final bounds = LatLngBounds.fromPoints([
//                         _dublin,
//                         _paris,
//                         _london,
//                       ]);
//
//                       mapController.fitCamera(
//                         CameraFit.bounds(
//                           bounds: bounds,
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                         ),
//                       );
//                     },
//                     child: const Text('Fit Bounds'),
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       final bounds = LatLngBounds.fromPoints([
//                         _dublin,
//                         _paris,
//                         _london,
//                       ]);
//
//                       final constrained = CameraFit.bounds(
//                         bounds: bounds,
//                       ).fit(mapController.camera);
//                       _animatedMapMove(constrained.center, constrained.zoom);
//                     },
//                     child: const Text('Fit Bounds animated'),
//                   ),
//                 ],
//               ),
//             ),
//             Flexible(
//               child: FlutterMap(
//                      mapController: mapController,
//                      options: const MapOptions(
//                        initialCenter: LatLng(51.5, -0.09),
//                        initialZoom: 5,
//                        maxZoom: 10,
//                        minZoom: 3,
//                      ),
//                     children: [
//                       TileLayer(
//                         urlTemplate:
//                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//                         // tileProvider: CancellableNetworkTileProvider(),
//                         tileUpdateTransformer: _animatedMoveTileUpdateTransformer,
//                       ),
//                       const MarkerLayer(markers: _markers),
//                     ],
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Causes tiles to be prefetched at the target location and disables pruning
// /// whilst animating movement. When proper animated movement is added (see
// /// #1263) we should just detect the appropriate AnimatedMove events and
// /// use their target zoom/center.
// final _animatedMoveTileUpdateTransformer =
// TileUpdateTransformer.fromHandlers(handleData: (updateEvent, sink) {
//   final mapEvent = updateEvent.mapEvent;
//
//   final id = mapEvent is MapEventMove ? mapEvent.id : null;
//   if (id?.startsWith(AnimatedMapControllerPageState._startedId) ?? false) {
//     final parts = id!.split('#')[2].split(',');
//     final lat = double.parse(parts[0]);
//     final lon = double.parse(parts[1]);
//     final zoom = double.parse(parts[2]);
//
//     // When animated movement starts load tiles at the target location and do
//     // not prune. Disabling pruning means existing tiles will remain visible
//     // whilst animating.
//     sink.add(
//       updateEvent.loadOnly(
//         loadCenterOverride: LatLng(lat, lon),
//         loadZoomOverride: zoom,
//       ),
//     );
//   } else if (id == AnimatedMapControllerPageState._inProgressId) {
//     // Do not prune or load whilst animating so that any existing tiles remain
//     // visible. A smarter implementation may start pruning once we are close to
//     // the target zoom/location.
//   } else if (id == AnimatedMapControllerPageState._finishedId) {
//     // We already prefetched the tiles when animation started so just prune.
//     sink.add(updateEvent.pruneOnly());
//   } else {
//     sink.add(updateEvent);
//   }
// });

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cleanarchitecture/core/component/appbar/p_appbar.dart';
// import 'package:cleanarchitecture/core/component/button/p_button.dart';
// import 'package:cleanarchitecture/core/component/image/p_image.dart';
// import 'package:cleanarchitecture/core/component/text/p_text.dart';
// import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
// import 'package:cleanarchitecture/core/extensions/string_extensions.dart';
// import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
// import 'package:cleanarchitecture/core/global/global_func.dart';
// import 'package:cleanarchitecture/core/global/state/base_state.dart';
// import 'package:cleanarchitecture/core/services/url_launcher/url_launcher_manager.dart';
// import 'package:cleanarchitecture/di.dart';
// import 'package:cleanarchitecture/features/communication_map/data/model/map_response_model.dart';
// import 'package:cleanarchitecture/features/communication_map/presentation/bloc/map_bloc.dart';
// import 'package:cleanarchitecture/features/communication_map/presentation/bloc/map_event.dart';
//
//
// class CommunicationMapScreen extends StatefulWidget {
//   const CommunicationMapScreen({super.key});
//
//   @override
//   CommunicationMapScreenState createState() => CommunicationMapScreenState();
// }
//
// class CommunicationMapScreenState extends State<CommunicationMapScreen> {
//   MapBloc mapBloc = MapBloc(mapUseCase:getIt());
//   late GoogleMapController mapController;
//   final Set<Marker> _markers = {};
//   late BitmapDescriptor customIcon;
//   late BitmapDescriptor selectedIcon;
//   String? selectedMarkerId;
//   MapData? mapItem;
//   MapData? zoomedMapData;
//   List<MapData> mapDataList =[];
//   @override
//   void initState() {
//     super.initState();
//     mapBloc.add(const FetchPointsEvent());
//   }
//
//   loadMarkers(List<MapData> mapData) async {
//     customIcon = await BitmapDescriptor.asset(
//       const ImageConfiguration(size: Size(35, 43)),
//       isDarkContext(context)?"assets/images/png/location_map_dark.png"
//           :"assets/images/png/location_map.png",
//     );
//     selectedIcon = await BitmapDescriptor.asset(
//       const ImageConfiguration(size: Size(40, 45)),
//       isDarkContext(context)?"assets/images/png/location_map_dark.png":
//       "assets/images/png/ic_selected_place.png",
//     );
//     _markers.addAll(mapData.map((point){
//       bool isSelected = selectedMarkerId == (point.id ?? '');
//       return Marker(
//         icon: isSelected ? selectedIcon : customIcon,
//         markerId: MarkerId(point.id??''),
//         position: LatLng(point.latitude, point.longitude),
//         // infoWindow: InfoWindow(title: point.title, snippet: point.text),
//         onTap:() {
//           selectedMarkerId = point.id ?? '';
//           mapItem = point;
//           _markers.clear();
//           loadMarkers(mapData);
//           // zoomedMapData = mapDataList.first;
//           setState(() {});
//         },
//       );
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar:CustomPersistentAppBar(text: 'الخريطة التفاعلية'),
//         body:BlocProvider(create:(context) => mapBloc,
//             child:BlocConsumer<MapBloc,BaseState>( listener:(context, state) async {
//               // if(state is LoadedState){
//               //   mapDataList = ((state.data.model?.model??[]) as List<MapData>).where((e) => e.latitude>0).toList();
//               //   // zoomedMapData = mapDataList.first;
//               //   loadMarkers(mapDataList);
//               // }
//               if (state is LoadedState) {
//                 mapDataList = ((state.data.model?.model ?? []) as List<MapData>)
//                     .where((e) => e.latitude > 0).toList();
//                 if (mapDataList.isNotEmpty) {
//                   zoomedMapData = mapDataList.first;
//                 }
//                 await loadMarkers(mapDataList);
//                 if (zoomedMapData != null) {
//                   mapController.animateCamera(
//                     CameraUpdate.newLatLngZoom(
//                       LatLng(zoomedMapData!.latitude, zoomedMapData!.longitude),
//                       10,
//                     ),
//                   );
//                 }
//               }
//             },builder:(context, state) {
//               return Column(
//                 children: [
//                   Padding(padding: const EdgeInsets.only(top:10),
//                     child: Divider(
//                       color:isDarkContext(context)?AppColors.darkBackgroundColor:AppColors.contentColor,
//                       height: 1,
//                     ),
//                   ),
//                   Expanded(
//                     child: Stack(
//                       children: [
//                         GoogleMap(
//                           initialCameraPosition: zoomedMapData!=null?CameraPosition(
//                             target: LatLng(zoomedMapData!.latitude, zoomedMapData!.longitude),
//                             zoom: 10,
//                           ):const CameraPosition(
//                             target:LatLng(0,0),
//                             zoom: 10,
//                           ),
//                           markers: _markers,
//                           onMapCreated: (GoogleMapController controller) {
//                             mapController = controller;
//                           },
//                           style: isDarkContext(context) ? darkMapStyle:null,
//                           mapType: MapType.normal,
//                         ),
//                         if (mapItem != null)
//                           Positioned(
//                             bottom:20,
//                             left: 14, right: 14,
//                             child: buildInfoCard(mapItem!),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },))
//     );
//   }
//
//   Widget buildInfoCard(MapData item) {
//     return SizedBox(
//       width: MediaQuery.sizeOf(context).width,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//         color: isDarkContext(context)?AppColors.darkFieldBackgroundColor:Colors.white,
//         elevation: 1,
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               SizedBox(height:85,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment:MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     if(!item.attachmentUrl.isEmptyOrNull) Padding(
//                       padding: const EdgeInsets.only(top:4),
//                       child: ClipRRect(borderRadius: BorderRadius.circular(4),
//                         child: PImage(source:item.attachmentUrl??'',
//                           width: 85,
//                           height: 85,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment:MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top:0),
//                             child: PText(
//                               title: item.title??'',
//                               size: PSize.text16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height:4),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 10),
//                             child: PText(
//                               title: item.text??'',
//                               size: PSize.text16,
//                               fontWeight: FontWeight.w400,
//                               fontColor: AppColors.contentColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height:14,),
//               PButton(
//                 isFitWidth: true,
//                 onPressed: () {
//                   // mapItem = null;
//                   UrlLauncherManager.redirectUrl(mapItem?.link??'');
//                   // UrlLauncherManager.redirectToMap(mapItem?.latitude??0,mapItem?.longitude??0);
//                   setState(() {});
//                 },
//                 hasBloc: false,
//                 title: 'الانتقال للموقع',
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
