import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reservation_system/models/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProviderPage extends StatefulWidget {
  const ProviderPage({super.key});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  List<DateTime>? selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Provider Dashboard',
            style: TextStyle(
                color: Colors.black, fontSize: 24.0), // Set the title color
          ),
          centerTitle: true, // Center the title
          backgroundColor:
              Colors.blue, // Set the background color for the AppBar
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Select Available Dates:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 20,
            ),
            buildDatePicker(),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return SfDateRangePicker(
      showActionButtons: true,
      enablePastDates: false,
      view: DateRangePickerView.month,
      selectionMode: DateRangePickerSelectionMode.multiple,
      selectionShape: DateRangePickerSelectionShape.circle,
      selectionColor: Colors.blue,
      todayHighlightColor: Colors.blue,
      onCancel: () {
        Navigator.pop(context);
      },
      onSubmit: (Object? value) {
        handleOnSubmit(value)
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                    child: Text(
                      'Available Dates Confirmed',
                    ),
                  ),
                  duration: Duration(milliseconds: 2000),
                ),
              ),
            )
            .then(
              (value) => Navigator.pop(context),
            );
      },
    );
  }

  Future<void> handleOnSubmit(Object? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value != null) {
      Provider provider = Provider(openDates: value as List<DateTime>);
      await prefs.setString('provider', jsonEncode(provider.toJson()));
    }
  }
}
