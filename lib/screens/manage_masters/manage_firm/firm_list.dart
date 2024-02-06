import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class FirmList extends StatefulWidget {
  const FirmList({Key? key}) : super(key: key);

  @override
  _FirmListState createState() => _FirmListState();
}

class _FirmListState extends State<FirmList> {
  final searchController = TextEditingController();
  List<Map<String, dynamic>> firmList = [
    {'no': 1, 'myFirm': 'Danish Textiles' ,'partyName': 'Mahesh Textiles','address':'Malegaon','gstNumber':'27ABCDE1234F1Z9','phoneNumber':'9632587412', 'groupCode' : '96GH78', 'status': false},
    {'no': 2, 'myFirm': 'Danish Textiles' ,'partyName': 'Tulsi Tex','address':'Malegaon','gstNumber':'27ABCDE1234F1Z9','phoneNumber':'9632587412', 'groupCode' : '96GH78', 'status': false},
    {'no': 3, 'myFirm': 'Danish Textiles' ,'partyName': 'Laxmi Traders','address':'Malegaon','gstNumber':'27ABCDE1234F1Z9','phoneNumber':'9632587412', 'groupCode' : '96GH78', 'status': true},
    {'no': 4, 'myFirm': 'Danish Textiles' ,'partyName': 'Mahalaxmi Textiles','address':'Malegaon','gstNumber':'27ABCDE1234F1Z9','phoneNumber':'9632587412', 'groupCode' : '96GH78', 'status': true},
    {'no': 5, 'myFirm': 'Danish Textiles' ,'partyName': 'Veenapani Textile','address':'Malegaon','gstNumber':'27ABCDE1234F1Z9','phoneNumber':'9632587412', 'groupCode' : '96GH78', 'status': false},
    {'no': 6, 'myFirm': 'Danish Textiles' ,'partyName': 'SS Textile','address':'Malegaon','gstNumber':'27ABCDE1234F1Z9','phoneNumber':'9632587412', 'groupCode' : '96GH78', 'status': true},
  ];

  List<Map<String, dynamic>> filteredFirmList = [];

  @override
  void initState() {
    super.initState();
    filteredFirmList = firmList;
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).firmList,
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        isFilled: false,
                        controller: searchController,
                        hintText: S.of(context).searchFirm,
                        prefixIcon: Icons.search,
                        suffixIcon: Icons.close,
                        borderRadius: Dimensions.radius10,
                        borderColor: AppTheme.primary,
                        onSuffixTap: () {
                          searchController.clear();
                          setState(() {
                            filteredFirmList = firmList;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            filteredFirmList = firmList
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
                        Navigator.of(context).pushNamed(AppRoutes.firmAdd);
                      }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredFirmList.length,
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
                                      child: BigText(text: filteredFirmList[index]['myFirm'][0], color: AppTheme.primary, size: Dimensions.font18),
                                    ),
                                    SizedBox(width: Dimensions.height10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        BigText(text: filteredFirmList[index]['myFirm'], color: AppTheme.primary, size: Dimensions.font16),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppTheme.black,
                                              radius: Dimensions.height10,
                                              child: BigText(text: filteredFirmList[index]['partyName'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                            ),
                                            SizedBox(width: Dimensions.width10),
                                            SmallText(text: filteredFirmList[index]['partyName'], color: AppTheme.black, size: Dimensions.font12),
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
                          ],
                        ),
                        contentChild: Column(
                          children: [
                            AppTheme.divider,
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Address', filteredFirmList[index]['address']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('GST Number', filteredFirmList[index]['gstNumber']),
                                SizedBox(width: Dimensions.width20),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Phone Number', filteredFirmList[index]['phoneNumber']),
                                SizedBox(width: Dimensions.width20),
                                _buildInfoColumn('Group Code', filteredFirmList[index]['groupCode']),
                                SizedBox(width: Dimensions.width20),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                _buildInfoColumn('Status', filteredFirmList[index]['status'] ? 'Active' : 'Inactive'),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(AppRoutes.firmAdd, arguments: {'firmData': filteredFirmList[index]});
                                    },
                                    icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        filteredFirmList.removeAt(index);
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
                                      filteredFirmList[index]['status'] = value;
                                    });
                                  },
                                  value: filteredFirmList[index]['status'],
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
          )
        ),
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
}
