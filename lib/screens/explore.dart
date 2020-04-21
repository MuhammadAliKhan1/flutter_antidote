import 'dart:convert';

import 'package:antidote/screens/profilefilter.dart';
import 'package:antidote/widgets/alertdialogtabs.dart';
import 'package:antidote/widgets/fullscreenloader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:antidote/global.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('therapists').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> therapistList = snapshot.data.documents;
          return ExploreWidget(
            therapistList: therapistList,
          );
        } else {
          return FullScreenLoader();
        }
      },
    );
  }
}

class ExploreWidget extends StatefulWidget {
  final List<DocumentSnapshot> therapistList;

  const ExploreWidget({Key key, @required this.therapistList})
      : super(key: key);
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState(
        therapistList: this.therapistList,
      );
}

class _ExploreWidgetState extends State<ExploreWidget> {
  bool bookButton = false;
  final List<DocumentSnapshot> therapistList;
  double rating = 4.0;
  Function onTap;

  _ExploreWidgetState({
    Key key,
    @required this.therapistList,
  });

  @override
  void initState() {
    onTap = () async {
      Navigator.of(context).pop();
      try {
        final request = BraintreeDropInRequest(
          tokenizationKey: 'sandbox_q76n8g9b_yytk333f4vk34b8z',
          collectDeviceData: true,
          cardEnabled: true,
          amount: '4.20',
          googlePaymentRequest: BraintreeGooglePaymentRequest(
            totalPrice: '4.20',
            currencyCode: 'USD',
            billingAddressRequired: false,
          ),
          paypalRequest: BraintreePayPalRequest(
            amount: '4.20',
            displayName: 'Example company',
          ),
        );
        BraintreeDropInResult result = await BraintreeDropIn.start(request);
        print(result.paymentMethodNonce.nonce);
        if (result != null) {
          Map<String, String> headers = {"Content-Type": "application/json"};
          Map<String, dynamic> body = {
            'payment_method_nonce': result.paymentMethodNonce.nonce,
            'message': 'data from application'
          };
          http.Response response = await http.post(
            'https://flutter-antidote.herokuapp.com/checkout',
            headers: headers,
            body: jsonEncode(body),
          );
          print(response.body);
        } else {
          print('Selection was canceled.');
        }
      } catch (ex) {
        print(ex);
        Alert(
          context: context,
          type: AlertType.error,
          title: "Oops!",
          desc: "An error has occurred",
          buttons: [
            DialogButton(
              child: Text("DISMISS",
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                      )),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      } finally {
        setState(
          () => isLoading = false,
        );
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: AbsorbPointer(
            child: _buildBody(context),
            absorbing: isLoading,
          ),
        ),
        isLoading ? FullScreenLoader() : Container()
      ],
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              flexibleSpace: Row(
                children: <Widget>[
                  Spacer(),
                  Image(
                    image: AppImages.logo,
                  ),
                  Spacer(),
                  InkWell(
                    child: Image(
                      image: AppImages.gear,
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFilter(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  AutoSizeText("\tTherapist",
                      style: GoogleFonts.roboto(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 40))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: therapistList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          leading: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.height / 12,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AppImages.decentMan,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                child: Image(
                                  image: AppImages.onlineStatus,
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                  width: MediaQuery.of(context).size.width / 30,
                                ),
                              )
                            ],
                          ),
                          title: AutoSizeText(therapistList[index].data['name'],
                              maxLines: 1,
                              style: GoogleFonts.roboto(
                                  color: AppColors.blue, fontSize: 20)),
                          isThreeLine: true,
                          subtitle: Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                AutoSizeText("Sleeping Disorder",
                                    maxLines: 1,
                                    style: GoogleFonts.roboto(
                                        color: AppColors.grey, fontSize: 15)),
                              ]),
                              Row(children: <Widget>[
                                SmoothStarRating(
                                  starCount: 5,
                                  rating: rating,
                                  size: 20,
                                  allowHalfRating: false,
                                  filledIconData: Icons.star,
                                  color: AppColors.blue,
                                  borderColor: AppColors.blue,
                                )
                              ])
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: AutoSizeText("\$ 23.00 / h",
                                      style: GoogleFonts.roboto(
                                          color: AppColors.normalGrey))),
                              Expanded(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: bookButton
                                        ? BorderSide(color: AppColors.blue)
                                        : BorderSide(color: AppColors.blue),
                                  ),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            bookButton
                                                ? AppColors.lightBlue
                                                : Colors.white,
                                            bookButton
                                                ? AppColors.darkBlue
                                                : Colors.white
                                          ],
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                        ),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 100, minHeight: 35.0),
                                      alignment: Alignment.center,
                                      child: AutoSizeText("Book",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: bookButton
                                              ? GoogleFonts.roboto(
                                                  color: Colors.white)
                                              : GoogleFonts.roboto(
                                                  color: AppColors.blue)),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      bookButton = !bookButton;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) => Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            child:
                                                AlertDialogTabs(onTap: onTap),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.1,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
