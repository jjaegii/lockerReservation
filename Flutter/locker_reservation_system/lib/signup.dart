import 'package:flutter/material.dart';
import 'package:locker_reservation_system/navbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

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
              Spacer(flex: 2,),
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
                      focusedBorder: borderMaker(Color(0xff0D3F7A))
                    ),
                    // controller: _snumController,
                  ),
                  // 이름 입력란
                  TextField(
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '이름',
                      focusedBorder: borderMaker(Color(0xff0D3F7A))
                    ),
                    // controller: _snumController,
                  ),
                  // 전화번호 입력란
                  TextField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '전화번호',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                    ),
                    // controller: _pwController,
                  ),
                  // 비밀번호 입력란
                  TextField(
                    obscureText: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '비밀번호',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                    ),
                    // controller: _pwController,
                  ),
                  // 비밀번호 재확인
                  TextField(
                    obscureText: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '비밀번호 확인',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                    ),
                    // controller: _pwController,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // setState(() {
                        //   _snum = _snumController.text;
                        //   _pw = _pwController.text;
                        // });
                        // _snumProvider.login(_snum);
                        // Navigator.pop(context);
                      },
                      child: Text('확인')),
                  // Text(_snum),
                  // Text(_pw),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      child: Text('뒤로가기')),
                        ],
                      ),
                ),
              ),
              Spacer(flex: 2,),
            ],
          )),
    );
  }
}