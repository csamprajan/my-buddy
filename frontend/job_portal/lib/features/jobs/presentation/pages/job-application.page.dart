import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:job_portal/animations/slide-bottom.animation.dart';
import 'package:job_portal/core/custom_hooks/af_value_notifier.dart';
import 'package:job_portal/features/design_system/decorated-text.widget.dart';
import 'package:job_portal/features/design_system/filled-button-with-feedback-animation.widget.dart';
import 'package:job_portal/features/jobs/domain/entities/get_iota_response_output.dart';
import 'package:job_portal/features/jobs/domain/entities/job_state_model.dart';
import 'package:job_portal/features/jobs/domain/entities/user_profile.dart';
import 'package:job_portal/features/jobs/domain/repositories/affinidi_redirect_flow_repository.dart';
import 'package:job_portal/features/jobs/domain/repositories/user_profile.provider.dart';
import 'package:job_portal/features/jobs/presentation/pages/application-success.page.dart';
import 'package:job_portal/features/jobs/presentation/pages/select-multiple-certificates.page.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/features/jobs/presentation/providers/job.provider.dart';
import 'package:job_portal/global_constants.dart';
import 'package:job_portal/service_registry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JobApplicationPage extends HookConsumerWidget {
  const JobApplicationPage({
    super.key,
  });

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
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    // final ValueNotifier<UserProfile> userProfileNotifier =
    //     useAfValueNotifier(const UserProfile());
    debugPrint(
        "GoRouterState.of(context).uri: ${GoRouterState.of(context).uri.toString()}");
    debugPrint(
        "responseCode: ${GoRouterState.of(context).uri.queryParameters["response_code"] ?? ''}");
    final UserProfile userprofile = ref.read(userModelProvider);
    final Object imageProvider = (userprofile.profilepic != null)
        ? NetworkImage(
            userprofile.profilepic!,
          )
        : AssetImage(
            "assets/profile_pic.jpeg",
          );
    final ValueNotifier<String?> errStringNotifier = useAfValueNotifier(null);
    useMemoized(() async {
      try {
        final GetIotaResponseOutput? response =
            await ServiceRegistry.get<AffinidiRedirectFlowRepo>()
                .handleOAuthRedirectWeb(
          callbackUri: GoRouterState.of(context).uri,
        );
        debugPrint(
            "jobApplication Response: ${jsonEncode(response!.toJson())}");
        final List<Map<String, dynamic>> vcs = response.vp.verifiableCredential;
        ref.read(jobStateProvider.notifier).addCertificates(
              certificates: vcs,
            );
      } on Exception catch (err) {
        errStringNotifier.value = err.toString();
      }
    }, []);
    final JobStateModel jobModel = ref.read(jobStateProvider);

    return Scaffold(
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
        child: ValueListenableBuilder(
          valueListenable: errStringNotifier,
          builder: (context, errString, _) {
            return (errString != null)
                ? Text(errString)
                : Column(
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
                              // ValueListenableBuilder(
                              //     valueListenable: userProfileNotifier,
                              //     builder: (context, userprofile, _) {
                              //       return
                              ListTile(
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
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      alignment: Alignment.centerLeft,
                                      image: imageProvider as ImageProvider,
                                    ),
                                  ),
                                ),
                                title: Text(
                                    "${userprofile.givenName ?? ''} ${userprofile.familyName ?? ''}"),
                                subtitle: Text(
                                  userprofile.email ?? '',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              //   ;
                              // }),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                certificates: jobModel.certificates,
                              ),
                            ],
                          ),
                        ),
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
                  );
          },
        ),
      ),
    );
  }
}
