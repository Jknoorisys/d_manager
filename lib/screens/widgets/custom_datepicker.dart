import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final double? height;
  final double? width;
  final void Function(DateTime)? onDateSelected; // Callback for selected date

  CustomDatePicker({
    required this.selectedDate,
    this.height,
    this.width,
    this.onDateSelected, // Add the callback parameter
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          helpText: S.of(context).selectDate,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );

        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            selectedDate = pickedDate;
          });

          // Call the callback function with the selected date
          widget.onDateSelected!(pickedDate);
        }
      },
      child: Container(
        height: widget.height ?? Dimensions.height50,
        width: widget.width ?? MediaQuery.of(context).size.width / 2.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: Colors.white,
          border: Border.all(color: AppTheme.black, width: 0.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: DateFormat('yyyy-MM-dd').format(selectedDate),
                size: Dimensions.font14,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                  size: Dimensions.iconSize20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// new Custom Date Picker

class CustomDatePickerForUpdate extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final double? height;
  final double? width;

  const CustomDatePickerForUpdate({
    required this.selectedDate,
    required this.onDateChanged,
    this.height, this.width,
  });

  @override
  _CustomDatePickerForUpdateState createState() => _CustomDatePickerForUpdateState();
}

class _CustomDatePickerForUpdateState extends State<CustomDatePickerForUpdate> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
            widget.onDateChanged(_selectedDate);
          });
        }
      },
      child: Container(
        height: widget.height ?? Dimensions.height50,
        width: widget.width ?? MediaQuery.of(context).size.width/2.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: Colors.white,
          border: Border.all(color: AppTheme.black, width: 0.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              BigText(text: DateFormat('yyyy-MM-dd').format(_selectedDate), size: Dimensions.font14,),
              Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                  size: Dimensions.iconSize20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

