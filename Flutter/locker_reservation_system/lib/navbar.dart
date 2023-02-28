import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:locker_reservation_system/router.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/sid_prv.dart';
// import 'package:locker_reservation_system/user_service/login.dart';
// import 'package:locker_reservation_system/user_service/signup.dart';

// 상단 바 부분

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({super.key, required this.appBar, required this.title});

  final AppBar appBar;
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late SidProvider _sidProvider;

  @override
  Widget build(BuildContext context) {
    _sidProvider = Provider.of<SidProvider>(context);

    return AppBar(
      backgroundColor: Color(0xff0D3F7A),
      elevation: 0,
      title: Text(
        widget.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leadingWidth: MediaQuery.of(context).size.width / 5,
      leading: Container(
          padding: EdgeInsets.only(left: 10),
          child: SvgPicture.asset(
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            'assets/icons/yeongnamLogo.svg',
          )),
      centerTitle: true,
      actions: [
        Consumer<SidProvider>(
            builder: (context, sidProvider, child) => Visibility(
                  visible: Provider.of<SidProvider>(context).isLogin,
                  child: Row(
                    children: [
                      Center(
                        child: Text(
                          '${Provider.of<SidProvider>(context).sid}님 환영합니다.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            String nextPage = '/';
                            MyRouter.router.navigateTo(context, nextPage);
                            _sidProvider.logout();
                          },
                          child: Text(
                            '로그아웃',
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                )),
        Consumer<SidProvider>(
            builder: (context, sidProvider, child) => Visibility(
                  visible: !Provider.of<SidProvider>(context).isLogin,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            String nextPage = '/login';
                            MyRouter.router.navigateTo(context, nextPage);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute<void>(
                            //         builder: (context) => LoginPage()));
                          },
                          child: Text(
                            '로그인',
                            style: TextStyle(color: Colors.white),
                          )),
                      Center(
                        child: Text('|'),
                      ),
                      TextButton(
                          onPressed: () {
                            String nextPage = '/register';
                            MyRouter.router.navigateTo(context, nextPage);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute<void>(
                            //         builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            '회원가입',
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ))
      ],
    );
  }
}
