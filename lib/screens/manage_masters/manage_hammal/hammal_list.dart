import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/manage_masters/manage_hammal/hammal_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class HammalList extends StatefulWidget {
  const HammalList({Key? key}) : super(key: key);

  @override
  _HammalListState createState() => _HammalListState();
}

class _HammalListState extends State<HammalList> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> hammalList = [
    {'no': 1, 'hammalName': 'Kamlesh', 'phoneNumber' : '963258741', 'description' : 'Hardworking and reliable. Has several years of experience in various types of manual labor. Known for attention to detail and ability to handle challenging tasks.', 'status': true},
    {'no': 2, 'hammalName': 'Sami Khan', 'phoneNumber' : '7412589632', 'description' : 'Experienced in heavy lifting and physical endurance tasks. Specializes in handling heavy machinery and equipment.', 'status': true},
    {'no': 3, 'hammalName': 'Prakash', 'phoneNumber' : '9874563215', 'description' : 'Punctual and diligent worker. Skilled in various construction tasks and project coordination.', 'status': true},
  ];
  List<Map<String, dynamic>> filteredHammalList = [];

  @override
  void initState() {
    super.initState();
    filteredHammalList = hammalList;
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
                Text(S.of(context).hammalList, style: AppTheme.headline ),
                SizedBox(height: Dimensions.height10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          isFilled: false,
                          controller: searchController,
                          hintText: S.of(context).searchHammal,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            searchController.clear();
                            setState(() {
                              filteredHammalList = hammalList;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              filteredHammalList = hammalList
                                  .where((firm) =>
                                  firm['hammalName']
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
                              return const HammalAdd();
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
                    itemCount: filteredHammalList.length,
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
                                  child: BigText(text: filteredHammalList[index]['hammalName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: filteredHammalList[index]['hammalName'], color: AppTheme.primary, size: Dimensions.font16),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: Icon(Icons.phone, color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: filteredHammalList[index]['phoneNumber'], color: AppTheme.black, size: Dimensions.font12),
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
                            AppTheme.divider,
                            SizedBox(height: Dimensions.height10),
                            _buildInfoColumn('Description', filteredHammalList[index]['description']),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoColumn('', filteredHammalList[index]['status'] ? 'Active' : 'Inactive'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return HammalAdd(hammalData: filteredHammalList[index]);
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            filteredHammalList.removeAt(index);
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
                                          filteredHammalList[index]['status'] = value;
                                        });
                                      },
                                      value: filteredHammalList[index]['status'],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: title, color: AppTheme.primary, size: Dimensions.font14),
        SmallText(text: value, color: AppTheme.grey, size: Dimensions.font12),
      ],
    );
  }
}
