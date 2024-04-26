import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/manage_history/unpaid_history/unpaid_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UnpaidHistoryCard extends StatelessWidget {
  final String? value;
  final String? image;
  const UnpaidHistoryCard({Key? key, this.value, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unpaidProvider = Provider.of<UnpaidProvider>(context);

    String totalUnpaidAmount = unpaidProvider.totalUnpaidAmount;
    return SizedBox(
      height: Dimensions.height60*4,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:
            Container(
              height: Dimensions.height50*4,
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius30),
                  bottomRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child:
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height15, horizontal: Dimensions.height30),
                child: Text('Unpaid History', style: AppTheme.headline),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height25*2, // Adjust this value to position the second container
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height30),
              child: Container(
                height: Dimensions.height40*4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppTheme.white,
                  image: const DecorationImage(
                    image: AssetImage(AppImages.cardBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            image ?? AppImages.purchaseIcon,
                            width: Dimensions.height50,
                            height: Dimensions.height50,
                          ),
                          SizedBox(width: Dimensions.width10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).totalUnpaidAmount,
                                  style: AppTheme.title.copyWith(color: AppTheme.white)),
                              Row(
                                children: [
                                  const Icon(Icons.currency_rupee,
                                    color: AppTheme.secondary,),
                                  Text(totalUnpaidAmount ?? "0.00" ,style: AppTheme.title.copyWith(color: AppTheme.secondary))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Till Date', style: AppTheme.title.copyWith(color: AppTheme.white)),
                              Text(DateFormat('dd-MM-yyyy').format(DateTime.now()), style: AppTheme.title.copyWith(color: AppTheme.secondary)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
