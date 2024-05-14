import 'package:flutter/material.dart';
import 'package:safarnama/screens/tab_pages/booking_screen.dart';
import 'package:safarnama/screens/tab_pages/favourite_screen.dart';
import 'package:safarnama/screens/tab_pages/home_screen.dart';
import 'package:safarnama/screens/tab_pages/profile_screen.dart';
import 'package:safarnama/utils/maps.dart';
import '../../utils/global.dart';

class SplashPage extends StatefulWidget {
  static const String routeNamed = "SplashPage";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _getBody() {
    switch (currentPage) {
      case 0:
        return HomeScreen();
      case 1:
        return FavouriteScreen();
      case 2:
        return BookingScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  _getBottomBar() {
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getBottomBarItem(index: 0, icontab: Icons.home, text: "Home"),
          _getBottomBarItem(
              index: 1, icontab: Icons.favorite, text: "Favourites"),
          _getBottomBarItem(
              index: 2, icontab: Icons.calendar_month, text: "Bookings"),
          _getBottomBarItem(index: 3, icontab: Icons.person, text: "Account"),
        ],
      ),
    );
  }

  _getBottomBarItem(
      {required int index, required IconData icontab, required String text}) {
    return InkWell(
      onTap: () {
        setState(() {
          currentPage = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: currentPage == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(icontab,
                          color:
                              currentPage == index ? Colors.amber : Colors.grey,
                          size: (28)),
                      SizedBox(height: 2),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              currentPage == index ? Colors.amber : Colors.grey,
                        ),
                      )
                    ],
                  ),
                  // (currentPage == index) ? Container(margin:const EdgeInsets.only(left: 8) ,child: CustomText.smalltext(text)) : const Text('')
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _getBottomBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Expanded(child: _getBody())],
      ),
    );
  }
}
