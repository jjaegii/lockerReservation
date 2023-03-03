import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locker_reservation_system/navbar.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:locker_reservation_system/router.dart';
import 'package:locker_reservation_system/user_service/hashing.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final phnumFormKey = GlobalKey<FormState>();

  final TextEditingController _sidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phnumController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _authController = TextEditingController();
  String _sid = '';
  String _name = '';
  String _phnum = '';
  String _pw = '';
  String _auth = '';
  late bool _authentication;
  late bool _authReqBtn;
  late bool _authBtn;

  @override
  void initState() {
    _authentication = false;
    _authReqBtn = true;
    _authBtn = false;
    super.initState();
  }

  void _showRegisterDialog(BuildContext context, String caution, bool success) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(caution),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (success) {
                      String nextPage = '/';
                      MyRouter.router.navigateTo(context, nextPage);
                    }
                  },
                  child: Text('확인'))
            ],
          );
        });
  }

  OutlineInputBorder borderMaker(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(appBar: AppBar(), title: '회원가입'),
      body: SingleChildScrollView(
        child: Center(
            child: Row(
          children: [
            Spacer(
              flex: 2,
            ),
            Flexible(
              flex: 8,
              child: SizedBox(
                height: 600,
                // width: 600,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 학번 입력란
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "학번을 입력하세요.";
                          }
                          if (value.length != 8 ||
                              !RegExp(r'^[0-9]{8}$').hasMatch(value)) {
                            return "학번 8자리를 올바르게 입력하세요.";
                          }
                          return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black26,
                        decoration: InputDecoration(
                          border: borderMaker(Colors.black),
                          hintText: '학번',
                          focusedBorder: borderMaker(Color(0xff0D3F7A)),
                        ),
                        controller: _sidController,
                      ),

                      // 이름 입력란
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이름을 입력하세요.';
                          }
                          if (value.length < 2) {
                            return '두글자 이상 입력해주세요.';
                          }
                          return null;
                        },
                        cursorColor: Colors.black26,
                        decoration: InputDecoration(
                          border: borderMaker(Colors.black),
                          hintText: '이름',
                          focusedBorder: borderMaker(Color(0xff0D3F7A)),
                        ),
                        controller: _nameController,
                      ),

                      // 전화번호 입력란
                      Form(
                        key: phnumFormKey,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 10,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '전화번호를 입력하세요.';
                                  }
                                  if (!RegExp(r'^\d{3}\d{3,4}\d{4}$')
                                      .hasMatch(value)) {
                                    return '잘못된 전화번호 형식입니다. ex) 010xxxxOOOO';
                                  }
                                  return null;
                                },
                                readOnly: !_authReqBtn,
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black26,
                                decoration: InputDecoration(
                                  border: borderMaker(Colors.black),
                                  focusedBorder: borderMaker(Color(0xff0D3F7A)),
                                  labelText: '전화번호(하이픈 \'-\', 띄어쓰기 제외)',
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  errorText: _authentication
                                      ? null
                                      : "전화번호 인증이 필요합니다.",
                                ),
                                controller: _phnumController,
                              ),
                            ),
                            // 인증번호 요청 버튼
                            Flexible(
                              flex: 4,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: _authReqBtn
                                        ? () async {
                                            setState(() {
                                              _phnum = _phnumController.text;
                                            });
                                            // 전화번호 형식이 옳은지 확인한 후
                                            if (phnumFormKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _authBtn = true;
                                                _authReqBtn = false;
                                              });
                                              // 인증번호 요청 보내기
                                              String serverUrl =
                                                  dotenv.env['SERVER_URL'] ??
                                                      "http://localhost:8000";
                                              var status =
                                                  await NetworkMananger().post(
                                                      "$serverUrl/cert",
                                                      json.encode({
                                                        'phone_num': _phnum
                                                      }));
                                              if (status['status'] == 200) {
                                                String caution =
                                                    "인증번호가 전송되었습니다.\n인증을 완료해주세요.";
                                                _showRegisterDialog(
                                                    context, caution, false);
                                              } else {
                                                String caution =
                                                    "인증번호 요청 오류입니다.\n회원가입을 다시 시도해주세요.";
                                                _showRegisterDialog(
                                                    context, caution, true);
                                              }
                                            }
                                          }
                                        : null,
                                    child: Text(
                                      '인증번호\n요청',
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 인증번호 입력 & 인증 버튼
                      Visibility(
                        visible: _authBtn,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 10,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black26,
                                readOnly: _authentication,
                                decoration: InputDecoration(
                                  border: borderMaker(Colors.black),
                                  focusedBorder: borderMaker(Color(0xff0D3F7A)),
                                  labelText: '인증번호 (정확하게 입력)',
                                  floatingLabelStyle: TextStyle(
                                    color: Color(0xff0D3F7A),
                                  ),
                                ),
                                controller: _authController,
                              ),
                            ),
                            // 인증번호 요청 버튼
                            Flexible(
                              flex: 4,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: !_authentication
                                        ? () async {
                                            setState(() {
                                              _auth = _authController.text;
                                            });
                                            // 인증번호 확인 요청
                                            String serverUrl =
                                                dotenv.env['SERVER_URL'] ??
                                                    "http://localhost:8000";
                                            var response =
                                                await NetworkMananger().post(
                                                    "$serverUrl/check",
                                                    json.encode({
                                                      'phone_num': _phnum,
                                                      'cert_number': _auth,
                                                    }));
                                            // 인증번호가 옳은지 확인
                                            if (response['status'] == 200) {
                                              if (response['data']['cert'] ==
                                                  "success") {
                                                // 인증 완료 시
                                                setState(() {
                                                  _authentication = true;
                                                });
                                                String caution =
                                                    "휴대폰 본인 인증이 완료되었습니다.";
                                                _showRegisterDialog(
                                                    context, caution, false);
                                              } else {
                                                // 인증 실패 시
                                                String caution =
                                                    "인증번호가 맞지 않습니다.\n인증번호를 정확하게 입력해주세요.";
                                                _showRegisterDialog(
                                                    context, caution, false);
                                              }
                                            } else {
                                              String caution =
                                                  "인증번호 요청 오류입니다.\n회원가입을 다시 시도해주세요.";
                                              _showRegisterDialog(
                                                  context, caution, true);
                                            }
                                          }
                                        : null,
                                    child: Text(
                                      !_authentication ? '인증하기' : '인증완료',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 비밀번호 입력란
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력하세요.';
                          } else if (value.length < 8) {
                            return '비밀번호를 8자리 이상 입력하세요.';
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: Colors.black26,
                        decoration: InputDecoration(
                          border: borderMaker(Colors.black),
                          hintText: '비밀번호',
                          focusedBorder: borderMaker(Color(0xff0D3F7A)),
                        ),
                        controller: _pwController,
                      ),

                      // 비밀번호 재확인
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 한번 더 입력하세요.';
                          }
                          if (value.compareTo(_pwController.text) != 0) {
                            return '비밀번호를 확인하세요.';
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: Colors.black26,
                        decoration: InputDecoration(
                          border: borderMaker(Colors.black),
                          hintText: '비밀번호 확인',
                          focusedBorder: borderMaker(Color(0xff0D3F7A)),
                        ),
                      ),

                      // 회원가입 버튼
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _sid = _sidController.text;
                                  _name = _nameController.text;
                                  _phnum = _phnumController.text;
                                  _pw = _pwController.text;
                                });
                                // 휴대폰 인증 완료 체크
                                if (_authentication) {
                                  // 입력 양식 유효성 체크
                                  if (formKey.currentState!.validate()) {
                                    // 비밀번호 암호화
                                    _pw = pwHashing(_pw);
                                    print(_pw);
                                    // 회원가입 요청
                                    String serverUrl =
                                        dotenv.env['SERVER_URL'] ??
                                            "http://localhost:8000";
                                    int status =
                                        await NetworkMananger().registerPost(
                                            "$serverUrl/register",
                                            json.encode({
                                              'studentID': _sid,
                                              'name': _name,
                                              'phone_num': _phnum,
                                              'password': _pw,
                                            }));
                                    String caution;
                                    if (status == 201) {
                                      // 회원가입 성공 시 -> 메인화면으로 이동
                                      caution = "회원가입이 완료되었습니다.";
                                      _showRegisterDialog(
                                          context, caution, true);
                                    } else {
                                      // 회원가입 실패 시 팝업창 띄우기
                                      if (status == 409) {
                                        caution =
                                            "이미 가입된 학번입니다.\n다시 로그인해보시기 바랍니다.";
                                      } else {
                                        caution = "회원가입을 할 수 없습니다.";
                                      }
                                      _showRegisterDialog(
                                          context, caution, false);
                                    }
                                  }
                                } else {
                                  String caution = '휴대폰 본인 인증이 필요합니다.';
                                  _showRegisterDialog(context, caution, false);
                                }
                              },
                              child: Text('확인')),

                          // 뒤로가기 버튼
                          ElevatedButton(
                              onPressed: () {
                                String nextPage = '/';
                                MyRouter.router.navigateTo(context, nextPage);
                              },
                              child: Text('뒤로가기')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        )),
      ),
    );
  }
}
