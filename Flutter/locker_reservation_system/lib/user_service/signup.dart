import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:locker_reservation_system/navbar.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:locker_reservation_system/router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _sidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phnumController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _checkController = TextEditingController();
  String _sid = '';
  String _name = '';
  String _phnum = '';
  String _pw = '';
  String _check = '';
  List<bool> _nullList = [false, false, false, false, false];
  bool _isSidEight = false;
  bool _isPwEqual = false;

  @override
  void initState() {
    // TODO: implement initState
    _isSidEight = true;
    _isPwEqual = true;
    super.initState();
  }

  bool isNullCheck() {
    bool isNull = false;
    setState(() {
      /*
      if (_sid.isEmpty) {
        _nullList[0] = true;
        isNull = true;
      } else if (_name.isEmpty) {
        _nullList[0] = false;
        _nullList[1] = true;
        isNull = true;
      } else if (_phnum.isEmpty) {
        _nullList[1] = false;
        _nullList[2] = true;
        isNull = true;
      } else if (_pw.isEmpty) {
        _nullList[2] = false;
        _nullList[3] = true;
        isNull = true;
      } else if (_check.isEmpty) {
        _nullList[3] = false;
        _nullList[4] = true;
        isNull = true;
      } else {
        _nullList[4] = false;
      }
      */

      /**/
      if (_sid.isEmpty) {
        _nullList[0] = true;
        isNull = true;
        return;
      } else {
        _nullList[0] = false;
      }
      if (_name.isEmpty) {
        _nullList[1] = true;
        isNull = true;
        return;
      } else {
        _nullList[1] = false;
      }
      if (_phnum.isEmpty) {
        _nullList[2] = true;
        isNull = true;
        return;
      } else {
        _nullList[2] = false;
      }
      if (_pw.isEmpty) {
        _nullList[3] = true;
        isNull = true;
        return;
      } else {
        _nullList[3] = false;
      }
      if (_check.isEmpty) {
        _nullList[4] = true;
        isNull = true;
        return;
      } else {
        _nullList[4] = false;
      }
      
      /* 
      _sid.isEmpty ? _nullList[0] = true : _nullList[0] = false;
      _name.isEmpty ? _nullList[1] = true : _nullList[1] = false;
      _phnum.isEmpty ? _nullList[2] = true : _nullList[2] = false;
      _pw.isEmpty ? _nullList[3] = true : _nullList[3] = false;
      _check.isEmpty ? _nullList[4] = true : _nullList[4] = false;
      */
    });
    return isNull;
  }

  void _showRegisterDialog(BuildContext context, String caution, bool success) {
    showDialog(
        context: context,
        barrierDismissible: true,
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
      body: Center(
          child: Row(
        children: [
          Spacer(
            flex: 2,
          ),
          Flexible(
            flex: 8,
            child: SizedBox(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 학번 입력란
                  TextField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '학번',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                      errorText: _nullList[0]
                          ? "학번을 입력하세요."
                          : _isSidEight
                              ? null
                              : "학번 8자리를 올바르게 입력하세요",
                    ),
                    controller: _sidController,
                  ),
                  // 이름 입력란
                  TextField(
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '이름',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                      errorText: _nullList[1] ? "이름을 입력하세요." : null,
                    ),
                    controller: _nameController,
                  ),
                  // 전화번호 입력란
                  TextField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '전화번호',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                      errorText: _nullList[2] ? "전화번호를 입력하세요." : null,
                    ),
                    controller: _phnumController,
                  ),
                  // 비밀번호 입력란
                  TextField(
                    obscureText: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '비밀번호',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                      errorText: _nullList[3] ? "비밀번호를 입력하세요." : null,
                    ),
                    controller: _pwController,
                  ),
                  // 비밀번호 재확인
                  TextField(
                    obscureText: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '비밀번호 확인',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                      errorText: _nullList[4]
                          ? "비밀번호를 한번 더 입력하세요."
                          : _isPwEqual
                              ? null
                              : "비밀번호를 확인하세요.",
                    ),
                    controller: _checkController,
                  ),
                  // 회원가입 버튼
                  ElevatedButton(
                      onPressed: () async {
                        bool registerPossible = false;
                        setState(() {
                          _sid = _sidController.text;
                          _name = _nameController.text;
                          _phnum = _phnumController.text;
                          _pw = _pwController.text;
                          _check = _checkController.text;

                          if (_sid.length == 8) {
                            _isSidEight = true;
                          } else {
                            _isSidEight = false;
                          }
                          if (_pw.compareTo(_check) == 0) {
                            _isPwEqual = true;
                          } else {
                            _isPwEqual = false;
                          }
                          print('_isSidEight: $_isSidEight');
                          print('_isPwEqual: $_isPwEqual');
                        });
                        if (!isNullCheck() & _isSidEight & _isPwEqual) {
                          registerPossible = true;
                        } else {
                          registerPossible = false;
                        }
                        print('registerPossible: $registerPossible');
                        // if (registerPossible) {
                        //   int status = await NetworkMananger().registerPost(
                        //       "http://180.189.89.108:8000/register",
                        //       json.encode({
                        //         'studentID': _sid,
                        //         'name': _name,
                        //         'phone_num': _phnum,
                        //         'password': _pw,
                        //       }));
                        //   String caution;
                        //   if (status == 201) {
                        //     // 회원가입 성공
                        //     caution = "회원가입이 완료되었습니다.";
                        //     _showRegisterDialog(context, caution, true);
                        //     // String nextPage = '/';
                        //     // MyRouter.router.navigateTo(context, nextPage);
                        //   } else {
                        //     // 회원가입 실패 시 팝업창 띄우기
                        //     if (status == 409) {
                        //       caution = "이미 가입된 학번입니다.\n다시 로그인해보시기 바랍니다.";
                        //     } else {
                        //       caution = "회원가입을 할 수 없습니다.";
                        //     }
                        //     _showRegisterDialog(context, caution, false);
                        //   }
                        // }
                        // String nextPage = '/';
                        // MyRouter.router.navigateTo(context, nextPage);
                        // _snumProvider.login(_snum);
                        // Navigator.pop(context);
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
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      )),
    );
  }
}
