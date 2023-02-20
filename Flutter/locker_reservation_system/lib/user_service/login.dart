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

  // bool isSidNull(String sid) {
  //   if (sid.isEmpty) {
  //     return true;
  //   }
  //   return false;
  // }
  // bool isPasswordNull(String pw) {
  //   if (pw.isEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

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
                          _sid.length == 8 ? _isSidEight = true : _isSidEight = false;
                          _pw = _pwController.text;
                          _pw.isEmpty ? _isPwNull = true : _isPwNull = false;
                        });
                        if (!_isSidNull & !_isPwNull) {
                          bool ok = await _sidProvider.login(_sid, _pw);
                          // print('login.dart -> sidProvider.isLogin : ${_sidProvider.isLogin}');
                          if (ok) {
                            String nextPage = '/';
                            MyRouter.router.navigateTo(context, nextPage);
                          }
                        }
                      },
                      child: Text('로그인')),
                  // Text(_snum),
                  // Text(_pw),
                  ElevatedButton(
                      onPressed: () {
                        // NetworkMananger().get("http://180.189.89.108:8000/");
                        String nextPage = '/';
                        MyRouter.router.navigateTo(context, nextPage);
                        // Navigator.pop(context);
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
