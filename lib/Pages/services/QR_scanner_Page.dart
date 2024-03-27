// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class QRCodeScannerPage extends StatefulWidget {
//   @override
//   _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
// }

// class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
//   String _scanResult = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _scanQRCode,
//               child: Text('Scan QR Code'),
//             ),
//             SizedBox(height: 16),
//             Text('Scan Result: $_scanResult'),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _scanQRCode() async {
//     try {
//       final result = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       );

//       if (!mounted) return;

//       setState(() {
//         _scanResult = result;
//       });

//       // TODO: Retrieve patient data from Firestore using the scanned result
//     } catch (e) {
//       setState(() {
//         _scanResult = 'Unable to scan QR code: $e';
//       });
//     }
//   }
// }
