import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class YarnPurchaseAdd extends StatefulWidget {
  final Map<String, dynamic>? yarnPurchaseData;
  const YarnPurchaseAdd({super.key, this.yarnPurchaseData});

  @override
  State<YarnPurchaseAdd> createState() => _YarnPurchaseAddState();
}

class _YarnPurchaseAddState extends State<YarnPurchaseAdd> {
  String deliveryType = 'Current';
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String yarnType = 'Golden';
  String status = 'On Going';
  String dharaOption = '15 days';
  TextEditingController otherDharaController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          content: Padding(
            padding: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10, bottom: Dimensions.height20),
            child: Card(
              elevation: 10,
              color: AppTheme.white,
              shadowColor: AppTheme.nearlyWhite,
              surfaceTintColor: AppTheme.nearlyWhite,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Deal Details",
                        style: AppTheme.heading2,
                      ),
                      Gap(Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
                            },
                            child: Container(
                              height: Dimensions.height50,
                              width: MediaQuery.of(context).size.width/2.65,
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
                                          color: AppTheme.black,
                                          size: Dimensions.font20,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CustomDropdown(
                            dropdownItems: ['Danish Textiles', 'SS Textiles', 'Mahesh Textiles and Sons', 'Laxmi Traders'],
                            selectedValue: myFirm,
                            onChanged: (newValue) {
                              setState(() {
                                myFirm = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Party', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              Container(
                                height: Dimensions.height50,
                                width: MediaQuery.of(context).size.width/2.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: partyName,
                                    onChanged: (newValue) {
                                      setState(() {
                                        partyName = newValue!;
                                      });
                                    },
                                    underline: Container( // Add this line to remove the underline
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    items: ['Mahesh Textiles', 'Laxmi Traders'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: BigText(text: value, size: Dimensions.font14,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Yarn Type', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              Container(
                                height: Dimensions.height50,
                                width: MediaQuery.of(context).size.width/2.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: yarnType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        yarnType = newValue!;
                                      });
                                    },
                                    underline: Container( // Add this line to remove the underline
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    items: ['Golden', 'Bhilosa'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: BigText(text: value, size: Dimensions.font14,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Gap(Dimensions.height10),
                      Text(
                        "Purchase Details",
                        style: TextStyle(fontSize: Dimensions.font18, fontWeight: FontWeight.bold),
                      ),
                      Gap(Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Lot Number', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              AppTextField(
                                hintText: "Enter Lot Number",
                                isSuffixIcon: false,
                                textInputType: TextInputType.number,
                                width: MediaQuery.of(context).size.width/2.65,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Select Delivery Type', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              Container(
                                height: Dimensions.height50,
                                width: MediaQuery.of(context).size.width/2.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: deliveryType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        deliveryType = newValue!;
                                      });
                                    },
                                    underline: Container( // Add this line to remove the underline
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    items: ['Current', 'Dhara'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: BigText(text: value, size: Dimensions.font14,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      if (deliveryType == 'Current')
                        _buildCurrentFields()
                      else
                        _buildDharaFields(),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Net Weight', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              AppTextField(
                                hintText: "Enter Net Weight",
                                isSuffixIcon: false,
                                textInputType: TextInputType.number,
                                width: MediaQuery.of(context).size.width/2.65,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Box Ordered', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              AppTextField(
                                hintText: "Enter Box Ordered",
                                isSuffixIcon: false,
                                textInputType: TextInputType.number,
                                width: MediaQuery.of(context).size.width/2.65,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Denyar', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              AppTextField(
                                hintText: "Enter Denyar",
                                isSuffixIcon: false,
                                textInputType: TextInputType.number,
                                width: MediaQuery.of(context).size.width/2.65,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Status', size: Dimensions.font12,),
                              Gap(Dimensions.height10/2),
                              Container(
                                height: Dimensions.height50,
                                width: MediaQuery.of(context).size.width/2.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: status,
                                    onChanged: (newValue) {
                                      setState(() {
                                        status = newValue!;
                                      });
                                    },
                                    underline: Container( // Add this line to remove the underline
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    items: ['On Going', 'Completed'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: BigText(text: value, size: Dimensions.font14,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Dimensions.height20),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _buildCurrentFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: 'Select Current Payment Date', size: Dimensions.font12,),
        Gap(Dimensions.height10/2),
        GestureDetector(
          onTap: (){
            showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
          },
          child: Container(
            height: Dimensions.height50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(selectedDate),
                    style: TextStyle(fontSize: Dimensions.font14,
                        color: Theme.of(context).disabledColor),
                  ),
                  Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.calendar_month,
                        color: AppTheme.black,
                        size: Dimensions.font20,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDharaFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: 'Select Dhara', size: Dimensions.font12,),
        Gap(Dimensions.height10/2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: '15 days',
              groupValue: dharaOption,
              onChanged: (value) {
                setState(() {
                  dharaOption = value.toString();
                });
              },
            ),
            const Text('15 days'),
            Radio(
              value: '40 days',
              groupValue: dharaOption,
              onChanged: (value) {
                setState(() {
                  dharaOption = value.toString();
                });
              },
            ),
            const Text('40 days'),
            Radio(
              value: 'Other',
              groupValue: dharaOption,
              onChanged: (value) {
                setState(() {
                  dharaOption = value.toString();
                });
              },
            ),
            const Text('Other'),
          ],
        ),
        // Input field for "Other" option
        if (dharaOption == 'Other')
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: 'Select Other Date', size: Dimensions.font12,),
              Gap(Dimensions.height10/2),
              GestureDetector(
                onTap: (){
                  showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);
                },
                child: Container(
                  height: Dimensions.height50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(selectedDate),
                          style: TextStyle(fontSize: Dimensions.font14,
                              color: Theme.of(context).disabledColor),
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              Icons.calendar_month,
                              color: AppTheme.black,
                              size: Dimensions.font20,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(Dimensions.height20),
            ],
          ),
      ],
    );
  }
}
