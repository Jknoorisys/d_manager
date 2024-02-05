import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/manage_masters/manage_yarn_type/yarn_type_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class YarnTypeList extends StatefulWidget {
  const YarnTypeList({Key? key}) : super(key: key);

  @override
  _YarnTypeListState createState() => _YarnTypeListState();
}

class _YarnTypeListState extends State<YarnTypeList> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> yarnTypeList = [
    {'no': 1, 'yarnName': 'Golden', 'yarnType' : 'Roto', 'status': true},
    {'no': 2, 'yarnName': 'Bhilosa', 'yarnType' : 'Zero', 'status': false},
    {'no': 3, 'yarnName': 'Silver', 'yarnType' : 'Dzero', 'status': true},
  ];

  List<Map<String, dynamic>> filteredYarnTypeList = [];

  @override
  void initState() {
    super.initState();
    filteredYarnTypeList = yarnTypeList;
  }
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: CustomBody(
          content: Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).yarnTypeList, style: AppTheme.headline ),
                SizedBox(height: Dimensions.height10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          isFilled: false,
                          controller: searchController,
                          hintText: S.of(context).searchYarnType,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            searchController.clear();
                            setState(() {
                              filteredYarnTypeList = yarnTypeList;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              filteredYarnTypeList = yarnTypeList
                                  .where((firm) =>
                              firm['yarnName']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                                  firm['yarnType']
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const YarnTypeAdd();
                            },
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                AppTheme.divider,
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredYarnTypeList.length,
                    itemBuilder: (context, index) {
                      return CustomAccordion(
                        titleChild: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.width10),
                                CircleAvatar(
                                  backgroundColor: AppTheme.secondary,
                                  radius: Dimensions.height20,
                                  child: BigText(text: filteredYarnTypeList[index]['yarnName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: filteredYarnTypeList[index]['yarnName'], color: AppTheme.primary, size: Dimensions.font16),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: BigText(text: filteredYarnTypeList[index]['yarnType'][0], color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: filteredYarnTypeList[index]['yarnType'], color: AppTheme.black, size: Dimensions.font12),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                          ],
                        ),
                        contentChild: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoColumn('', filteredYarnTypeList[index]['status'] ? 'Active' : 'Inactive'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return YarnTypeAdd(yarnTypeData: filteredYarnTypeList[index]);
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            filteredYarnTypeList.removeAt(index);
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
                                          filteredYarnTypeList[index]['status'] = value;
                                        });
                                      },
                                      value: filteredYarnTypeList[index]['status'],
                                      inactiveIcon: null,
                                    ),
                                  ],
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
