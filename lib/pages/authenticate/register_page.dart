import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice/Services/auth.dart';
import 'package:practice/constants/mediaquery.dart';
import 'package:practice/widgets/loading.dart';

class RegisterPage extends StatefulWidget {
  @override
  Function toggleView;
  RegisterPage({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';
  bool loading = false;
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              toolbarHeight: context.portrait ? 300.h : 390.h,
              centerTitle: true,
              title: Text(
                'Register into \nEmployee Management',
                textAlign: TextAlign.center,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: context.portrait
                      ? EdgeInsets.only(left: 60.w, right: 60.w, top: 80.h)
                      : EdgeInsets.only(left: 100.w, right: 100.w, top: 80.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image(
                          height: context.portrait ? 700.h : 1600.h,
                          image: AssetImage('assets/images/welcome1.png'),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter an Email' : null,
                          onChanged: (value) => setState(() {
                            email = value;
                          }),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.indigo,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(color: Colors.indigo),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.r),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90.h,
                        ),
                        TextFormField(
                          validator: (value) => value!.length < 8
                              ? 'Password should be atleast 8 Characters.'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: active ? false : true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.indigo,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                active = !active;
                              }),
                              icon: Icon(Icons.remove_red_eye),
                              color: active ? Colors.indigo : Colors.grey,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(color: Colors.indigo),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.r),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 180.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please Supply a Valid Email';
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              fixedSize: Size(950.w, 170.h),
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(13))),
                          child: Text('Register'),
                        ),
                        SizedBox(
                          height: 70.h,
                          child: Text(error),
                        ),
                        SizedBox(
                            height: 350.h,
                            child: Divider(
                              thickness: 2,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account yet!",
                              style: TextStyle(color: Colors.indigo),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
  }
}
