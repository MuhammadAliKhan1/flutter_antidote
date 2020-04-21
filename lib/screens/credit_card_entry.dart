import 'dart:convert';

import 'package:antidote/global.dart';
import 'package:antidote/widgets/fullscreenloader.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:awesome_card/extra/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:spring_button/spring_button.dart';
import 'package:http/http.dart' as http;

class CreditCardEntry extends StatefulWidget {
  CreditCardEntry({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CreditCardEntryState createState() => _CreditCardEntryState();
}

class _CreditCardEntryState extends State<CreditCardEntry> {
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String expiryMonth = "";
  String expiryYear = "";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  MaskedTextController creditCardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  MaskedTextController expDateController = MaskedTextController(mask: '00/00');

  CardType cardType;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {});
    cardType = getCardType(cardNumber);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                CreditCard(
                  cardNumber: cardNumber,
                  cardExpiry: expiryDate,
                  cardHolderName: cardHolderName,
                  cardType: cardType,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.white,
                  showShadow: true,
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Card Number"),
                          maxLength: 19,
                          controller: creditCardNumberController,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Input credit card number';
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            cardType = getCardType(cardNumber);
                            setState(() {
                              cardNumber = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Card Expiry"),
                          validator: (value) {
                            if (value.isEmpty) return 'Input expiry date';
                            if (expiryDate.length == 5) {
                              expiryMonth = expiryDate.substring(
                                  0, expiryDate.indexOf('/'));
                              expiryYear = expiryDate.substring(
                                expiryDate.indexOf('/') + 1,
                                expiryDate.length,
                              );
                              if (((DateTime.now().year % 100) >
                                  int.parse(expiryYear))) {
                                if ((DateTime.now().month >
                                    int.parse(expiryMonth))) {
                                  return 'Credit card expired';
                                }
                              }
                            } else {
                              return 'Input complete date';
                            }
                          },
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          controller: expDateController,
                          onChanged: (value) {
                            print(expiryDate);
                            setState(() {
                              expiryDate = expDateController.text;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return 'Input name';
                          },
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              InputDecoration(hintText: "Card Holder Name"),
                          maxLength: 35,
                          onChanged: (value) {
                            setState(() {
                              cardHolderName = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SpringButton(
              SpringButtonType.OnlyScale,
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                  child: Text(
                    'Submit ',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
              onTap: () async {
                if (_formkey.currentState.validate()) {
                  String validatedCardNumber = cardNumber.replaceAll(' ', '');
                  print(expiryMonth);
                  print(expiryYear);
                  print(validatedCardNumber);
                  BraintreeCreditCardRequest request =
                      BraintreeCreditCardRequest(
                    cardNumber: validatedCardNumber.toString(),
                    expirationMonth: expiryMonth.toString(),
                    expirationYear: expiryYear.toString(),
                  );
                  setState(() {
                    isLoading = true;
                  });
                }
              },
            ),
          ),
          isLoading ? FullScreenLoader() : Container(),
        ],
      ),
    );
  }
}
