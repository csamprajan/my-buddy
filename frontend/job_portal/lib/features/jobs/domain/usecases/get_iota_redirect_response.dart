import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:job_portal/core/usecases/usecase.dart';
import 'package:job_portal/core/vault_utils.dart';
import 'package:job_portal/features/jobs/data/data_sources/backend_iota_api.dart';
import 'package:job_portal/features/jobs/domain/entities/local_iota_object.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_flow_response.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_redirect_flow_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetIotaRedirectResponseParams extends Equatable {
  final String queryId;
  final String configurationId;
  final String redirectUri;

  const GetIotaRedirectResponseParams({
    required this.queryId,
    required this.configurationId,
    required this.redirectUri,
  });

  @override
  List<Object> get props => [
        queryId,
      ];
}

class GetIotaRedirectResponse
    implements UseCase<void, GetIotaRedirectResponseParams> {
  final BackendIotaApi backendIotaApi;
  final SharedPreferences sharedPrefs;

  GetIotaRedirectResponse(
    this.backendIotaApi,
    this.sharedPrefs,
  );

  @override
  Future<void> call(GetIotaRedirectResponseParams params) async {
    final String uuid = Uuid().v4();
    final String nounce = uuid.substring(0, 10);
    final StartIotaFlowResponse response =
        await backendIotaApi.startRedirectFlow(
      StartIotaRedirectFlowInput(
        configurationId: params.configurationId,
        queryId: params.queryId,
        redirectUri: params.redirectUri,
        nonce: nounce,
      ),
    );
    final localObject = LocalIotaObject(
      correlationId: response.correlationId,
      transactionId: response.transactionId,
      nounce: nounce,
      configurationId: params.configurationId,
    );
    sharedPrefs.setString("iotaRedirect", jsonEncode(localObject));
    final vaultLink =
        VaultUtils.buildShareLink(response.jwt ?? '', "client_id");
    final Uri uri = Uri.parse(vaultLink);
    launchUrl(uri);

    // router.push(vaultLink);

    return;
    // const iotaResponseData = await getIotaRequestStart(
    //   configurationId,
    //   redirectUri || `${hostUrl}${pathname}`,
    //   queryId,
    //   nonce
    // );
    // if (!iotaResponseData.correlationId || !iotaResponseData.transactionId) {
    //   console.error("Error while calling API", iotaResponseData);
    //   setErrorMessage("Error Occcured :" + iotaResponseData.message);
    //   return;
    // }
    // setDataRequest((prevRequests: any) => ({
    //   ...prevRequests,
    //   request: iotaResponseData,
    // }));

    // const toStore = {
    //   nonce,
    //   configurationId: configurationId,
    //   correlationId: iotaResponseData.correlationId,
    //   transactionId: iotaResponseData.transactionId,
    // };

    // localStorage.setItem("iotaRedirect", JSON.stringify(toStore));

    // const vaultLink = VaultUtils.buildShareLink(iotaResponseData.jwt, "client_id");
    // router.push(vaultLink);
  }
}
