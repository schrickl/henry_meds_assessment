import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reservation_system/widgets/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  late BookingCalendar instance;
  List<DateTimeRange> appointments = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    // Create a mock BookingService
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 15,
      bookingEnd: DateTime(now.year, now.month, now.day, 17, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );
  }

  // Handles the retrieval of appointments
  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  // Handles the upload of a new appointment
  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    DateTime dateToCompare = DateTime.now().add(const Duration(hours: 24));
    if (newBooking.bookingStart.isBefore(dateToCompare)) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Appointment must be made at least 24 hours in advance.',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: const Text(
              'Would you like to confirm your appointment?',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(
                        child: Text(
                          'Appointment Confirmed',
                        ),
                      ),
                      duration: Duration(milliseconds: 2000),
                    ),
                  );
                  setState(() {
                    appointments.add(
                      DateTimeRange(
                          start: newBooking.bookingStart,
                          end: newBooking.bookingEnd),
                    );
                  });
                  saveAppointments();
                  Navigator.of(context).pop();
                },
                child: const Text('YES'),
              ),
            ],
          );
        },
      );
    }
  }

  // Handles the saving of appointments to SharedPreferences
  void saveAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert DateTimeRange to a string
    String dateRangeString =
        "${appointments[0].start.toIso8601String()}|${appointments[0].end.toIso8601String()}";
    // Save the string in SharedPreferences
    prefs.setString("dateRangeKey", dateRangeString);
  }

  // Handles the retrieval of appointments from SharedPreferences
  void fetchAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the string from SharedPreferences
    String? storedDateRangeString = prefs.getString("dateRangeKey");

    // Convert the string back to DateTimeRange
    if (storedDateRangeString != null) {
      List<String> dateStrings = storedDateRangeString.split("|");
      DateTime storedStartDateTime = DateTime.parse(dateStrings[0]);
      DateTime storedEndDateTime = DateTime.parse(dateStrings[1]);
      DateTimeRange storedDateRange =
      DateTimeRange(start: storedStartDateTime, end: storedEndDateTime);
      appointments.add(storedDateRange);
    }
  }

  // Handles the conversion of the stream result to DateTimeRange
  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    fetchAppointments();
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Client Dashboard',
          style: TextStyle(
              color: Colors.black, fontSize: 24.0), // Set the title color
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.blue, // Set the background color for the AppBar
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Select From Available Dates:',
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: BookingCalendar(
              bookingService: mockBookingService,
              convertStreamResultToDateTimeRanges: convertStreamResultMock,
              getBookingStream: getBookingStreamMock,
              uploadBooking: uploadBookingMock,
              bookingButtonColor: Colors.blue,
              bookingButtonText: 'SCHEDULE',
              bookedSlotColor: Colors.red,
              selectedSlotColor: Colors.blue,
              hideBreakTime: false,
              loadingWidget: const LoadingIndicator(
                status: "Loading...",
              ),
              uploadingWidget: const LoadingIndicator(
                status: "Scheduling...",
              ),
              locale: 'en_US',
              startingDayOfWeek: StartingDayOfWeek.sunday,
            ),
          ),
        ],
      ),
    );
  }
}
