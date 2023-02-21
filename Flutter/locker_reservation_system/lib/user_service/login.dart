import 'package:flutter/material.dart';
// import 'package:locker_reservation_system/network/model/user_model.dart';
// import 'package:locker_reservation_system/network/network.dart';
import 'package:locker_reservation_system/router.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/sid_prv.dart';
import 'package:locker_reservation_system/navbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SidProvider _sidProvider;

  final TextEditingController _sidController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String _sid = '';
  String _pw = '';
  bool _isSidNull = false;
  bool _isSidEight = false;
  bool _isSidError = false;
  bool _isPwNull = false;
  bool _isPwError = false;

  void _showLoginErrorDialog(BuildContext context, String caution) {
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
    _sidProvider = Provider.of<SidProvider>(context);

    return Scaffold(
      appBar: NavBar(appBar: AppBar(), title: '로그인'),
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
                      errorText: _isSidNull ? "학번을 입력하세요." : null,
                    ),
                    controller: _sidController,
                  ),
                  // 비밀번호 입력란
                  TextField(
                    obscureText: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '비밀번호',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                      errorText: _isPwNull ? "비밀번호를 입력하세요." : null,
                    ),
                    controller: _pwController,
                  ),
                  // 확인 버튼 -> 메인 페이지로 이동
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _sid = _sidController.text;
                          _sid.isEmpty ? _isSidNull = true : _isSidNull = false;
                          _sid.length == 8
                              ? _isSidEight = true
                              : _isSidEight = false;
                          _pw = _pwController.text;
                          _pw.isEmpty ? _isPwNull = true : _isPwNull = false;
                        });
                        if (!_isSidNull & !_isPwNull) {
                          int status = await _sidProvider.login(_sid, _pw);
                          if (status == 200) {
                            // 로그인 성공
                            String nextPage = '/';
                            MyRouter.router.navigateTo(context, nextPage);
                          } else {
                            // 로그인 실패 시 팝업창 띄우기
                            String caution;
                            if (status == 401) {
                              caution = "학번과 비밀번호를 확인하세요.";
                            } else if (status == 404) {
                              caution = "존재하지 않는 학번입니다.";
                            } else {
                              caution = "로그인 할 수 없습니다.";
                            }
                            _showLoginErrorDialog(context, caution);
                          }
                        }
                      },
                      child: Text('로그인')),
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
