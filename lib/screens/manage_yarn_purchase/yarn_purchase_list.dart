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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class YarnPurchaseList extends StatefulWidget {
  const YarnPurchaseList({Key? key}) : super(key: key);

  @override
  _YarnPurchaseListState createState() => _YarnPurchaseListState();
}

class _YarnPurchaseListState extends State<YarnPurchaseList> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> unFilteredYarnPurchaseList = [
    {'no': 1, 'dealDate': '2024-01-25','myFirm': 'Danish Textiles','partyName': 'Mehta and Sons Yarn Trades','yarnName':'Golden','yarnType':'Roto','paymentType':'Current','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.00','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 2, 'dealDate': '2024-01-26','myFirm': 'Danish Textiles','partyName': 'SS Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Dhara','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.12','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 3, 'dealDate': '2024-01-27','myFirm': 'Danish Textiles','partyName': 'Nageena Textile','yarnName':'Golden','yarnType':'Roto','paymentType':'Current','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'22.98','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'Completed'},
    {'no': 4, 'dealDate': '2024-01-28','myFirm': 'Danish Textiles','partyName': 'Bluesky Cloth Sale','yarnName':'Golden','yarnType':'Roto','paymentType':'Current','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'25.45','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'On Going'},
    {'no': 5, 'dealDate': '2024-01-29','myFirm': 'Danish Textiles','partyName': 'Suntex Textiles','yarnName':'Golden','yarnType':'Roto','paymentType':'Dhara','lotNumber':'25','boxOrdered':'300','boxDelivered':'100','boxRemaining':'200','cops':'2000','rate':'24.62','totalNetWeight':'4950', 'grossWeight' : '500', 'Deiner':'30','status':'Completed'},
  ];

  List<Map<String, dynamic>> yarnPurchaseList = [];

  String myFirm = 'Danish Textiles';
  String partyName = 'Mehta and Sons Yarn Trades';
  String yarnName = 'Golden';
  String yarnType = 'Roto';
  String status = 'On Going';

  @override
  void initState() {
    super.initState();
    yarnPurchaseList = unFilteredYarnPurchaseList;
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).yarnPurchasesList,
          filterButton: GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: const FaIcon(FontAwesomeIcons.sliders, color: AppTheme.black),
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
                          hintText: 'Search here...',
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            searchController.clear();
                            setState(() {
                              yarnPurchaseList = unFilteredYarnPurchaseList;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              yarnPurchaseList = unFilteredYarnPurchaseList
                                  .where((firm) =>
                              firm['partyName']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                                  firm['myFirm']
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
                          Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseAdd);
                        }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: ListView.builder(
                    itemCount: yarnPurchaseList.length,
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
                                      child: BigText(text: yarnPurchaseList[index]['partyName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                    ),
                                    SizedBox(width: Dimensions.height10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: yarnPurchaseList[index]['partyName'], color: AppTheme.primary, size: Dimensions.font16),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: BigText(text: yarnPurchaseList[index]['myFirm'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: yarnPurchaseList[index]['myFirm'], color: AppTheme.black, size: Dimensions.font12),
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
                                _buildInfoColumn('Deal Date', yarnPurchaseList[index]['dealDate']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Yarn Name', yarnPurchaseList[index]['yarnName']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Yarn Type', yarnPurchaseList[index]['yarnType']),
                              ],
                            ),
                          ],
                        ),
                        contentChild: Column(
                          children: [
                            Row(
                              children: [
                                _buildInfoColumn('Payment Type', yarnPurchaseList[index]['paymentType']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Lot Number', yarnPurchaseList[index]['lotNumber']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Box Ordered', yarnPurchaseList[index]['boxOrdered']),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Box Delivered', yarnPurchaseList[index]['boxDelivered']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Box Remaining', yarnPurchaseList[index]['boxRemaining']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Cops', yarnPurchaseList[index]['cops']),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Deiner', yarnPurchaseList[index]['Deiner']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Status', yarnPurchaseList[index]['status']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('', ''),
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
                                        BigText(text: 'Total Net Weight', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: AppTheme.primary,
                                              fontSize: Dimensions.font18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: yarnPurchaseList[index]['totalNetWeight'],
                                              ),
                                              TextSpan(
                                                text: ' kg',
                                                style: TextStyle(
                                                  fontSize: Dimensions.font12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BigText(text: 'Gross Weight ${yarnPurchaseList[index]['grossWeight']} kg', color: AppTheme.nearlyBlack, size: Dimensions.font12),
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
                                        BigText(text: 'Rate', color: AppTheme.nearlyBlack, size: Dimensions.font12),
                                        BigText(text: '₹ ${yarnPurchaseList[index]['rate']}',color: AppTheme.primary, size: Dimensions.font18)
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseView, arguments: {'yarnPurchaseData': yarnPurchaseList[index]});
                                    },
                                    icon: const Icon(Icons.visibility_outlined, color: AppTheme.primary)
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.yarnPurchaseAdd, arguments: {'yarnPurchaseData': yarnPurchaseList[index]});
                                    },
                                    icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        yarnPurchaseList.removeAt(index);
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
                                      yarnPurchaseList[index]['status'] = value == true ? 'Completed' : 'On Going';
                                    });
                                  },
                                  value: yarnPurchaseList[index]['status'] == 'Completed' ? true : false,
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
                        dropdownItems: ['Mahesh Textiles', 'Danish Textiles', 'SS Textiles and Sons', 'Laxmi Traders'],
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
                        dropdownItems: ['SS Textile', 'Nageena Textile', 'Mehta and Sons Yarn Trades', 'Bluesky Cloth Sale', 'Suntex Textiles'],
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
                      BigText(text: 'Select Yarn Name', size: Dimensions.font12,),
                      Gap(Dimensions.height10/2),
                      CustomDropdown(
                        dropdownItems: ['Bhilosa', 'Golden', 'Silver'],
                        selectedValue: yarnName,
                        onChanged: (newValue) {
                          setState(() {
                            yarnName = newValue!;
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
}
