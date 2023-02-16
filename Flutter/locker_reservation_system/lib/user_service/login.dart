import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/snum_prv.dart';
import 'package:locker_reservation_system/navbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SnumProvider _snumProvider;

  final TextEditingController _snumController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String _snum = '';
  String _pw = '';

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
    _snumProvider = Provider.of<SnumProvider>(context);

    return Scaffold(
      appBar: NavBar(appBar: AppBar(), title: '로그인'),
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
                  TextField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '학번',
                      focusedBorder: borderMaker(Color(0xff0D3F7A))
                    ),
                    controller: _snumController,
                  ),
                  TextField(
                    obscureText: true,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      border: borderMaker(Colors.black),
                      hintText: '비밀번호',
                      focusedBorder: borderMaker(Color(0xff0D3F7A)),
                    ),
                    controller: _pwController,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _snum = _snumController.text;
                          _pw = _pwController.text;
                        });
                        _snumProvider.login(_snum);
                        Navigator.pop(context);
                      },
                      child: Text('확인')),
                  // Text(_snum),
                  // Text(_pw),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
