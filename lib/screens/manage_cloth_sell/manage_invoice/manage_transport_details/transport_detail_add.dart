import 'package:d_manager/api/dropdown_services.dart';
import 'package:d_manager/api/manage_invoice_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/dropdown_models/dropdown_hammal_list_model.dart';
import 'package:d_manager/models/dropdown_models/dropdown_transport_list_model.dart';
import 'package:d_manager/models/invoice_models/add_transport_detail_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_datepicker.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TransportDetailAdd extends StatefulWidget {
  final String? sellId;
  final String? invoiceId;

  const TransportDetailAdd({Key? key, this.sellId, this.invoiceId}) : super(key: key);
  @override
  _TransportDetailAddState createState() => _TransportDetailAddState();
}

class _TransportDetailAddState extends State<TransportDetailAdd> {
  DateTime selectedDate = DateTime.now();
  var selectedTransport;
  var selectedHammal;
  String selectedTransportName = '';
  String selectedHammalName = '';
  bool isLoading = false;
  List<Transport> transports = [];
  List<Hammal> hammals = [];

  ManageInvoiceServices invoiceServices = ManageInvoiceServices();
  DropdownServices dropdownServices = DropdownServices();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getTransports();
    _getHammals();
    selectedDate = DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
     var errorTransport = submitted == true ? selectedTransport == null ? 'Transport is required' : null : null,
         errorHammal = submitted == true ? selectedHammal == null ? 'Hammal is required' : null : null;
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
                width: Dimensions.screenWidth,
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
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
              BigText(text: 'Select Transport', size: Dimensions.font12,),
              Gap(Dimensions.height10/2),
              CustomApiDropdown(
                  hintText: 'Select Transport',
                  dropdownItems: transports.map((e) => DropdownMenuItem<dynamic>(value: e.transportId!, child: BigText(text: e.transportName!, size: Dimensions.font14,))).toList(),
                  selectedValue: selectedTransport,
                  errorText: errorTransport.toString() != 'null' ? errorTransport.toString() : null,
                  width: Dimensions.screenWidth,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTransportName = transports.firstWhere((element) => element.transportId == newValue).transportName!;
                      selectedTransport = newValue!;
                    });
                  }
              )
            ],
          ),
          SizedBox(height: Dimensions.height15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: 'Select Hammal', size: Dimensions.font12,),
              Gap(Dimensions.height10/2),
              CustomApiDropdown(
                  hintText: 'Select Hammal',
                  dropdownItems: hammals.map((e) => DropdownMenuItem<dynamic>(value: e.hammalId!, child: BigText(text: e.hammalName!, size: Dimensions.font14,))).toList(),
                  selectedValue: selectedHammal,
                  errorText: errorHammal.toString() != 'null' ? errorHammal.toString() : null,
                  width: Dimensions.screenWidth,
                  onChanged: (newValue) {
                    setState(() {
                      selectedHammalName = hammals.firstWhere((element) => element.hammalId == newValue).hammalName!;
                      selectedHammal = newValue!;
                    });
                  }
              )
            ],
          ),
        ],
      ),
      actions: [
        CustomElevatedButton(
          onPressed: () {
            setState(() {
              submitted = true;
            });
            setState(() {
              isLoading = !isLoading;
            });
            Map<String, dynamic> body = {
              "user_id": HelperFunctions.getUserID(),
              "invoice_id": widget.invoiceId,
              "sell_id": widget.sellId,
              "transport_date": DateFormat('yyyy-MM-dd').format(selectedDate),
              "transport_id": selectedTransport.toString(),
              "hammal_id": selectedHammal.toString(),
            };

            _addTransportDetail(body);
          },
          buttonText: "Submit",
        )
      ],
    );
  }

  Future<void> _getTransports() async {
    DropdownTransportListModel? response = await dropdownServices.transportList();
    if (response != null) {
      setState(() {
        transports.addAll(response.data!);
        isLoading = false;
      });
    }
  }

  Future<void> _getHammals() async {
    DropdownHammalListModel? response = await dropdownServices.hammalList();
    if (response != null) {
      setState(() {
        hammals.addAll(response.data!);
        isLoading = false;
      });
    }
  }

  Future<void> _addTransportDetail(Map<String, dynamic> body) async {
    try {
      setState(() {
        isLoading = true;
      });
      print("Transport UIBody: $body");

      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        AddTransportDetailModel? addInvoiceModel = await invoiceServices.addTransportDetail((body));
        if (addInvoiceModel?.message != null) {
          if (addInvoiceModel?.success == true) {
            CustomApiSnackbar.show(
              context,
              'Success',
              addInvoiceModel!.message.toString(),
              mode: SnackbarMode.success,
            );
            Navigator.pop(context);
          } else {
            CustomApiSnackbar.show(
              context,
              'Error',
              addInvoiceModel!.message.toString(),
              mode: SnackbarMode.error,
            );
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            'Something went wrong, please try again',
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
      }
    } catch (error) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'An error occurred: $error',
        mode: SnackbarMode.error,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

