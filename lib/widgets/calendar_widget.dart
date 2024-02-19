import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Reservation System',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0),
        ),
        centerTitle: true,
      ),// Center the title
      body: SfCalendar(
        initialSelectedDate: DateTime.now(),
        view: CalendarView.month,
        ),
    );
  }
}
