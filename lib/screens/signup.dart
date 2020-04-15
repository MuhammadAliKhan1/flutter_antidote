import 'package:flutter/material.dart';
import 'package:antidote/theme.dart';
import 'package:antidote/widgets/fullscreenloader.dart';
import 'package:antidote/widgets/social_signin_buttons.dart';
import 'package:antidote/widgets/textformfield.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';

class SignupScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  //Used in form
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Function refresh;

  @override
  void initState() {
    super.initState();
    refresh = () {
      setState(() {});
    };
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
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Hero(
                  child: Image(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 2,
                    image: AssetImage(
                      SplashScreenConfig.logoAssetName,
                    ),
                  ),
                  tag: 'antidote-logo',
                ),
              ),
              Flexible(
                flex: 2,
                child: _buildForm(),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppPadding.formFieldPadding[1],
                    right: AppPadding.formFieldPadding[1],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Text('    Or    '),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 6,
                        right: MediaQuery.of(context).size.width / 6,
                      ),
                      child: Social_SignIn(
                        buttonType: Buttons.Facebook,
                        notifyParent: refresh,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 6,
                        right: MediaQuery.of(context).size.width / 6,
                      ),
                      child: Social_SignIn(
                        buttonType: Buttons.Google,
                        notifyParent: refresh,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            navigationService.navigateToPushReplacement(
                                RouteNames.loginScreen);
                          },
                          child: Text(
                            " Login Now",
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height + 20,
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: AppPadding.formFieldPadding[0],
              right: AppPadding.formFieldPadding[0],
            ),
            child: AntidoteTextFormField(
              controller: phoneController,
              hintText: 'Enter Your Phone No',
              icon: AssetImage('assets/icon_phone.png'),
              validatorFunction: (String text) {
                if (text.isEmpty) {
                  return 'Input phone number';
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppPadding.formFieldPadding[0],
              right: AppPadding.formFieldPadding[0],
            ),
            child: AntidoteTextFormField(
              controller: passController,
              hintText: 'Enter Your Password',
              icon: AssetImage('assets/icon_lock.png'),
              validatorFunction: (String text) {
                if (text.isEmpty) {
                  return 'Input password';
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppPadding.formFieldPadding[0],
              right: AppPadding.formFieldPadding[0],
            ),
            child: AntidoteTextFormField(
              controller: confirmPassController,
              hintText: 'Confirm Your Password',
              icon: AssetImage('assets/icon_lock.png'),
              validatorFunction: (String text) {
                if (text.isEmpty) {
                  return 'Confirm your password';
                }
              },
            ),
          ),
          Container(
            child: MaterialButton(
              height: MediaQuery.of(context).size.width / 7,
              minWidth: MediaQuery.of(context).size.width / 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              color: theme.primaryColor,
              onPressed: () {},
            ),
          ),
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: theme.primaryColor,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
