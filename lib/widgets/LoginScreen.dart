import 'package:flutter/material.dart';
import 'package:kgpapp/DarkThemeProvider.dart';
import 'package:kgpapp/widgets/RoutePage.dart';
import 'package:kgpapp/APIConnectors/LoginConnector.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key,required this.themeChangeProvider}){
    iconData = themeChangeProvider.darkTheme?Icons.mode_night:Icons.sunny;
  }
   final DarkThemeProvider themeChangeProvider;
  IconData iconData = Icons.sunny;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _readFromStorage()async{
    emailcontroller.text = await _storage.read(key:"KEY_EMAIL") ?? '';
  }
  @override
  void initState(){
    super.initState();
    _readFromStorage();
  }
  final _storage = const FlutterSecureStorage();
  bool _submitted = false;
  String? get _errorTextEmail {
    final email = emailcontroller.value.text;
    if(!EmailValidator.validate(email)) {
      return "Niepoprawny email";
    }

    return null;
  }
  String? get _errorTextPassword {
    final password = passwordcontroller.value.text;
    if(password.isEmpty) {
      return "Hasło nie może być puste";
    }

    return null;
  }
  final LoginConnector connector = LoginConnector();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void dispose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(
        automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    widget.themeChangeProvider.darkTheme =! widget.themeChangeProvider.darkTheme;
                    widget.iconData = widget.themeChangeProvider.darkTheme?Icons.mode_night:Icons.sunny;
                  },
                  icon: Icon(
                      widget.iconData
                  ),
                )
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/images/KGPlogo.png'),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  TextField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              errorText: _submitted?_errorTextEmail:null,
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.email,
                              ),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordcontroller,
                            decoration:  InputDecoration(
                              errorText: _submitted ? _errorTextPassword : null,
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),

                        ElevatedButton(

                          onPressed: () {
                            _submit();
                            },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                ' Log In',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
  void _submit() {
    setState(() => _submitted = true);

    if (_errorTextEmail == null && _errorTextPassword == null) {
      // notify the parent widget via the onSubmit callback
      connector.login(emailcontroller.text, passwordcontroller.text);
      _storage.write(key: "KEY_EMAIL", value: emailcontroller.text);
      Navigator.pushNamed(context, '/authenticated');

    }
  }
}