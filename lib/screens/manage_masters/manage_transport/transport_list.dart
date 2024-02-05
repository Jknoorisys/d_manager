import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/manage_masters/manage_transport/transport_add.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/custom_accordion.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:d_manager/screens/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class TransportList extends StatefulWidget {
  const TransportList({Key? key}) : super(key: key);

  @override
  _TransportListState createState() => _TransportListState();
}

class _TransportListState extends State<TransportList> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> transportList = [
    {'no': 1, 'transportName': 'Kamal Carrier', 'phoneNumber' : '963258741', 'description' : 'Kamal Carrier is one of the leading Service Provider of Packers Movers Services, Transportation Services, Goods Relocation Services etc.', 'status': true},
    {'no': 2, 'transportName': 'Yadav Brothers India', 'phoneNumber' : '9632587415', 'description' : 'We Yadav Brothers is well known name in packers and movers, transport & logistics industry from more than 20 years to provide Best in class services.', 'status': true},
    {'no': 3, 'transportName': 'Kamdhenu Cargo Carriers', 'phoneNumber' : '9874563214', 'description' : 'Kamdhenu Cargo Carriers - Service Provider of transportation services, transport service & other services in Delhi.', 'status': true},
  ];
  List<Map<String, dynamic>> filteredTransportList = [];

  @override
  void initState() {
    super.initState();
    filteredTransportList = transportList;
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
                Text(S.of(context).transportList, style: AppTheme.headline ),
                SizedBox(height: Dimensions.height10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          isFilled: false,
                          controller: searchController,
                          hintText: S.of(context).searchTransport,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.close,
                          borderRadius: Dimensions.radius10,
                          borderColor: AppTheme.primary,
                          onSuffixTap: () {
                            searchController.clear();
                            setState(() {
                              filteredTransportList = transportList;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              filteredTransportList = transportList
                                  .where((firm) =>
                                  firm['transportName']
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
                              return const TransportAdd();
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
                    itemCount: filteredTransportList.length,
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
                                  child: BigText(text: filteredTransportList[index]['transportName'][0], color: AppTheme.primary, size: Dimensions.font18),
                                ),
                                SizedBox(width: Dimensions.height10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    BigText(text: filteredTransportList[index]['transportName'], color: AppTheme.primary, size: Dimensions.font16),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.black,
                                          radius: Dimensions.height10,
                                          child: Icon(Icons.phone, color: AppTheme.secondaryLight, size: Dimensions.font12),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        SmallText(text: filteredTransportList[index]['phoneNumber'], color: AppTheme.black, size: Dimensions.font12),
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
                            _buildInfoColumn('Description', filteredTransportList[index]['description']),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoColumn('', filteredTransportList[index]['status'] ? 'Active' : 'Inactive'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return TransportAdd(transportData: filteredTransportList[index]);
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.edit_outlined, color: AppTheme.primary)
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            filteredTransportList.removeAt(index);
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
                                          filteredTransportList[index]['status'] = value;
                                        });
                                      },
                                      value: filteredTransportList[index]['status'],
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
