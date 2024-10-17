import 'dart:io';
import 'package:job_portal/animations/slide-bottom.animation.dart';
import 'package:job_portal/features/common/pages/dashboard.page.dart';
import 'package:job_portal/features/design_system/decorated-text.widget.dart';
import 'package:job_portal/features/design_system/lottie-animation.widget.dart';
import 'package:job_portal/global_constants.dart';

import 'package:flutter/material.dart';

class ApplicationSuccessPage extends StatefulWidget {
  ApplicationSuccessPage();
  @override
  _ApplicationSuccessPageState createState() => _ApplicationSuccessPageState();
}

class _ApplicationSuccessPageState extends State<ApplicationSuccessPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _pageInitialized = false;
  @override
  didChangeDependencies() {
    if (!_pageInitialized) {
      _pageInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: GlobalConstants.backgroundColor,
        leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }),
        title: Text(
          "Application Success",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => Container(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 200,
                height: 200,
                child: LottieAnimationWidget(
                  file: 'ok',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                child: DecoratedTextWidget(
                    content: "You have successfully applied", bold: true),
              ),
            ),
            const SizedBox(height: 6),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ActionChip(
                backgroundColor: GlobalConstants.backgroundColor,
                label: const Text(
                  "HOME",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      50,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    SlideBottomRoute(
                      page: const DashboardPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
