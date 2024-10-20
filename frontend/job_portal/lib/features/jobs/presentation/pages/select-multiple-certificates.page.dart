import 'package:job_portal/core/open_responsive_overlay.widget.dart';
import 'package:job_portal/core/usecases/usecase.dart';
import 'package:job_portal/features/design_system/decorated-text.widget.dart';
import 'package:job_portal/features/design_system/legend-wrapper.widget.dart';
import 'package:job_portal/features/jobs/domain/repositories/affinidi_redirect_flow_repository.dart';
import 'package:job_portal/features/jobs/domain/usecases/get_iota_redirect_response.dart';
import 'package:job_portal/features/jobs/presentation/widgets/view-certificate.widget.dart';
import 'package:job_portal/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:job_portal/service_registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectMultipleCertificatesWithOverlayWidget extends HookWidget {
  final List<Map<String, dynamic>> certificates;

  const SelectMultipleCertificatesWithOverlayWidget({
    super.key,
    required this.certificates,
    // required this.credentialsselected,
  });

  // bool _loadingFlag = false;
  // @override
  // void initState() {
  //   setState(() {
  //     _loadingFlag = true;
  //   });
  //   Provider.of<CloudWalletApi>(
  //     context,
  //     listen: false,
  //   ).walletCredentialsGet().then((Response<List<StoredCredential>> response) {
  //     _allcredentials =
  //         (jsonDecode(response.bodyString).cast<Map<String, dynamic>>());

  //     setState(() {
  //       _loadingFlag = false;
  //     });
  //     init();
  //   });

  //   super.initState();
  // }

  // @override
  // didUpdateWidget(SelectMultipleCertificatesWithOverlayWidget oldWidget) {
  //   // if ((claimIds != null) && (claimIds.le != oldWidget.claimIds)) {
  //   //   debugPrint("init triggered on didUpdateWidget");
  //   init();
  //   // }
  //   super.didUpdateWidget(oldWidget);
  // }

  // init() {
  //     _selectedcredentials = [];
  //     (claimIds ?? []).forEach((String claimId) {
  //       _allcredentials.forEach((Map<String, dynamic> allCredential) {
  //         if (allCredential["id"] == claimId) {
  //           _selectedcredentials.add(allCredential);
  //         }
  //       });
  //     });
  //   debugPrint("_selectedcredentials.length: " +
  //       _selectedcredentials.length.toString());
  // }

  @override
  Widget build(BuildContext context) {
// "credentialSubject": {
//      "course": {
//          "name": "IT Automation with Python",
//          "type": "Professional Certificate",
//          "url": "",
//          "courseDuration": "45 Days"
//     }
//      "courseMode": "online",
//      "completionDate": "05/08/2024",
//      "courseID": "EMP-IT-AUTOMATION-2939302",
//      "achievement": {
//          "score": "100",
//          "grade": "A"
//     }
//      "learner": {
//          "name": "Chaitanya S",
//          "phone": "",
//          "email": "chaitanya.s+demo2@affinidi.com"
//     }
// }
    return LegendWrapperWidget(
      title: 'Attachments',
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: certificates.map((Map<String, dynamic> cred) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.verified_outlined,
                          ),
                        ),
                        DecoratedTextWidget(
                          content: cred["credentialSubject"]["course"]
                                  ["name"] ??
                              "Course Name",
                          maxLines: 1,
                          overflowEllipsisFlag: true,
                        ),
                      ],
                    ),
                    onTap: () {
                      OpenResponsiveSimpleOverlay()(
                        title: "View Certificate",
                        body: ViewCertificateWidget(
                          certificate: cred,
                        ),
                        context: context,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            height: 34,
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: ActionChip(
              backgroundColor: GlobalConstants.backgroundColor,
              label: const Text(
                "ATTACH CERTIFICATES",
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
              onPressed: () async {
                try {
                  final authRedirectFlowRepo =
                      ServiceRegistry.get<AffinidiRedirectFlowRepo>();
                  final SharedPreferences prefs =
                      ServiceRegistry.get<SharedPreferences>();
                  await GetIotaRedirectResponse(
                    authRedirectFlowRepo,
                    prefs,
                  )(
                    NoParams(),
                  );
                } catch (e) {
                  print(
                      'Exception when calling CallbackApi->iotOIDC4VPCallback: $e\n');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
