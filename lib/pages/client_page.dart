import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reservation_system/models/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<DateTime?> availableDates = [];
  List<DateTime> unavailableDates = [];

  @override
  void initState() {
    super.initState();
    //onViewChanged;
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
          const Text('Select From Available Dates:'),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: _buildDatePicker(),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return SfCalendar(
      showNavigationArrow: true,
      minDate: DateTime.now(),
      blackoutDates: unavailableDates,
      blackoutDatesTextStyle: const TextStyle(
          color: Colors.red, decoration: TextDecoration.lineThrough),
      monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) {
        if (availableDates.contains(details.date)) {
          return Container(
            color: Colors.blue.withOpacity(0.1),
            child: Center(
              child: Text(
                details.date.day.toString(),
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          );
        }
        return Container(
          color: Colors.transparent,
          child: Center(
            child: Text(
              details.date.day.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
      selectionDecoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue, width: 2),
        shape: BoxShape.rectangle,
      ),
      timeSlotViewSettings: const TimeSlotViewSettings(
        nonWorkingDays: <int>[DateTime.friday, DateTime.saturday],
        startHour: 8,
        endHour: 17,
        timeRulerSize: 70,
        timeInterval: Duration(minutes: 15),
        timeIntervalHeight: 30,
        timeFormat: 'h mm a',
      ),
      todayHighlightColor: Colors.blue,
      cellBorderColor: Colors.transparent,
      view: CalendarView.month,
      onViewChanged: onViewChanged,
      //dataSource: _getCalendarDataSource(),
      onTap: (calendarTapDetails) {
        handleOnTap(calendarTapDetails);
      },
    );
  }

  void onViewChanged(ViewChangedDetails viewChangedDetails) {
    Provider provider = Provider();
    List<DateTime> blackoutDates = <DateTime>[];

    SharedPreferences.getInstance().then((prefs) {
      String? jsonString = prefs.getString('provider');
      if (jsonString != null) {
        provider = Provider.fromJson(jsonDecode(jsonString));
      }
      availableDates = provider.openDates;

      DateTime date;
      DateTime startDate = viewChangedDetails.visibleDates[0];
      DateTime endDate = viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length - 1];
      for (date = startDate;
          date.isBefore(endDate) || date == endDate;
          date = date.add(const Duration(days: 1))) {
        if (availableDates.contains(date)) {
          continue;
        }

        blackoutDates.add(date);
      }
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          unavailableDates = blackoutDates;
        });
      });
    });
  }

  void handleOnTap(CalendarTapDetails calendarTapDetails) {
    // Handle day selection logic here
    DateTime? selectedDate = calendarTapDetails.date;
    // if (selectedDates.contains(selectedDate)) {
    //   selectedDates.remove(selectedDate);
    // } else {
    //   selectedDates.add(selectedDate!);
    //   print("Selected date: $selectedDate");
    // }
    print("Selected date: $selectedDate");
  }

  void getAvailableDates() {
    Provider provider = Provider();
    SharedPreferences.getInstance().then((prefs) {
      String? jsonString = prefs.getString('provider');
      if (jsonString != null) {
        provider = Provider.fromJson(jsonDecode(jsonString));
      }
      availableDates = provider.openDates;
    });
  }
}
