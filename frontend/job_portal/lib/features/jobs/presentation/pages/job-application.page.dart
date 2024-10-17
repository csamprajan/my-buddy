import 'package:job_portal/animations/slide-bottom.animation.dart';
import 'package:job_portal/core/custom_hooks/af_value_notifier.dart';
import 'package:job_portal/features/design_system/decorated-text.widget.dart';
import 'package:job_portal/features/design_system/filled-button-with-feedback-animation.widget.dart';
import 'package:job_portal/features/jobs/domain/entities/job.dart';
import 'package:job_portal/features/jobs/domain/entities/user_profile.dart';
import 'package:job_portal/features/jobs/presentation/pages/application-success.page.dart';
import 'package:job_portal/features/jobs/presentation/pages/select-multiple-certificates.page.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/global_constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class JobApplicationPage extends HookWidget {
  final Job job;
  JobApplicationPage({
    super.key,
    required this.job,
  });
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _applicationInProgressFlag = false;
  // bool _pageInitialized = false;
  // usermanagement.UserProfile? userprofile;
  // List<String>? _claimIds = [];

  // @override
  // didChangeDependencies() {
  //   if (!_pageInitialized) {
  //     setState(() {
  //       userprofile = context.read<UserState>().userProfile;
  //     });
  //     _pageInitialized = true;
  //   }

  //   super.didChangeDependencies();
  // }

  _apply({
    required BuildContext context,
  }) {
    // setState(() {
    //   _applicationInProgressFlag = true;
    // });
    // List<Future> futures = [];

    // jobseekermodels.Context newContext = jobseekermodels.Context(
    //   transactionId: widget.transactionId ?? "",
    //   messageId: widget.messageId ?? "",
    //   bppId: job.bppId,
    //   bppUri: job.bppUri,
    // );
    // List<jobseekermodels.UserCredential> creds = [];
    // (_claimIds ?? []).forEach((claimId) {
    //   futures.add(Provider.of<CloudWalletApi>(context, listen: false)
    //       .walletCredentialsIdSharePost(
    //     id: claimId,
    //     body: ShareCredentialInput(),
    //   ));
    // });
    // Future.wait(futures).then((List<dynamic> responses) {
    //   responses.forEach((response) {
    //     ShareCredentialOutput? shareCredentialOutput =
    //         (response as Response<ShareCredentialOutput>).body;
    //     if (shareCredentialOutput != null) {
    //       jobseekermodels.UserCredential newCred =
    //           jobseekermodels.UserCredential(
    //               url: shareCredentialOutput.sharingUrl);
    //       creds.add(newCred);
    //     }
    //   });
    //   jobseekermodels.JobApplicantProfile applicantProfile =
    //       jobseekermodels.JobApplicantProfile(
    //     // name: userprofile!.fullName,
    //     name: "Sanjay Kumar",

    //     creds: creds,
    //     skills: ['AWS', 'Flutter', 'UI / UX Design'],
    //   );
    //   jobseekermodels.JobFulfillment jobFulfillment =
    //       jobseekermodels.JobFulfillment(
    //     jobFulfillmentCategoryId: "sunbird VC",
    //     jobApplicantProfile: applicantProfile,
    //   );
    //   jobseekermodels.ConfirmJobRequest? request =
    //       jobseekermodels.ConfirmJobRequest(
    //     jobId: job.jobId,
    //     context: newContext,
    //     confirmation: jobFulfillment,
    //   );
    //   // setState(() {
    //   //   _loadingInProgressFlag = true;
    //   // });
    //   Provider.of<jobseekermodels.JobSeekerApi>(
    //     context,
    //     listen: false,
    //   )
    //       .jobConfirmPost(body: request)
    //       .then((Response<jobseekermodels.ConfirmJobResponse> response) {
    //     // if (response.isSuccessful) {
    //     // }
    //   });
    //   Future.delayed(Duration(seconds: 10)).then((_) {
    //     Job? _currentJob = widget.job;
    //     setState(() {
    //       _currentJob!.status = "APPLIED";
    //     });
    //     Provider.of<usermanagement.UserManagementApi>(
    //       context,
    //       listen: false,
    //     )
    //         .userItemCategoryEmailActionPost(
    //       category: 'job',
    //       email: context.read<AuthenticationState>().userEmail ?? "",
    //       action: 'applied',
    //       body: _currentJob,
    //     )
    //         .then((Response<Object> response) {
    //       if (response.isSuccessful) {
    //         setState(() {
    //           _applicationInProgressFlag = false;
    //         });
    //         UserDataService().removeSavedJob(job: _currentJob!);
    //         UserDataService().addNewAppliedJob(job: _currentJob);
    Navigator.of(context).pushReplacement(
      SlideBottomRoute(
        page: ApplicationSuccessPage(),
      ),
    );
    //       }
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<UserProfile> userProfileNotifier =
        useAfValueNotifier(const UserProfile());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: GlobalConstants.backgroundColor,
        title: const Text(
          "Job Application",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.clear_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Expanded(
                child:
                    // (userprofile != null)
                    //     ?
                    SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ValueListenableBuilder(
                      valueListenable: userProfileNotifier,
                      builder: (context, userprofile, _) {
                        return ListTile(
                          isThreeLine: true,
                          dense: true,
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.white70,
                              ),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                                image: AssetImage(
                                  "assets/profile_pic.jpeg",
                                ),
                              ),
                            ),
                          ),
                          title: Text(userprofile.fullName ?? ""),
                          subtitle: Text(
                            userprofile.email ?? '',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "Student",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Age",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "21 yrs",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  DecoratedTextWidget(
                    content: "Skills",
                    fontSize: 12,
                    textColor: Colors.black54,
                    textAlign: TextAlign.start,
                  ),
                  DecoratedTextWidget(
                    content:
                        "C, C++, Flutter, Mobile Development, HTML, CSS, Javascript, Typescript",
                    fontSize: 12,
                    textColor: Colors.black87,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SelectMultipleCertificatesWithOverlayWidget(
                      // claimIds: _claimIds,
                      // credentialsselected: (List<String>? claimIds) {
                      //   debugPrint(
                      //       "SelectedMultipleCerticatesWithOverlay credentialsselected claimIds.length: " +
                      //           (claimIds ?? []).length.toString());
                      //   setState(() {
                      //     _claimIds = claimIds;
                      //   });
                      // },
                      ),
                ],
              ),
            )
                // : Container(),
                ),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 20,
              ),
              child: FilledButtonWithFeedbackAnimationWidget(
                color: Colors.amber,
                textColor: Colors.black87,
                processingFlag: false,
                text: "APPLY",
                onPressed: () {
                  _apply(context: context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
