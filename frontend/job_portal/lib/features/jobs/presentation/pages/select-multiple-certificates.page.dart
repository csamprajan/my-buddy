import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:job_portal/core/custom_hooks/af_value_notifier.dart';
import 'package:job_portal/features/design_system/decorated-text.widget.dart';
import 'package:job_portal/features/design_system/legend-wrapper.widget.dart';
import 'package:job_portal/features/jobs/data/data_sources/backend_iota_api.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_redirect_flow_input.dart';
import 'package:job_portal/features/jobs/domain/usecases/get_iota_redirect_response.dart';
import 'package:job_portal/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class SelectMultipleCertificatesWithOverlayWidget extends HookWidget {
  // final List<String>? claimIds;
  // final Function(List<String>?) credentialsselected;

  const SelectMultipleCertificatesWithOverlayWidget({
    super.key,
    // required this.claimIds,
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
    // List<Map<String, dynamic>> _allcredentials = [];
    final ValueNotifier<List<Map<String, dynamic>>>
        selectedcredentialsNotifier = useAfValueNotifier([]);

    return LegendWrapperWidget(
      title: 'Attachments',
      child: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: selectedcredentialsNotifier,
              builder: (context, selectedcredentials, _) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedcredentials.map((cred) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              content: cred["credentialSubject"]
                                      ["coursename"] ??
                                  "Course Name",
                              maxLines: 1,
                              overflowEllipsisFlag: true,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
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
                final String queryId = 'e28800ad-dabd-40d1-9d4f-0b700bff8c9b';
                final String configurationId =
                    '80922220-3f80-4616-be77-2bbdb0e19f8c';
                final String redirectUri = 'http://localhost:3000/verification';
                try {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  final url = Uri.parse(
                      'http://localhost:3000/api/iota/start-redirect-flow');
                  final headers = {
                    // 'sec-ch-ua-platform': 'macOS',
                    // 'Referer': 'http://localhost:59193/',
                    // 'User-Agent':
                    //     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36',
                    'accept': 'application/json',
                    // 'sec-ch-ua':
                    //     '"Google Chrome";v="129", "Not=A?Brand";v="8", "Chromium";v="129"',
                    'content-type': 'application/json',
                    // 'sec-ch-ua-mobile': '?0',
                  };
                  final String uuid = Uuid().v4();

                  final String nounce = uuid.substring(0, 10);
                  final body = jsonEncode(
                    {
                      'queryId': queryId,
                      'configurationId': configurationId,
                      'redirectUri': redirectUri,
                      'nonce': nounce,
                    },

                    //   {
                    //   'configurationId': '80922220-3f80-4616-be77-2bbdb0e19f8c',
                    //   'queryId': 'e28800ad-dabd-40d1-9d4f-0b700bff8c9b',
                    //   'redirectUri': 'http://localhost:3000/verification',
                    //   'nonce': '2c86d4b6-f',
                    // }
                  );
                  await http.head(url, headers: headers);
                  final response =
                      await http.post(url, headers: headers, body: body);
                  // final publicendpointdio = Dio(
                  //   BaseOptions(
                  //     contentType: 'application/json',
                  //     responseType: ResponseType.json,
                  //     headers: {
                  //       HttpHeaders.contentTypeHeader: 'application/json',
                  //       Headers.acceptHeader: 'application/json',
                  //     },
                  //     // followRedirects: true,
                  //     // validateStatus: (status) => true,
                  //   ),
                  // );
                  // publicendpointdio.interceptors.add(PrettyDioLogger(
                  //   requestHeader: true,
                  //   requestBody: true,
                  //   responseBody: true,
                  //   responseHeader: false,
                  //   compact: false,
                  // ));
                  // // }

                  // GetIotaRedirectResponse(
                  //   BackendIotaApi(
                  //     publicendpointdio,
                  //     // baseUrl: "http://192.168.29.105:3000/",
                  //     baseUrl: "http://localhost:3000/",
                  //     // baseUrl: "https://cis-qc-1.vercel.app",
                  //   ),
                  //   prefs,
                  // )(
                  //   GetIotaRedirectResponseParams(
                  //     queryId: queryId,
                  //     configurationId: configurationId,
                  //     redirectUri: redirectUri,
                  //   ),
                  // );
                } catch (e) {
                  print(
                      'Exception when calling CallbackApi->iotOIDC4VPCallback: $e\n');
                }

                // Navigator.of(context)
                //     .push(
                //   SlideBottomRoute(
                //     page: SelectMultipleCertificatesOverlayPage(
                //       claimIds: claimIds ?? [],
                //       credentials: _allcredentials,
                //     ),
                //   ),
                // )
                //     .then((dynamic resp) {
                //   if (resp != null) {
                //     debugPrint("selected claims on popup of overlay: " +
                //         (resp as List<String>).length.toString());

                //     credentialsselected(resp as List<String>);
                //   }
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class SelectMultipleCertificatesOverlayPage extends StatefulWidget {
//   final List<Map<String, dynamic>> credentials;
//   final List<String> claimIds;

//   SelectMultipleCertificatesOverlayPage({
//     required this.claimIds,
//     required this.credentials,
//   });
//   @override
//   _SelectMultipleCertificatesOverlayPageState createState() =>
//       _SelectMultipleCertificatesOverlayPageState(selectedclaims: claimIds);
// }

// class _SelectMultipleCertificatesOverlayPageState
//     extends State<SelectMultipleCertificatesOverlayPage> {
//   List<String> selectedclaims;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   _SelectMultipleCertificatesOverlayPageState({
//     required this.selectedclaims,
//   });
//   ScrollController _scrollController = ScrollController();
//   double _dividerHeight = 4.0;
//   String _visibleCertificatesRange = "";
//   bool _pageInitialized = false;
//   @override
//   dispose() {
//     super.dispose();
//   }

//   @override
//   didChangeDependencies() {
//     if (!_pageInitialized) {
//       double toolbarHeight = 40 + _dividerHeight + 40 + 40;
//       double _availableHeight =
//           MediaQuery.of(context).size.height - toolbarHeight;

//       _pageInitialized = true;
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: GlobalConstants.backgroundColor,
//         title: const Text(
//           "Select Certificates",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.clear_outlined,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height - 40,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: credentials.map((e) {
//                     bool selected = false;
//                     for (String claimId in selectedclaims) {
//                       if (e["id"] == claimId) {
//                         selected = true;
//                       }
//                     }
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 3),
//                       child: SelectableCredentialItemWidget(
//                         credential: e,
//                         onCredentialSelected: ({
//                           required Map<String, dynamic> credential,
//                         }) {
//                           setState(() {
//                             selectedclaims.add(credential["id"]);
//                           });
//                         },
//                         onCredentialRemoved: ({
//                           required Map<String, dynamic> credential,
//                         }) {
//                           setState(() {
//                             selectedclaims.removeWhere((selectedclaim) =>
//                                 selectedclaim == credential["id"]);
//                           });
//                         },
//                         selected: selected,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(
//                 bottom: 20,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     margin: const EdgeInsets.all(6.0),
//                     child: OutlinedButton(
//                       onPressed: () {
//                         debugPrint("selected claims length on DONE popup: " +
//                             selectedclaims.length.toString());
//                         Navigator.of(context).pop(selectedclaims);
//                       },
//                       child: const Text(
//                         "DONE",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(6.0),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: DecoratedTextWidget(
//                         content: "CANCEL",
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
