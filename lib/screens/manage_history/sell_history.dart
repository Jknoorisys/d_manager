import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../api/manage_history_services.dart';
import '../../helpers/helper_functions.dart';
import '../../models/history_models/sell_history_model.dart';
import '../manage_cloth_sell/cloth_sell_view.dart';
import '../widgets/snackbar.dart';

class SellHistory extends StatefulWidget {
  const SellHistory({super.key});

  @override
  State<SellHistory> createState() => _SellHistoryState();
}

class _SellHistoryState extends State<SellHistory> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> sellHistoryList = [
    {'no': 1, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Kalantri Cloth Traders', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 2, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Pooja Cloth Agency', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 3, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Harshad Textile', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 4, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Veenapani Cloths', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 5, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Aneesa Tex', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
    {'no': 6, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Sarika Textiles', 'clothQuality':'5-kilo', 'invoiceDate':'2024-01-29', 'invoiceNumber':'01', 'baleNumber':'10', 'than':'80', 'meter':'142.90', 'rate':'4990', 'gst':'12%', 'invoiceAmount':'10,09,000', 'paymentType':'Current', 'additionalDiscount':'1000', 'paymentReceived' : '10,08,500', 'differenceAmount':'500', 'paymentMethod':'Cheque', 'dueDate' : '2024-01-20', 'paymentReceivedDate':'2024-01-18', 'reason':'Sorry', 'transportDetails':'abc'},
  ];
  List<SellHistoryModelList> sellHistoryData = [];
  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 30));
  bool isLoading = false;
  ManageHistoryServices manageHistoryServices = ManageHistoryServices();
  int currentPage = 1;
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    if (HelperFunctions.checkInternet() == false) {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No internet connection',
        mode: SnackbarMode.warning,
      );
    } else {
      setState(() {
        isLoading = !isLoading;
      });
      getSellHistory(currentPage, searchController.text.trim());
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading:isLoading,
            title: S.of(context).sellHistory,
            filterButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.print, color: AppTheme.black),
                SizedBox(width: Dimensions.width20),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
                ),
              ],
            ),
            content: Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            isFilled: false,
                            controller: searchController,
                            hintText: S.of(context).searchParty,
                            prefixIcon: Icons.search,
                            suffixIcon: Icons.close,
                            borderRadius: Dimensions.radius10,
                            borderColor: AppTheme.primary,
                            onSuffixTap: () {
                              setState(() {
                                searchController.clear();
                                sellHistoryData.clear();
                                currentPage = 1;
                                getSellHistory(currentPage, searchController.text.trim());
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                sellHistoryData.clear();
                                currentPage = 1;
                                getSellHistory(currentPage, value);
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  AppTheme.divider,
                  Expanded(
                    child:
                    SmartRefresher(
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: () async {
                        setState(() {
                          sellHistoryData.clear();
                          currentPage = 1;
                        });
                        getSellHistory(currentPage, searchController.text.trim());
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        getSellHistory(currentPage, searchController.text.trim());
                        _refreshController.loadComplete();
                      },
                      child:
                      ListView.builder(
                        itemCount: sellHistoryData.length,
                        itemBuilder: (context, index) {
                          return CustomAccordion(
                            titleChild: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      SizedBox(height: Dimensions.height10),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            SizedBox(width: Dimensions.width10),
                                            CircleAvatar(
                                              backgroundColor: AppTheme.secondary,
                                              radius: Dimensions.height20,
                                              child: BigText(text: sellHistoryData[index].partyFirm![0], color: AppTheme.primary, size: Dimensions.font18),
                                            ),
                                            SizedBox(width: Dimensions.height10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                BigText(text: sellHistoryData[index].partyFirm!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: AppTheme.black,
                                                      radius: Dimensions.height10,
                                                      child: BigText(text: sellHistoryData[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                    ),
                                                    SizedBox(width: Dimensions.width10),
                                                    SmallText(text: sellHistoryData[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            contentChild: Column(
                              children: [
                                SizedBox(height: Dimensions.height10),
                                AppTheme.divider,
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Deal Date', sellHistoryData[index].sellDate!.toString())),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Cloth Quality', sellHistoryData[index].qualityName!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Deal Rate',' ₹ ${sellHistoryData[index].rate!}')),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Total Thans', sellHistoryData[index].totalThan!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Than Delivered', sellHistoryData[index].thanDelivered!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Than Remaining', sellHistoryData[index].thanRemaining!)),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Total Meter', sellHistoryData[index].totalMeter!.toString())),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Difference Amount', ' ₹ ${sellHistoryData[index].totalDifferenceAmount!.toString()}')),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Due Date', sellHistoryData[index].sellDueDate!.toString())),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Expanded(flex:1,child: _buildInfoColumn('Total Invoice Amount', ' ₹ ${sellHistoryData[index].totalInvoiceAmount!.toString()}')),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('Status', sellHistoryData[index].dealStatus!)),
                                    SizedBox(width: Dimensions.width20),
                                    Expanded(flex:1,child: _buildInfoColumn('', '')),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width/2.65,
                                        height: Dimensions.height40*2,
                                        padding: EdgeInsets.all(Dimensions.height10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                          border: Border.all(color: AppTheme.primary),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BigText(text: 'Total GST Amount', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: AppTheme.primary,
                                                  fontSize: Dimensions.font18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(text: ' ${sellHistoryData[index].totalGstAmount!.toString()}',),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    SizedBox(width: Dimensions.width20),
                                    Container(
                                        width: MediaQuery.of(context).size.width/2.65,
                                        height: Dimensions.height40*2,
                                        padding: EdgeInsets.all(Dimensions.height10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                          border: Border.all(color: AppTheme.primary),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BigText(text: 'Total Received Amount', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                            BigText(text: '${sellHistoryData[index].totalReceivedAmount!.toString()}',color: AppTheme.primary, size: Dimensions.font18)
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomElevatedButton(
                                      onPressed: (){
                                        // Navigator.pushNamed(context, AppRoutes.clothSellView, arguments: {'clothSellData': filteredSellHistoryList[index]});
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClothSellView(sellID: sellHistoryData[index].sellId!,)));
                                      },
                                      buttonText: 'View Details',
                                      isBackgroundGradient: false,
                                      backgroundColor: AppTheme.primary,
                                      textSize: Dimensions.font14,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                  ),
                ],
              ),
            )
        )
    );
  }
  Widget _buildInfoColumn(String title, String value) {
    String formattedValue = value;
    if (title == 'Deal Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }else if (title == 'Due Date') {
      DateTime date = DateTime.parse(value);
      formattedValue = DateFormat('dd-MMM-yyyy').format(date);
    }
    return Container(
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.nearlyBlack, size: Dimensions.font12),
          BigText(text: formattedValue, color: AppTheme.primary, size: Dimensions.font12),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius20),
          topRight: Radius.circular(Dimensions.radius20),
        ),
      ),
      elevation: 10,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.height20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Select My Firm', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      CustomDropdown(
                        dropdownItems: const ['Mahesh Textiles', 'Danish Textiles', 'SS Textiles', 'Laxmi Traders'],
                        selectedValue: myFirm,
                        onChanged: (newValue) {
                          setState(() {
                            myFirm = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Gap(Dimensions.height10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Select Party Name', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      CustomDropdown(
                        dropdownItems: const ['Mahesh Textiles', 'Tulsi Textiles', 'Laxmi Traders', 'Mahalaxmi Textiles', 'Veenapani Textiles'],
                        selectedValue: partyName,
                        onChanged: (newValue) {
                          setState(() {
                            partyName = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Gap(Dimensions.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Select Cloth Quality', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      CustomDropdown(
                        dropdownItems: const ['5 - Kilo', '6 - Kilo', '5/200'],
                        selectedValue: clothQuality,
                        onChanged: (newValue) {
                          setState(() {
                            clothQuality = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Gap(Dimensions.height10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Filter by Date', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = (
                              await showDateRangePicker(
                                initialEntryMode: DatePickerEntryMode.input,
                                helpText: S.of(context).selectDate,
                                context: context,
                                firstDate: firstDate,
                                lastDate: lastDate,
                              )
                          ) as DateTime?;

                          if (pickedDate != null && pickedDate != firstDate) {
                            setState(() {
                              firstDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          height: Dimensions.height50,
                          width: MediaQuery.of(context).size.width/2.65,
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
                                Expanded(child: BigText(text: '${DateFormat('dd/MM/yyyy').format(firstDate)} to ${DateFormat('dd/MM/yyyy').format(lastDate)}', size: Dimensions.font12,)),
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
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
  Future<SellHistoryModel?> getSellHistory(int pageNo, String search,) async {
    setState(() {
      isLoading = true;
    });
    try {
      SellHistoryModel? model = await manageHistoryServices.showSellHistory(
        pageNo.toString(),
        search,
      );
      if (model != null) {
        if (model.success == true) {
          if (model.data!.isNotEmpty) {
            if (pageNo == 1) {
              sellHistoryData.clear();
            }
            setState(() {
              sellHistoryData.addAll(model.data!);
              currentPage++;
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            model.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again later.',
          mode: SnackbarMode.error,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
