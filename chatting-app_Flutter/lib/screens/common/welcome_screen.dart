import 'package:flash_chat_flutter_app_challenge/components/GradientText.dart';
import 'package:flash_chat_flutter_app_challenge/components/GradientType.dart';
import 'package:flash_chat_flutter_app_challenge/components/custom_snack_bar.dart';
import 'package:flash_chat_flutter_app_challenge/components/padding_button.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/screen_size.dart';
import 'package:flash_chat_flutter_app_challenge/screens/mobile/mob_welcome_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/tablet/tablet_welcome_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/web/web_welcome_screen.dart';
import 'package:flash_chat_flutter_app_challenge/services/user_service.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Future<Map<String, dynamic>> _getLoggedInUser;

  @override
  void initState() {
    super.initState();
    _getLoggedInUser = UserService.getLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: _getLoggedInUser,
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data?[kLoggedUserStatusKey] == true) {
          setLoggedUserStatus(snapshot.data?[kLoggedUserStatusKey]);
          setLoggedUserEmail(snapshot.data?[kLoggedUserEmailKey]);

          return ChatListScreen();
        } else {
          if (width < kTabletMinWidth) {
            return MobWelcomeScreen();
          }
          if (width >= kTabletMinWidth && width < kWebMinWidth) {
            return TabWelcomeScreen();
          }
          // if (width.size.width > 992) {
          else {
            return WebWelcomeScreen();
          }
        }
      },
    );
  }
}

mixin WelcomeScreenMixin<T extends StatefulWidget> on State<T> {
  double minWidth = 400;

  String _userEmail = '';
  String _userPassword = '';
  final TextEditingController _emailController = TextEditingController();
  bool _passwordVisibility = true;

  List<Text> _logRegToggleList = [
    Text(
      'Register',
      style: kToggleButtonTextStyle,
    ),
    Text(
      'Login',
      style: kToggleButtonTextStyle,
    )
  ];
  List<bool> _selectedBoolList = <bool>[false, true];

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      title: GradientText(
        gradientType: GradientType.linear,
        colors: [Colors.red, Colors.amber, Colors.green, Colors.blue],
        child: Text('Flash Chat App', style: kTitle500TextStyle),
      ),
      centerTitle: true,
    );
  }

  Widget getBody() {
    Size _dSize = MediaQuery.of(context).size;

    print('Welcome screen : $_dSize');

    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: _dSize.width < 600 ? _dSize.width * 0.9 : minWidth,
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey.shade300,
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'app_logo',
                      child: Container(
                        child: Image.asset('assets/images/app_logo.png'),
                        height: _dSize.width < 600 ? _dSize.width * 0.1 : 60,
                      ),
                    ),
                    GradientText(
                      gradientType: GradientType.radial,
                      colors: [
                        Colors.amber,
                        Colors.red,
                        Colors.green,
                        Colors.blue
                      ],
                      radius: 2.0,
                      child: Text(
                        'Flash Chat',
                        style: kTitle900TextStyle.copyWith(
                            fontSize:
                                _dSize.width < 600 ? _dSize.width * 0.08 : 35),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                ToggleButtons(
                  direction: Axis.horizontal,
                  borderRadius: BorderRadius.circular(8.0),
                  constraints: BoxConstraints(
                    minHeight: 40.0,
                    minWidth: _dSize.width < 600 ? _dSize.width * 0.25 : 150.0,
                  ),
                  color: _selectedBoolList[0]
                      ? Colors.blueAccent
                      : Colors.lightBlueAccent,
                  fillColor: _selectedBoolList[0]
                      ? Colors.blueAccent
                      : Colors.lightBlueAccent,
                  selectedColor: Colors.white,
                  onPressed: (selectedIdx) {
                    setState(() {
                      if (selectedIdx == 0) {
                        _selectedBoolList[0] = true;
                        _selectedBoolList[1] = false;
                      } else {
                        _selectedBoolList[0] = false;
                        _selectedBoolList[1] = true;
                      }
                      _passwordVisibility = true;
                      _userPassword = '';
                    });
                  },
                  children: _logRegToggleList,
                  isSelected: _selectedBoolList,
                ),
                SizedBox(
                  height: 24.0,
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child: getLoginFields(),
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child: getRegisterField(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginFields() {
    return Visibility(
      visible: _selectedBoolList[1],
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            onChanged: (inputUserEmail) {
              setState(() {
                _userEmail = inputUserEmail;
              });
            },
            decoration: kInputFieldDecorLightBlueAccent.copyWith(
              hintText: 'Enter your email',
              labelText: 'Email ID',
              prefixIcon: Icon(Icons.email),
              suffixIcon: IconButton(
                  onPressed: () {
                    _emailController.clear();
                    _userEmail = '';
                  },
                  icon: Icon(Icons.clear)),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextField(
            obscureText: _passwordVisibility,
            onChanged: (inputUserPassword) {
              setState(() {
                _userPassword = inputUserPassword;
              });
            },
            decoration: kInputFieldDecorLightBlueAccent.copyWith(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(Icons.password),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisibility = _passwordVisibility ? false : true;
                    });
                  },
                  icon: Icon(_passwordVisibility
                      ? Icons.visibility
                      : Icons.visibility_off)),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          PaddingButton(
            color: Colors.lightBlueAccent,
            disableButton: _userEmail.isEmpty ||
                _userPassword.isEmpty ||
                _userPassword.length < 6,
            btnText: 'Log In',
            onPress: () async {
              if (_userEmail.isNotEmpty && _userPassword.isNotEmpty) {
                await UserService.loginService(
                  context: context,
                  userEmail: _userEmail,
                  userPassword: _userPassword,
                  nextScreenName: kChatListScreenRoute,
                );
              } else {
                print(_userEmail);
                CustomSnackBar(msg: 'Email / Password cannot be empty !!!');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getRegisterField() {
    return Visibility(
      visible: _selectedBoolList[0],
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                onChanged: (inputEmail) {
                  setState(() {
                    _userEmail = inputEmail;
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: kInputFieldDecorBlueAccent.copyWith(
                  hintText: 'Enter your email',
                  labelText: 'Email ID',
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _emailController.clear();
                        _userEmail = '';
                      },
                      icon: Icon(Icons.clear)),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                obscureText: _passwordVisibility,
                onChanged: (inputPassword) {
                  setState(() {
                    _userPassword = inputPassword;
                  });
                },
                decoration: kInputFieldDecorBlueAccent.copyWith(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisibility =
                            _passwordVisibility ? false : true;
                      });
                    },
                    icon: Icon(_passwordVisibility
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              PaddingButton(
                color: Colors.blueAccent,
                disableButton: _userEmail.isEmpty ||
                    _userPassword.isEmpty ||
                    _userPassword.length < 6,
                btnText: 'Register',
                onPress: () async {
                  if (_userEmail.isNotEmpty && _userPassword.isNotEmpty) {
                    await UserService.registerService(
                      context: context,
                      userEmail: _userEmail,
                      userPassword: _userPassword,
                      nextScreenName: kChatListScreenRoute,
                    );
                  } else {
                    CustomSnackBar(msg: 'Email / Password cannot be empty !!!');
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
