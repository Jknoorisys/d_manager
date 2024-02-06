import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_theme.dart';
import '../../constants/dimension.dart';
import '../../constants/images.dart';
import '../widgets/drawer/zoom_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DashboardHeader extends StatefulWidget {
  const DashboardHeader({ super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      content: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: FaIcon(FontAwesomeIcons.barsStaggered,
                color: AppTheme.primary, size: Dimensions.iconSize24),
          ),
          title: Image.asset(AppImages.appLogoHorizontal, width: Dimensions.width50*5, height: Dimensions.height50*5),
          centerTitle: true,
        ),
        body:
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                  SvgPicture.asset("assets/images/svg/calendar.svg",
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
              top: 70, // Adjust this value to position the second container
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
            const Positioned(
              top: 270, // Adjust this value to position the new container
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: AppTheme.secondary,
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
