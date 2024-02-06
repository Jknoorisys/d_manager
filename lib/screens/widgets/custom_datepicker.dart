import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  final double? height;
  final double? width;

  CustomDatePicker({
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate, this.height, this.width,
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
          initialDate: selectedDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );

        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        height: widget.height ?? Dimensions.height50,
        width: widget.width ?? MediaQuery.of(context).size.width/2.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: Colors.white,
          border: Border.all(color: AppTheme.primary, width: 0.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(selectedDate),
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
