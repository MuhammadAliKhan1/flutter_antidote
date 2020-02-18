import 'package:antidote/global.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SafeArea(
              child: AppBar(
                leading: Container(),
                elevation: 1,
                backgroundColor: Colors.white,
                flexibleSpace: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.blue,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      AutoSizeText(
                        "Complete Payment",
                        style: GoogleFonts.roboto(
                            color: AppColors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            )),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AutoSizeText("\tTotal Amount to be paid",
                      style: GoogleFonts.roboto(fontSize: 15)),
                  AutoSizeText("\$ 54.00",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: AppColors.seaGreen,
                      )),
                ],
              ),
              Divider(
                thickness: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText("\tPayment Method",
                    style: GoogleFonts.roboto(
                        fontSize: 15, color: AppColors.lightGrey)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: AppColors.blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image(
                          image: AppImages.pay,
                          height: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.width / 8,
                        ),
                        AutoSizeText("Credit or Debit\n\t\t\t\t\t\t\tCard",
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image(
                          image: AppImages.paypalLogo,
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 7,
                        ),
                        AutoSizeText("Papypal",
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: AppColors.lightGrey,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
            ]));
  }
}
