import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../api/manage_history_services.dart';
import '../../helpers/helper_functions.dart';
import '../../models/dropdown_models/dropdown_yarn_list_model.dart';
import '../../models/history_models/purchase_history_model.dart';
import '../manage_yarn_purchase/yarn_purchase_view.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/snackbar.dart';
import 'package:d_manager/api/manage_sell_deals.dart';
import '../../models/sell_models/active_parties_model.dart';
import '../../models/sell_models/sell_deal_list_model.dart';
import '../widgets/new_custom_dropdown.dart';
import '../../api/dropdown_services.dart';
import '../../api/manage_firm_services.dart';
import '../../api/manage_party_services.dart';
import '../../models/dropdown_models/dropdown_cloth_quality_list_model.dart';
import '../../models/sell_models/active_firms_model.dart';
class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> purchaseHistory = [
    {'no': 1, 'dealDate': '2024-01-25', 'myFirm': 'Danish Textiles', 'partyName': 'Mehta and Sons Yarn Traders', 'yarnName':'Golden', 'yarnType':'Roto', 'lotNumber':'25', 'paymentType':'Dhara', 'boxReceived':'300', 'rate':'22.20', 'netWeight':'4990', 'billAmount':'25,00,000', 'GST12%':'12%', 'dueDate':'2024-01-29', 'paidDate':'2024-01-25', 'amountPaid' : '25,00,000', 'differenceAmount':'300','paymentMethod':'Cheque', 'cops' : '4000', 'diener':'34', 'billReceived':'Yes',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Rathi Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Tulsi Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Rahun Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'SK Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Diamond Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
    {'no': 2, 'dealDate': '2024-01-26', 'myFirm': 'Danish Textiles', 'partyName': 'Rathi Yarn Agency', 'yarnName':'Bhilosa', 'yarnType':'Zero', 'lotNumber':'289', 'paymentType':'Current', 'boxReceived':'350', 'rate':'21.20', 'netWeight':'6900', 'billAmount':'28,00,000', 'GST12%':'12%', 'dueDate':'2024-01-24', 'paidDate':'2024-01-25', 'amountPaid' : '28,00,000', 'differenceAmount':'1000', 'paymentMethod':'Cheque', 'cops' : '5500', 'diener':'30', 'billReceived':'No',},
  ];
  List<PurchaseHistoryList> purchaseHistoryList = [];
  String myFirm = 'Danish Textiles';
  String partyName = 'Mehta and Sons Yarn Trades';
  String yarnName = 'Golden';
  String yarnType = 'Roto';

  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 30));
  ManageHistoryServices manageHistoryServices = ManageHistoryServices();
  bool isLoading = false;
  int currentPage = 1;
  final RefreshController _refreshController = RefreshController();

  SellDealDetails sellDealDetails = SellDealDetails();

  SellDealListModel? sellDealListModel;

  List<SellDeal> clothSellList = [];

  ManageFirmServices firmServices = ManageFirmServices();

  ManagePartyServices partyServices = ManagePartyServices();

  DropdownServices dropdownServices = DropdownServices();

  List<ActiveFirmsList> firms = [];

  List<ActivePartiesList> parties = [];

  List<ClothQuality> activeClothQuality = [];

  List<Yarn> yarns = [];

  ActiveFirmsList? selectedFirm;

  ActivePartiesList? selectedParty;

  ClothQuality? selectedClothQuality;

  String? firmID;

  String? partyID;

  String? clothID;
  var selectedYarn;

  HelperFunctions helperFunctions = HelperFunctions();

  bool isFilterApplied = false;
  DateTime firstDateForPurchase = DateTime(2000);
  DateTime lastDateForPurchase = DateTime(2050);




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
      getPurchaseHistory(currentPage, searchController.text.trim());
    }
    _loadData();
    _loadPartyData();
    _getYarns();
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          isLoading: isLoading,
            title: S.of(context).purchaseHistory,
            filterButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.print, color: AppTheme.black),
                SizedBox(width: Dimensions.width20),
                GestureDetector(
                  onTap: () {
                    if (isFilterApplied) {
                      clearFilters();
                      setState(() {
                        isFilterApplied = false; // Reset the filter applied flag
                      });
                    } else {
                      _showBottomSheet(context);
                    }
                  },
                  child:isFilterApplied ?Text(
                    'Clear',
                    style: TextStyle(color: AppTheme.black,fontWeight: FontWeight.bold),
                  ): const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
                ),
              ],
            ),
            content:
            Padding(
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
                                purchaseHistoryList.clear();
                                currentPage = 1;
                                getPurchaseHistory(currentPage, searchController.text.trim());
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                purchaseHistoryList.clear();
                                currentPage = 1;
                                getPurchaseHistory(currentPage, value);
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
                          purchaseHistoryList.clear();
                          currentPage = 1;
                        });
                        getPurchaseHistory(currentPage, searchController.text.trim());
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        getPurchaseHistory(currentPage, searchController.text.trim());
                        _refreshController.loadComplete();
                      },
                      child:
                      ListView.builder(
                        itemCount: purchaseHistoryList.length,
                        itemBuilder: (context, index) {
                          return
                            CustomAccordion(
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
                                                child: BigText(text: purchaseHistoryList[index].partyName![0], color: AppTheme.primary, size: Dimensions.font18),
                                              ),
                                              SizedBox(width: Dimensions.height10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  BigText(text: purchaseHistoryList[index].partyName!, color: AppTheme.primary, size: Dimensions.font16, overflow: TextOverflow.ellipsis,),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: AppTheme.black,
                                                        radius: Dimensions.height10,
                                                        child: BigText(text: purchaseHistoryList[index].firmName![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                                      ),
                                                      SizedBox(width: Dimensions.width10),
                                                      SmallText(text: purchaseHistoryList[index].firmName!, color: AppTheme.black, size: Dimensions.font12),
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
                                      Expanded(flex:1,child: _buildInfoColumn('Deal Date', purchaseHistoryList[index].purchaseDate!.toString())),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Yarn Name', purchaseHistoryList[index].yarnName!)),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Yarn Type', purchaseHistoryList[index].yarnTypeName!)),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      Expanded(flex:1,child: _buildInfoColumn('Lot Number', purchaseHistoryList[index].lotNumber!)),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Total Box', purchaseHistoryList[index].orderedBoxCount!)),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Box Received', purchaseHistoryList[index].deliveredBoxCount!.toString())),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      Expanded(flex:1,child: _buildInfoColumn('Rate', purchaseHistoryList[index].rate!)),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Net Weight', purchaseHistoryList[index].netWeight!)),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Payment Due Date', purchaseHistoryList[index].paymentDueDate!.toString())),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    children: [
                                      Expanded(flex:1,child: _buildInfoColumn('Bill Amount', purchaseHistoryList[index].totalBillAmount!.toString())),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Amount Paid', purchaseHistoryList[index].totalPaidAmount!.toString())),
                                      SizedBox(width: Dimensions.width20),
                                      Expanded(flex:1,child: _buildInfoColumn('Deal Status', purchaseHistoryList[index].dealStatus!.toString())),
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
                                              BigText(text: 'Total Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: AppTheme.primary,
                                                    fontSize: Dimensions.font18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(text: purchaseHistoryList[index].grossWeight!,),
                                                    TextSpan(
                                                      text: ' Ton',
                                                      style: TextStyle(
                                                        fontSize: Dimensions.font12,
                                                      ),
                                                    ),
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
                                              BigText(text: 'Total Weight Received', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                              // BigText(text: '${purchaseHistoryList[index].grossReceivedWeight}',color: AppTheme.primary, size: Dimensions.font18),
                                              // BigText(text: 'Ton',color: AppTheme.primary, size: Dimensions.font12),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: AppTheme.primary,
                                                    fontSize: Dimensions.font18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(text: purchaseHistoryList[index].grossReceivedWeight,),
                                                    TextSpan(
                                                      text: ' Ton',
                                                      style: TextStyle(
                                                        fontSize: Dimensions.font12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                          // Navigator.pushNamed(context, AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': filteredPurchaseHistoryList[index]});
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => YarnPurchaseView(purchaseId:purchaseHistoryList[index].purchaseId!.toString())));
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
    } else if (title == 'Payment Due Date') {
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
      builder: (BuildContext context) =>
        StatefulBuilder(builder: (BuildContext context, StateSetter setState){
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
                    CustomDropdownNew<ActiveFirmsList>(
                      hintText: 'Select Firm',
                      dropdownItems:firms ?? [],
                      selectedValue:selectedFirm,
                      onChanged:(newValue)async{
                        if (newValue != null) {
                          firmID = newValue.firmId.toString();
                          await HelperFunctions.setFirmID(firmID!);
                          print("firmID==== $firmID");
                        } else {
                          await HelperFunctions.setFirmID('');
                          firmID = null; // Reset firmID if selectedFirm is null
                        }
                        setState(()  {
                          selectedFirm = newValue;
                        });
                      } ,
                      displayTextFunction: (ActiveFirmsList? firm) {
                        return firm?.firmName ?? ''; // Ensure you're returning a non-null value
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
                    CustomDropdownNew<ActivePartiesList>(
                      hintText: 'Select Party',
                      dropdownItems:parties ?? [],
                      selectedValue:selectedParty,
                      onChanged:(newValue)async{
                        if (newValue != null) {
                          partyID = newValue.partyId.toString();
                          await HelperFunctions.setPartyID(partyID!);
                          print("partyIDselected===== $partyID");
                        } else {
                          await HelperFunctions.setPartyID('');
                          partyID = null; // Reset firmID if selectedFirm is null
                        }
                        setState((){
                          selectedParty = newValue;
                        });
                      } ,
                      displayTextFunction: (ActivePartiesList? parties){
                        return parties!.partyName!;
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
                    BigText(text: 'Select Yarn Name', size: Dimensions.font12,),
                    Gap(Dimensions.height10/2),
                    CustomApiDropdown(
                        hintText: 'Select Yarn',
                        dropdownItems: yarns.map((e) => DropdownMenuItem<dynamic>(value: e.yarnTypeId!, child: BigText(text: e.yarnName!, size: Dimensions.font14,))).toList(),
                        selectedValue: selectedYarn,
                        onChanged: (newValue) {
                          setState(() {
                            selectedYarn = newValue!;
                          });
                        }
                    )
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
                        DateTimeRange? pickedDateRange = await showDateRangePicker(
                          initialEntryMode: DatePickerEntryMode.input,
                          helpText: S.of(context).selectDate,
                          context: context,
                          initialDateRange: DateTimeRange(
                            start: DateTime.now(),
                            end: DateTime.now().add(const Duration(days: 7)),
                          ),
                          firstDate: firstDateForPurchase,
                          lastDate: lastDateForPurchase,
                        );

                        if (pickedDateRange != null) {
                          DateTime startDateForPurchaseHistory = pickedDateRange.start;
                          DateTime endDateForPurchaseHistory = pickedDateRange.end;
                          String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDateForPurchaseHistory);
                          String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDateForPurchaseHistory);
                          await HelperFunctions.setStartDateForPurchaseHistory(formattedStartDate);
                          await HelperFunctions.setEndDateForPurchaseHistory(formattedEndDate);
                          setState(() {
                            firstDateForPurchase = startDateForPurchaseHistory;
                            lastDateForPurchase = endDateForPurchaseHistory;
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
            ),
            Gap(Dimensions.height25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState((){
                    currentPage = 0;
                    getPurchaseHistory(1, searchController.text  );
                    isFilterApplied = true;
                  });
                },
                buttonText: 'Submit',
              ),
            ),
          ],
        ),
      );
        }
       )
    );
  }
  Future<PurchaseHistoryModel?> getPurchaseHistory(int pageNo, String search,) async {
    setState(() {
      isLoading = true;
    });
    try {
      PurchaseHistoryModel? model = await manageHistoryServices.showPurchaseHistory(
        pageNo.toString(),
        search,
      );

      if (model != null) {
        if (model.success == true) {
          if (model.data!.isNotEmpty) {
            if (pageNo == 1) {
              purchaseHistoryList.clear();
            }
            setState(() {
              purchaseHistoryList.addAll(model.data!);
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
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ActiveFirmsModel? activeFirms = await firmServices.activeFirms();
      if (activeFirms != null) {
        if (activeFirms.success == true) {
          if (activeFirms.data!.isNotEmpty) {
            setState(() {
              firms.clear();
              firms.addAll(activeFirms!.data!);
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            activeFirms.message.toString(),
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
  Future<void> _loadPartyData() async {
    setState(() {
      isLoading = true;
    });
    try {
      ActivePartiesModel? activePartiesModel = await partyServices.activeParties();
      if (activePartiesModel != null) {
        if (activePartiesModel.success == true) {
          if (activePartiesModel.data!.isNotEmpty) {
            setState(() {
              parties.clear();
              parties.addAll(activePartiesModel.data!);
            });
          } else {
            _refreshController.loadNoData();
          }
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            activePartiesModel.message.toString(),
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
  void clearFilters() async {
    // Clear the preferences
    await HelperFunctions.setFirmID('');
    await HelperFunctions.setPartyID('');
    await HelperFunctions.setYarnID('');
    await HelperFunctions.setStartDateForPurchaseHistory('');
    await HelperFunctions.setEndDateForPurchaseHistory('');
    setState(() {
      selectedFirm = null;
      selectedParty = null;
      selectedClothQuality = null;
      selectedYarn = null;
    });
    if (firstDateForPurchase != DateTime(2000) || lastDateForPurchase != DateTime(2050)) {
      setState(() {
        firstDateForPurchase = DateTime(2000);
        lastDateForPurchase = DateTime(2050);
      });
    }
    getPurchaseHistory(1, '');
  }

  Future<void> _getYarns() async {
    DropdownYarnListModel? response = await dropdownServices.yarnList();
    if (response != null) {
      setState(() {
        yarns.addAll(response.data!);
        isLoading = false;
      });
    }
  }
}
