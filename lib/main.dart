import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('Device Id'),centerTitle: true,),
      body: Center(
        child: ElevatedButton(
          child: Text('Click Here'),
          onPressed: () async {
            String? deviceId = await getDeviceId();
            String? deviceName = await getDeviceName();

            print('${deviceName} - ${deviceId}');
          },
        ),
      ),
    ));
  }
}
Future<String?> getDeviceName() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.brand; // This will give you the device name on Android
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name; // This will give you the device name on iOS
    }
  } catch (e) {
    // Handle any errors that might occur while getting the device name
    print('Error getting device name: $e');
  }
  return null; // Return null if the platform is not Android or iOS
}

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model; // This is the unique identifier for Android devices
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor; // This is the unique identifier for iOS devices
  }
  return null; // Return null if the platform is not Android or iOS
}

