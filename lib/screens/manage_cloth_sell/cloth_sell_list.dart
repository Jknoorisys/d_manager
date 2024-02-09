import 'package:d_manager/api/manage_sell_deals.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/custom_dropdown.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:intl/intl.dart';

import '../../models/sell_deal_list_model.dart';

class ClothSellList extends StatefulWidget {
  const ClothSellList({Key? key}) : super(key: key);

  @override
  _ClothSellListState createState() => _ClothSellListState();
}

class _ClothSellListState extends State<ClothSellList> {
  final dio = Dio();
  SellDealDetails sellDealDetails = SellDealDetails();
  final searchController = TextEditingController();
  // List<Map<String, dynamic>> unFilteredClothSellList = [
  //   {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mahesh Textiles','clothQuality':'5 - Kilo','totalThan':'500','thanDelivered':'100','thanRemaining':'400','rate':'150', 'status': 'On Going'},
  // ];
  SellDealListModel? sellDealListModel;
  List<SellListData> clothSellList = [];

  String myFirm = 'Danish Textiles';
  String partyName = 'Mahesh Textiles';
  String clothQuality = '5 - Kilo';
  String status = 'On Going';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await getSellDealList();
    } catch (e) {
      print("Error during initialization: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content:
        CustomBody(
          title: S.of(context).clothSellList,
          filterButton: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
          ),
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          isFilled: false,
                          controller: searchController,
                          hintText: 'Search here...',
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            searchController.clear();
                            setState(() {
                              clothSellList;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              clothSellList
                                  .where((firm) => firm.partyName!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                                  firm.firmName!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          }
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    CustomIconButton(
                        radius: Dimensions.radius10,
                        backgroundColor: AppTheme.primary,
                        iconColor: AppTheme.white,
                        iconData: Icons.add,
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.clothSellAdd);
                        }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: ListView.builder(
                    itemCount: clothSellList.length,
                    itemBuilder: (context, index) {
                      return CustomAccordion(
                        titleChild: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  children: [
                                    SizedBox(width: Dimensions.width10),
                                    CircleAvatar(
                                      backgroundColor: AppTheme.secondary,
                                      radius: Dimensions.height20,
                                      child: BigText(text: clothSellList[index].firmName![0], color: AppTheme.primary, size: Dimensions.font18),
                                    ),
                                    SizedBox(width: Dimensions.height10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: clothSellList[index].firmName!, color: AppTheme.primary, size: Dimensions.font16),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: BigText(text: clothSellList[index].firmId![0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: clothSellList[index].firmId!, color: AppTheme.black, size: Dimensions.font12),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.height10),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            AppTheme.divider,
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Deal Date', clothSellList[index].sellDate!),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Cloth Quality', clothSellList[index].qualityName!),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Total Than', clothSellList[index].totalThan!),
                              ],
                            ),
                          ],
                        ),
                        contentChild: Column(
                          children: [
                            Row(
                              children: [
                                _buildInfoColumn('Than Delivered', clothSellList[index].thanDelivered!),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Than Remaining', clothSellList[index].thanRemaining!),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Rate', clothSellList[index].rate!),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Status', clothSellList[index].dealStatus!),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.clothSellView, arguments: {'clothSellData': clothSellList[index]});
                                    },
                                    icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary)
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.clothSellAdd, arguments: {'clothSellData': clothSellList[index]});
                                    },
                                    icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        clothSellList.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete_outline, color: AppTheme.primary)
                                ),
                                GFCheckbox(
                                  size: Dimensions.height20,
                                  type: GFCheckboxType.custom,
                                  inactiveBgColor: AppTheme.nearlyWhite,
                                  inactiveBorderColor: AppTheme.primary,
                                  customBgColor: AppTheme.primary,
                                  activeBorderColor: AppTheme.primary,
                                  onChanged: (value) {
                                    setState(() {
                                      clothSellList[index].dealStatus = value == true ? 'Completed' : 'On Going';
                                    });
                                  },
                                  value: clothSellList[index].dealStatus == 'Completed' ? true : false,
                                  inactiveIcon: null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, color: AppTheme.grey, size: Dimensions.font12),
          BigText(text: value, color: AppTheme.primary, size: Dimensions.font14),
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
                        dropdownItems: ['Mahesh Textiles', 'Danish Textiles', 'SS Textiles', 'Laxmi Traders'],
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
                        dropdownItems: ['5 - Kilo', '6 - Kilo', '5/200'],
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
                      BigText(text: 'Status', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      CustomDropdown(
                        dropdownItems: ['On Going', 'Completed'],
                        selectedValue: status,
                        onChanged: (newValue) {
                          setState(() {
                            status = newValue!;
                          });
                        },
                      ),
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

    Future<SellDealListModel?> getSellDealList() async {
      SellDealListModel? model = await sellDealDetails.sellDealListApi();
      print("model=== $model");
      if (model?.success == true) {
        print(model!.message!);
      }else{
        print(model?.message!);
      }
    }
}
