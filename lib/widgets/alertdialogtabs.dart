import 'package:antidote/global.dart';
import 'package:antidote/screens/payment.dart';
import 'package:antidote/widgets/shadebutton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertDialogTabs extends StatefulWidget {
  @override
  _AlertDialogTabsState createState() => _AlertDialogTabsState();
}

class _AlertDialogTabsState extends State<AlertDialogTabs>
    with SingleTickerProviderStateMixin {
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: new Scaffold(
        body: new ListView(
          children: <Widget>[
            new TabBar(
              unselectedLabelColor: AppColors.blue,
              indicatorColor: AppColors.blue,
              controller: _controller,
              labelColor: AppColors.blue,
              tabs: [
                new Tab(
                  text: 'Select Day',
                ),
                new Tab(
                  text: 'Select Time',
                ),
              ],
            ),
            new Container(
              height: 200,
              child: new TabBarView(
                controller: _controller,
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Text(
                        "\tSelect Your Day",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ShadeButton(
                            buttonName: sunday,
                            width: 90,
                            buttonText: "Sunday",
                          ),
                          ShadeButton(
                            buttonName: monday,
                            width: 90,
                            buttonText: "Monday",
                          ),
                          ShadeButton(
                            buttonName: tuesday,
                            width: 90,
                            buttonText: "Tuesday",
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ShadeButton(
                            buttonName: wednesday,
                            width: 90,
                            buttonText: "Wednesday",
                          ),
                          ShadeButton(
                            buttonName: thursday,
                            width: 90,
                            buttonText: "Thursday",
                          ),
                          ShadeButton(
                            buttonName: friday,
                            width: 90,
                            buttonText: "Friday",
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Spacer(),
                          ShadeButton(
                            buttonName: saturday,
                            width: 90,
                            buttonText: "Saturday",
                          ),
                          Spacer(),
                          ShadeButton(
                            buttonName: sunday,
                            width: 90,
                            buttonText: "Sunday",
                          ),
                          Spacer(
                            flex: 25,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Spacer(
                            flex: 5,
                          ),
                          Image(
                            image: AppImages.notAvailable,
                            height: 10,
                            width: 10,
                          ),
                          Spacer(),
                          AutoSizeText("Not Available"),
                          Spacer(
                            flex: 3,
                          ),
                          Image(
                            image: AppImages.available,
                            height: 10,
                            width: 10,
                          ),
                          Spacer(),
                          AutoSizeText("Not Available"),
                          Spacer(
                            flex: 3,
                          ),
                          Image(
                            image: AppImages.selectedDay,
                            height: 10,
                            width: 10,
                          ),
                          Spacer(),
                          AutoSizeText("Not Available"),
                          Spacer(
                            flex: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView(
                    children: <Widget>[
                      Text(
                        "\tSelect Your Time",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ShadeButton(
                            buttonName: sunday,
                            width: 90,
                            buttonText: "11:00 AM",
                          ),
                          ShadeButton(
                            buttonName: monday,
                            width: 90,
                            buttonText: "1:00 AM",
                          ),
                          ShadeButton(
                            buttonName: tuesday,
                            width: 90,
                            buttonText: "1:00 PM",
                          )
                        ],
                      ),
                      SizedBox(
                        height: 75,
                      ),
                      Container(
                        height: 40,
                        child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: AutoSizeText(
                                "Proceed To Payment",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Payment()));
                              },
                            )),
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
