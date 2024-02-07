import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_datepicker.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../widgets/text_field.dart';

class TransportDetailAdd extends StatefulWidget {
  final Map<String, dynamic>? transportDetailData;
  const TransportDetailAdd({Key? key, this.transportDetailData, required void Function(String deliveryDate, String transportName, String hammalName) addDeliveryDetails}) : super(key: key);
  @override
  _TransportDetailAddState createState() => _TransportDetailAddState();
}

class _TransportDetailAddState extends State<TransportDetailAdd> {
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  String transportName = 'Dharma Transport';
  String hammalName = 'Prakash';

  @override
  void initState() {
    super.initState();
    if (widget.transportDetailData != null) {
      selectedDate = DateFormat('dd-MM-yyyy').parse(widget.transportDetailData!['transportDate']);
    }
  }
  TextEditingController transportNameController = TextEditingController();
  TextEditingController hammalNameController = TextEditingController();
  List<DeliveryDetails> transportDetails = [];
  void _addDeliveryDetails(
      String deliveryDate, String transportName, String hammalName) {
    setState(() {
      transportDetails.add(
        DeliveryDetails(
          deliveryDate: deliveryDate,
          transportName: transportName,
          hammalName: hammalName,
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
      backgroundColor: AppTheme.white,
      elevation: 10,
      surfaceTintColor: AppTheme.white,
      shadowColor: AppTheme.primary.withOpacity(0.5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).addTransportDetail,
            style: AppTheme.heading2,
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppTheme.primary),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: 'Select Delivery Date', size: Dimensions.font12,),
              Gap(Dimensions.height10/2),
              CustomDatePicker(
                selectedDate: selectedDate,
                firstDate: firstDate,
                lastDate: lastDate,
                width: Dimensions.screenWidth,
              ),
            ],
          ),
          SizedBox(height: Dimensions.height15),
          // CustomTextField(
          //   controller: transportNameController,
          //   labelText: S.of(context).transportName,
          //   keyboardType: TextInputType.text,
          //   borderColor: AppTheme.primary,
          // ),
          // CustomTextField(
          //   controller: hammalNameController,
          //   labelText: S.of(context).hammal,
          //   keyboardType: TextInputType.text,
          //   borderColor: AppTheme.primary,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: 'Select Transport', size: Dimensions.font12,),
              Gap(Dimensions.height10/2),
              CustomDropdown(
                dropdownItems: const ['Dharma Transport', 'Kamal Carrier', 'Yadav Brothers India', 'Kamdhenu Cargo Carriers'],
                selectedValue: transportName,
                width: Dimensions.screenWidth,
                onChanged: (newValue) {
                  setState(() {
                    transportName = newValue!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: Dimensions.height15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: 'Select Hammal', size: Dimensions.font12,),
              Gap(Dimensions.height10/2),
              CustomDropdown(
                width: Dimensions.screenWidth,
                dropdownItems: const ['Kamlesh', 'Sami Khan', 'Prakash', 'Rajesh'],
                selectedValue: hammalName,
                onChanged: (newValue) {
                  setState(() {
                    hammalName = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        CustomElevatedButton(
          onPressed: () {
            //Navigator.of(context).pop();
            _addDeliveryDetails(
              DateFormat('dd-MM-yyyy').format(selectedDate),
              transportNameController.text,
              hammalNameController.text,
            );
            Navigator.of(context).pop();
          },
          buttonText: "Submit",
        )
      ],
    );
  }
}
class DeliveryDetails {
  String deliveryDate;
  String transportName;
  String hammalName;

  DeliveryDetails({
    required this.deliveryDate,
    required this.transportName,
    required this.hammalName,
  });
}
