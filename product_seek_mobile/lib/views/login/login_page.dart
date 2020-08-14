import 'package:flutter/material.dart';
import 'package:product_seek_mobile/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _isRegistering = false;
  bool _isLoading = false;
  bool once = true;

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  String _serverMessage = "";

  void _toggleForm() {
    setState(() {
      _isRegistering = !_isRegistering;
    });
  }

  Future<void> loginOrSignUp(LoginViewModel loginViewModel) async {
    setState(() {
      _serverMessage = "";
    });
    if (!_isRegistering) {
      await loginViewModel.login(
          email: _email.text.trim(), password: _password.text.trim());
    } else {
      await loginViewModel.register(
          name: _name.text.trim(),
          email: _email.text.trim(),
          password: _password.text.trim(),
          confirmPassword: _confirmPassword.text.trim(),
          address: _address.text.trim(),
          number: _phone.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    loginViewModel.getLoginResponse().listen((isSuccessfulLogin) {
      setState(() {
        _isLoading = false;
        if (isSuccessfulLogin) {
          if (once) {
            once = false;
            Navigator.pop(context);
          }
        } else {
          _serverMessage = loginViewModel.getMessage();
        }
      });
    });
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Visibility(
                    child: Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Visibility(
                                visible: _isRegistering,
                                child: Column(
                                  children: <Widget>[
                                    _buildNameFormField(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              _buildEmailFormField(),
                              Visibility(
                                visible: _isRegistering,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15,
                                    ),
                                    _buildPhoneFormField(),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _isRegistering,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15,
                                    ),
                                    _buildAddressFormField(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              _buildPasswordFormField(),
                              Visibility(
                                visible: _isRegistering,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15,
                                    ),
                                    _buildConfirmPasswordFormField(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              _buildErrorMessage(),
                              SizedBox(
                                height: 30,
                              ),
                              _buildLoginButton(loginViewModel),
                              SizedBox(
                                height: 20,
                              ),
                              _buildBottomController()
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.trim().isNotEmpty) {
      if (!regex.hasMatch(value.trim()))
        return 'Please enter valid email';
      else
        return null;
    } else
      return 'Please enter your Email';
  }

  String validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.trim().length < 8)
        return 'Password must be more than or equal to 8 characters';
      else
        return null;
    } else
      return 'Please enter your password';
  }

  Widget _buildNameFormField() {
    return TextFormField(
      controller: _name,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
          labelText: 'Full Name'),
    );
  }

  Widget _buildEmailFormField() {
    return TextFormField(
      controller: _email,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(),
          labelText: 'Email'),
    );
  }

  Widget _buildAddressFormField() {
    return TextFormField(
      controller: _address,
      validator: validateEmail,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          border: OutlineInputBorder(),
          labelText: 'Address'),
    );
  }

  Widget _buildPhoneFormField() {
    return TextFormField(
      controller: _phone,
      validator: validateEmail,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(),
          labelText: 'Phone Number'),
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: _password,
      validator: validatePassword,
      obscureText: !_showPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showPassword = !this._showPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Password'),
    );
  }

  Widget _buildConfirmPasswordFormField() {
    return TextFormField(
      controller: _confirmPassword,
      validator: validatePassword,
      obscureText: !_showConfirmPassword,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showConfirmPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(
                  () => this._showConfirmPassword = !this._showConfirmPassword);
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Confirm Password'),
    );
  }

  Widget _buildErrorMessage() {
    return Visibility(
        visible: _serverMessage.trim().isNotEmpty,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _simplifyServerMessage(),
              style: TextStyle(color: Colors.red),
            ),
          ),
        ));
  }

  String _simplifyServerMessage() {
    if (_serverMessage == "Invalid Credentials") {
      return "Invalid email address or password";
    } else if (_serverMessage == "Error while fetching data")
      return "Server Error";
    else {
      return _serverMessage;
    }
  }

  Widget _buildLoginButton(LoginViewModel loginViewModel) {
    return ButtonTheme(
      height: 45,
      child: RaisedButton(
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        onPressed: _isLoading
            ? null
            : () {
                FocusScope.of(context).unfocus();
                if (formKey.currentState.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  loginOrSignUp(loginViewModel);
                }
              },
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 800.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              getButtonText(),
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String getButtonText() {
    if (_isLoading) {
      if (_isRegistering) {
        return "SIGNING UP";
      } else {
        return "LOGGING IN";
      }
    } else {
      if (_isRegistering) {
        return "REGISTER";
      } else {
        return "LOGIN";
      }
    }
  }

  Widget _buildBottomController() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              visible: !_isRegistering,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !_isRegistering,
              child: InkWell(
                  onTap: () {
                    _toggleForm();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "Create an account.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )),
            ),
          ],
        ),
        Visibility(
          visible: _isRegistering,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                onTap: () {
                  _toggleForm();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Login to an existing account.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}