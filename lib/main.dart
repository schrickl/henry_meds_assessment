import 'package:flutter/material.dart';
import 'package:reservation_system/pages/client_page.dart';
import 'package:reservation_system/pages/provider_page.dart';
import 'package:reservation_system/pages/schedule.dart';
import 'package:reservation_system/widgets/calendar_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation System',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white10,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reservation System',
          style: TextStyle(
              color: Colors.black, fontSize: 24.0), // Set the title color
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.blue, // Set the background color for the AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey
            ], // Customize the gradient colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle the first button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProviderPage(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(200, 50), // Set the button size
                  foregroundColor: Colors.white, // Set the text color
                  backgroundColor: Colors.blue, // Set the background color
                ),
                child: const Text(
                  'Providers',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Add some spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Handle the second button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ClientPage(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(200, 50), // Set the button size
                  foregroundColor: Colors.white, // Set the text color
                  backgroundColor: Colors.blue, // Set the background color
                ),
                child: const Text(
                  'Clients',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Add some spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Handle the second button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BookingCalendarDemoApp(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(200, 50), // Set the button size
                  foregroundColor: Colors.white, // Set the text color
                  backgroundColor: Colors.blue, // Set the background color
                ),
                child: const Text(
                  'Test',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
