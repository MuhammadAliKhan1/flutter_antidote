import 'package:antidote/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:antidote/theme.dart';
import 'package:antidote/widgets/fullscreenloader.dart';
import 'package:antidote/widgets/social_signin_buttons.dart';
import 'package:antidote/widgets/textformfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../global.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Used in form
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Function refresh;

  LoginService service = LoginService();
  @override
  void initState() {
    refresh = () {
      setState(() {});
    };
    service.initialize();
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
                        handleFacebookSignIn: _handleSignInFacebook,
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
                        handleGoogleSignIn: _handleSignInGoogle,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            navigationService.navigateToPushReplacement(
                                RouteNames.signUpScreen);
                          },
                          child: Text(
                            " Signup now",
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

  Future _handleSignInGoogle() async {
    await prefHandle.clearPreferences();

    setState(() => isLoading = true);

    try {
      String userId = await service.initiateGoogleLogin();
      print("User id $userId");
      setState(() {
        isLoading = false;
      });
      if (userId != null) {
        LoginStatus.gLoginStatus = true;
        await navigationService.navigateToPushReplacement(
          RouteNames.homeScreen,
        );
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
  }

  Future _handleSignInFacebook() async {
    await prefHandle.clearPreferences();

    setState(() => isLoading = true);

    try {
      String userId = await service.initiateFacebookLogin();
      setState(() {
        isLoading = false;
      });
      if (userId != null) {
        LoginStatus.fLoginStatus = true;
        await navigationService.navigateToPushReplacement(
          RouteNames.homeScreen,
        );
      }
    } catch (ex) {
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

    setState(
      () => isLoading = false,
    );
  }
}
