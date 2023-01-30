import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime)? onConfirmed;
  final String? label;
  final String dateFormat;
  const CustomDatePicker({super.key, this.onConfirmed, this.label, this.dateFormat = "dd/MM/yyyy"});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late String label;
  @override
  void initState() {
    super.initState();
    label = widget.label ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        DateTime? selectedBirthday = await DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            onConfirm: widget.onConfirmed,
            maxTime: DateTime.now(),
            currentTime: DateTime.now(),
            locale: LocaleType.en);
        if (selectedBirthday != null) {
          setState(() {
            label = DateFormat(widget.dateFormat).format(selectedBirthday);
          });
        }
      },
      label: Text(label),
      icon: const Icon(
        Icons.web_asset_rounded,
        // FontAwesomeIcons.female,
      ),
    );
  }
}