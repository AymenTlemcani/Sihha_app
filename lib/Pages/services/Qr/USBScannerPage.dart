import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/PatientPage.dart';

class UsbScannerPage extends StatefulWidget {
  @override
  _UsbScannerPageState createState() => _UsbScannerPageState();
}

class _UsbScannerPageState extends State<UsbScannerPage> {
  String _receivedData = '';
  bool _error = false;
  String _errorMsg = 'error message';
  bool _isListening = false;

  Color ButtonColor = Colors.white;
  Color TextColor = SihhaGreen3;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      print('focused');
      setState(() {
        _isListening = true;
        _receivedData = '';
      });
    } else {
      print('not focused');
      setState(() {
        _isListening = false;
      });
    }
  }

  void _processReceivedData(String code) {
    // Process the received data here
    if (code.isNotEmpty && code.length == 20) {
      // Replace the following code with your logic
      // For example, if the scanned code is the user's own code
      if (code == user!.documentId && user!.isMedcin) {
        _showCannotScanOwnCodeDialog();
      } else {
        setState(() {
          isSuccessfullyScanned = true;
        });
        // Fetch user data based on the scanned code
        _fetchUserData(code);
      }
    }
  }

  void _handleKeyInput(RawKeyEvent event) {
    if (_isListening && event is RawKeyDownEvent) {
      LogicalKeyboardKey logicalKey = event.logicalKey;
      String inputChar = String.fromCharCode(logicalKey.keyId);
      print(logicalKey);
      print(logicalKey.keyId);
      print(logicalKey.debugName);

      // Check if the pressed key is alphanumeric
      if (RegExp(r'[a-zA-Z0-9]').hasMatch(inputChar)) {
        if (_receivedData.length < 20) {
          setState(() {
            _receivedData += inputChar;
          });
        }

        if (_receivedData.length == 20) {
          String code = _receivedData;
          _isListening = false;
          _focusNode.unfocus(); // Release focus when data length reaches 20
          setState(() {
            _receivedData = '';
          });
          _processReceivedData(code);
        } else if (_receivedData.length > 20) {
          // Release focus if data length exceeds 20 characters
          _focusNode.unfocus();
        }
      }
    }
  }

  void _showCannotScanOwnCodeDialog() {
    setState(() {
      _error = true;
      _errorMsg = 'Vous ne pouvez pas scanner votre propre code QR !';
    });
  }

  void _fetchUserData(String scannedCode) {
    print('fetching user data for code: $scannedCode');
    Patient.fetchPatientData(scannedCode).then(
      (patient) {
        //and that nigga's code is valid
        if (patient != null) {
          // Check if patients list is not null before adding the patient
          if (patients != null) {
            // Check if the patient is already in the list
            bool isPatientExists =
                patients!.any((p) => p.documentId == patient.documentId);

            if (!isPatientExists) {
              patients!.add(patient);
              print('Current number of patients : ${patients!.length}');
            } else {
              print('Patient already exists in the list');
            }
          } else {
            // Initialize the patients list if it's null
            patients = [patient];
            print('Current number of patients : ${patients!.length}');
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientPage(patient: patient),
            ),
          );
          // if that nigga's code is not valid tell em 'Nigga yo code aint valid'
        } else {
          setState(() {
            _error = true;
            _errorMsg = 'Utilisateur introuvable !';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Scanner QR code',
          style: SihhaPoppins3,
        ),
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mettez le code QR dans la zone de de votre scanner',
              style: SihhaPoppins3.copyWith(
                  color: Colors.black87, letterSpacing: 1.5, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'La lecture sera lancée automatiquement',
              textAlign: TextAlign.center,
              style: SihhaPoppins3.copyWith(
                  letterSpacing: 0.3,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Colors.black54),
            ),
            SizedBox(
              height: 30,
            ),

            Visibility(
              visible: _isListening,
              child: Text(
                'En train de scanner...',
                style: SihhaPoppins3.copyWith(
                    letterSpacing: 0.3,
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    color: Colors.black45),
              ),
            ),
            Visibility(
              // visible: !_isListening && !isSuccessfullyScanned,
              visible: !_isListening,
              // visible: true,
              child: TextButton(
                onHover: (value) {
                  setState(() {
                    ButtonColor = value ? SihhaGreen2 : Colors.white;
                    TextColor = value ? Colors.white : SihhaGreen2;
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(ButtonColor),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                onPressed: _isListening
                    ? null
                    : () {
                        FocusScope.of(context).requestFocus(_focusNode);
                        setState(() {
                          _error = false;
                          _errorMsg = '';
                        });
                      },
                child: IntrinsicWidth(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.refresh_bold,
                          color: TextColor,
                          size: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          're-scanner',
                          style: SihhaFont.copyWith(
                              color: TextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: _error,
              child: Text(
                _errorMsg,
                style: SihhaFont.copyWith(
                    letterSpacing: 0.3,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.destructiveRed),
                textAlign: TextAlign.center,
              ),
            ),
            // ElevatedButton(
            //   onPressed: _isListening
            //       ? null
            //       : () {
            //           FocusScope.of(context).requestFocus(_focusNode);
            //         },
            //   child: Text('start li'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: _isListening ? Colors.grey : null,
            //   ),
            // ),
            SizedBox(height: 156),
            Visibility(
                visible: false,
                child: Text('received data : ${_receivedData}')),
            Visibility(
                visible: false,
                child: Text('received data length: ${_receivedData.length}')),
            RawKeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKey: _handleKeyInput,
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
/******************************************************************************* */
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class UsbScannerPage extends StatefulWidget {
//   @override
//   _UsbScannerPageState createState() => _UsbScannerPageState();
// }

// class _UsbScannerPageState extends State<UsbScannerPage> {
//   String _receivedData = '';
//   bool _isListening = false;
//   FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(_handleFocusChange);
//   }

//   @override
//   void dispose() {
//     _focusNode.removeListener(_handleFocusChange);
//     _focusNode.dispose();
//     super.dispose();
//   }

//   void _handleFocusChange() {
//     if (_focusNode.hasFocus) {
//       setState(() {
//         _isListening = true;
//         _receivedData = '';
//       });
//     } else {
//       setState(() {
//         _isListening = false;
//       });
//     }
//   }

//   void _processReceivedData() {
//     // Process the received data here
//     print('Received Data: $_receivedData');
//     // Add your custom logic to handle the received data
//   }

//   void _handleKeyInput(RawKeyEvent event) {
//     if (_isListening && event is RawKeyDownEvent) {
//       String inputChar =
//           String.fromCharCode(event.logicalKey.keyLabel.codeUnitAt(0));
//       if (_receivedData.length < 20) {
//         setState(() {
//           _receivedData += inputChar;
//         });
//       }
//       if (_receivedData.length == 20) {
//         _isListening = false;
//         _processReceivedData();
//         setState(() {
//           _receivedData = '';
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Keyboard Input'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 FocusScope.of(context).requestFocus(_focusNode);
//               },
//               child: Text('Start Listening'),
//             ),
//             SizedBox(height: 16),
//             Text('Received Data : ${_receivedData}'),
//             Text('Received Data Length: ${_receivedData.length}'),
//             RawKeyboardListener(
//               focusNode: _focusNode,
//               onKey: _handleKeyInput,
//               child: SizedBox.shrink(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/************************************************************************************************ */
// import 'dart:async';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:usb_serial/usb_serial.dart';

// class UsbScannerPage extends StatefulWidget {
//   @override
//   _UsbScannerPageState createState() => _UsbScannerPageState();
// }

// class _UsbScannerPageState extends State<UsbScannerPage> {
//   final List<UsbDevice> _devices = [];
//   UsbDevice? _selectedDevice;
//   String _qrCodeData = '';
//   UsbPort? _port;
//   StreamSubscription? _subscription;

//   @override
//   void initState() {
//     super.initState();
//     _initUsbDevices();
//   }

//   Future<void> _initUsbDevices() async {
//     _devices.clear();
//     List<UsbDevice> devices = await UsbSerial.listDevices();
//     setState(() {
//       _devices.addAll(devices);
//     });
//   }

//   Future<void> _scanQRCode() async {
//     if (_selectedDevice != null) {
//       _subscription?.cancel();
//       _port = await _selectedDevice!.create(); // Create a new UsbPort instance
//       if (await _port!.open() != true) {
//         // Open the USB port
//         setState(() {
//           _qrCodeData = "Failed to open port";
//         });
//         return;
//       }

//       _subscription = _port!.inputStream!.listen((data) {
//         _processReceivedData(data);
//       });
//     }
//   }

//   void _processReceivedData(Uint8List data) {
//     String receivedData = String.fromCharCodes(data);
//     setState(() {
//       _qrCodeData = receivedData.trim();
//     });
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel();
//     _port?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Scanner'),
//       ),
//       body: Column(
//         children: [
//           DropdownButton<UsbDevice>(
//             value: _selectedDevice,
//             hint: Text('Select USB Device'),
//             onChanged: (UsbDevice? device) {
//               setState(() {
//                 _selectedDevice = device;
//               });
//             },
//             items: _devices.map((UsbDevice device) {
//               return DropdownMenuItem<UsbDevice>(
//                 value: device,
//                 child: Text(device.productName ?? 'N/A'),
//               );
//             }).toList(),
//           ),
//           ElevatedButton(
//             onPressed: _scanQRCode,
//             child: Text('Scan QR Code'),
//           ),
//           SizedBox(height: 16),
//           Text('QR Code Data: $_qrCodeData'),
//         ],
//       ),
//     );
//   }
// }

