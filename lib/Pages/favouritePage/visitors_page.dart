// import 'dart:async';
// import 'dart:typed_data';

// import 'package:BandoBasta/Controller/event_controller.dart';
// import 'package:BandoBasta/Response/ticket_by_event_response.dart';
// import 'package:BandoBasta/utils/app_constants/app_constant.dart';
// import 'package:BandoBasta/utils/color/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:BandoBasta/utils/dimensions/dimension.dart';
// import 'package:shimmer/shimmer.dart';

// class VisitorsPage extends StatefulWidget {
//   const VisitorsPage({super.key});

//   @override
//   State<VisitorsPage> createState() => _VisitorsPageState();
// }

// class _VisitorsPageState extends State<VisitorsPage> {
//   final List<TicketDTOS> tickets = [];
//   ScrollController _scrollController = ScrollController();
//   var searchCriteria = TextEditingController();
//   late final MobileScannerController scannerController;
//   bool isScanning = false;
//   bool isSearching = false;
//   Timer? _debounce;

//   void _onSearchChanged(String value) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();

//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       setState(() {
//         isSearching = true;
//       });
//       _applyFilter();
//     });
//   }

//   void _applyFilter() {
//     var eventController = Get.find<EventController>();
//     eventController.onClose();
//     AppConstant.ticketOrderId = searchCriteria.text.toString();
//     eventController.getAllTicketByEvent();
//   }

//   String? getImagePath(List<String>? venueImagePaths) {
//     if (venueImagePaths != null && venueImagePaths.isNotEmpty) {
//       return venueImagePaths[0];
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     Get.find<EventController>().onClose();
//     Get.find<EventController>().getAllTicketByEvent();
//     Get.find<EventController>().getCountOfCheckedInAndBookedTicketsByEvent();
//     scannerController = MobileScannerController(
//       detectionSpeed: DetectionSpeed.noDuplicates,
//       facing: CameraFacing.back,
//     );
//   }

//   @override
//   void dispose() {
//     scannerController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       Get.find<EventController>().loadMore();
//     }
//   }

//   Future<void> scanQRAndCheckIn() async {
//     await showDialog(
//       context: context,
//       builder: (context) => MobileScanner(
//         controller: scannerController,
//         onDetect: (BarcodeCapture capture) {
//           if (isScanning) return;
//           setState(() {
//             isScanning = true;
//           });

//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;

//           if (barcodes.isNotEmpty) {
//             final String ticketId = barcodes.first.rawValue!;
//             var eventController = Get.find<EventController>();
//             eventController.checkIn(ticketId).then((status) {
//               if (status.isSuccess) {
//                 Navigator.pop(context);
//                 Get.find<EventController>()
//                     .getCountOfCheckedInAndBookedTicketsByEvent();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Checked In Ticket ID: $ticketId")),
//                 );
//               } else {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content: Text(
//                           "Ticket ID: $ticketId , Ticket has already been checked in")),
//                 );
//               }
//             });
//           }
//           setState(() {
//             isScanning = false;
//           });
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: Dimensions.height10 * 8,
//         automaticallyImplyLeading: false,
//         elevation: 0, // No shadow
//         backgroundColor: Colors.white,
//         title: Center(
//           child: Container(
//             height: Dimensions.height10 * 9,
//             width: Dimensions.height10 * 20,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.contain,
//                 image: AssetImage("assets/images/logo.png"), // Your logo image
//               ),
//             ),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(Dimensions.height10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title Section
//                 Text(
//                   "All Tickets",
//                   style: TextStyle(
//                     fontSize: Dimensions.height10 * 2,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: Dimensions.height10),
//                 // Attendance Status
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Attendance status",
//                       style: TextStyle(
//                         fontSize: Dimensions.height10 * 1.6,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     GetBuilder<EventController>(
//                       builder: (controller) {
//                         return Text(
//                           "${controller.totalCheckedIn} of ${controller.totalBooked}",
//                           style: TextStyle(
//                             fontSize: Dimensions.height10 * 1.6,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.purple,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: Dimensions.height10),
//                 _buildSearchBar(),
//                 SizedBox(height: Dimensions.height20),
//                 GetBuilder<EventController>(builder: (controller) {
//                   return controller.isLoaded
//                       ? controller.allTicketByEvent.isEmpty
//                           ? Container(
//                               height: MediaQuery.of(context).size.height * 0.5,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "No Available Tickets to show.",
//                                 style:
//                                     TextStyle(fontSize: 18, color: Colors.grey),
//                               ),
//                             )
//                           : Expanded(
//                               child: ListView.builder(
//                                 controller: _scrollController,
//                                 padding: EdgeInsets.zero,
//                                 physics: AlwaysScrollableScrollPhysics(),
//                                 itemCount:
//                                     controller.allTicketByEvent.length + 1,
//                                 itemBuilder: (context, index) {
//                                   if (index != controller.totalElements &&
//                                       index ==
//                                           controller.allTicketByEvent.length) {
//                                     return _buildSingleLoadingIndicator();
//                                   } else if (index ==
//                                           controller.totalElements &&
//                                       index ==
//                                           controller.allTicketByEvent.length) {
//                                     return Container();
//                                   }
//                                   return _buildTicketTile(
//                                       controller.allTicketByEvent[index]);
//                                 },
//                               ),
//                             )
//                       : _buildLoadingIndicator();
//                 }),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: Dimensions.height20,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: GestureDetector(
//                 onTap: scanQRAndCheckIn,
//                 child: Container(
//                   height: Dimensions.height10 * 6,
//                   width: Dimensions.height10 * 6,
//                   decoration: BoxDecoration(
//                     color: AppColors.themeColor,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 5,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.qr_code_scanner,
//                     color: Colors.white,
//                     size: Dimensions.height10 * 3,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 8,
//             spreadRadius: 6,
//             offset: Offset(1, 8),
//             color: Colors.grey.withOpacity(0.2),
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               onChanged: _onSearchChanged,
//               controller: searchCriteria,
//               decoration: InputDecoration(
//                 hintText: "Search For Ticket Ids",
//                 prefixIcon: Icon(Icons.search, color: AppColors.themeColor),
//                 focusedBorder: _buildInputBorder(),
//                 enabledBorder: _buildInputBorder(),
//                 border: _buildInputBorder(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   OutlineInputBorder _buildInputBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(Dimensions.radius30),
//       borderSide: BorderSide(width: 1.0, color: Colors.white),
//     );
//   }

//   Widget _buildTicketTile(TicketDTOS ticketDto) {
//     // Get the order status
//     String statusText = '';
//     Color statusColor =
//         Colors.green[800]!; // Default to green color for 'CHECKED_IN'

//     // Check the order status and assign appropriate label and color
//     if (ticketDto.ticketDetails![0].orderStatus == 'BOOKED') {
//       statusText = 'Booked';
//       statusColor = Colors.orange[800]!; // Use orange color for 'BOOKED'
//     } else if (ticketDto.ticketDetails![0].orderStatus == 'CHECKED_IN') {
//       statusText = 'Checked In';
//       statusColor = Colors.green[800]!; // Use green color for 'CHECKED_IN'
//     } else {
//       statusText = 'Unknown'; // If the status is neither, display 'Unknown'
//       statusColor = Colors.grey[700]!; // Grey color for unknown status
//     }

//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.black,
//         child: Text(
//           ticketDto.ticketDetails![0].ticketOrderId!
//               .toString(), // Display ticket order ID
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       title: Text("Ticket ID: " +
//           ticketDto.ticketDetails![0].ticketOrderId!.toString()),
//       trailing: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: Dimensions.height10,
//           vertical: Dimensions.height5,
//         ),
//         decoration: BoxDecoration(
//           color: statusColor.withOpacity(0.2), // Lighten the background color
//           borderRadius: BorderRadius.circular(Dimensions.radius15),
//         ),
//         child: Text(
//           statusText,
//           style: TextStyle(
//             color: statusColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Shimmer(
//       gradient: const LinearGradient(
//         colors: [
//           Color(0xFFEBEBF4),
//           Color(0xFFF4F4F4),
//           Color(0xFFEBEBF4),
//         ],
//         stops: [
//           0.1,
//           0.3,
//           0.4,
//         ],
//         begin: Alignment(-1.0, -0.3),
//         end: Alignment(1.0, 0.3),
//         tileMode: TileMode.clamp,
//       ),
//       child: Container(
//         height: Dimensions.height10 * 10,
//         child: ListView.builder(
//           padding: EdgeInsets.zero,

//           itemCount: 5, // You can adjust the number of shimmering cells
//           itemBuilder: (_, __) => Container(
//             padding: EdgeInsets.only(
//                 right: Dimensions.width10,
//                 left: Dimensions.width10,
//                 bottom: Dimensions.height20),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: Dimensions.height10 * 10,
//                   width: Dimensions.width10 * 10,
//                   color: Colors.white,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 8.0,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         height: Dimensions.height10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 8.0,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         height: Dimensions.height10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: Dimensions.height10 * 2.4,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         height: Dimensions.height10,
//                       ),
//                       Container(
//                         width: 40.0,
//                         height: 8.0,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         height: Dimensions.height10,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 8.0,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSingleLoadingIndicator() {
//     return Shimmer(
//       gradient: const LinearGradient(
//         colors: [
//           Color(0xFFEBEBF4),
//           Color(0xFFF4F4F4),
//           Color(0xFFEBEBF4),
//         ],
//         stops: [
//           0.1,
//           0.3,
//           0.4,
//         ],
//         begin: Alignment(-1.0, -0.3),
//         end: Alignment(1.0, 0.3),
//         tileMode: TileMode.clamp,
//       ),
//       child: Container(
//         height: Dimensions.height10 * 5,
//         child: Container(
//           padding: EdgeInsets.only(
//               right: Dimensions.width10,
//               left: Dimensions.width10,
//               bottom: Dimensions.height20),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: Dimensions.height10 * 10,
//                 width: Dimensions.width10 * 10,
//                 color: Colors.white,
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 8.0,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 8.0,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: Dimensions.height10 * 2.4,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     Container(
//                       width: 40.0,
//                       height: 8.0,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 8.0,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
