import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({Key? key}) : super(key: key);

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: Dimensions.screenWidth,
            color: AppTheme.white,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: Dimensions.pageView,
            decoration: BoxDecoration(
              color: AppTheme.secondary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.radius30),
                bottomRight: Radius.circular(Dimensions.radius30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20,top: Dimensions.height20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).dashboard,
                        style: AppTheme.headline,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                          child: Row(
                            children: [
                              Text("Select Date",
                                  style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
                              SizedBox(width: 5,),
                              SvgPicture.asset("assets/images/svg/calender.svg",
                                height: 20,width: 20,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 80, // Adjust this value to position the second container
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
                children:[
                  Container(
                    height: 250,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/icons/bg.png', // Replace with your image asset
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 30),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/svg/purchase_icon.svg',
                                    width: 60, // Set the width as needed
                                    height: 60, // Set the height as needed
                                  ),
                                  SizedBox(width: 10,),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Purchase Amount",
                                        style: TextStyle(color: Colors.white,fontSize: 16),),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Icon(Icons.currency_rupee,
                                            color: AppTheme.secondary,),
                                          Text("1,50,000",style: TextStyle(
                                              color: AppTheme.secondary,fontSize: 20,fontWeight: FontWeight.w900
                                          ),)
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 35,),
                            const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Till Date",
                                        style: TextStyle(color: Colors.white),),
                                      Text("31-01-2024",style: TextStyle(
                                          color: AppTheme.secondary,fontSize: 16,fontWeight: FontWeight.bold
                                      ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}
