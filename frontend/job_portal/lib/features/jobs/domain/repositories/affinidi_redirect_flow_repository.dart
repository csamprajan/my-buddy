import 'package:job_portal/features/affinidi-login/data/models/complete_auth_input.dart';
import 'package:job_portal/features/affinidi-login/data/models/init_auth_response.dart';
import 'package:job_portal/features/jobs/domain/entities/get_iota_response_input.dart';
import 'package:job_portal/features/jobs/domain/entities/get_iota_response_output.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_flow_response.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_redirect_flow_input.dart';

abstract class AffinidiRedirectFlowRepo {
  Future<StartIotaFlowResponse> startRedirectFlow({
    required StartIotaRedirectFlowInput input,
  });

  // Future<GetIotaResponseOutput> getIotaResponse({
  //   required GetIotaResponseInput input,
  // });

  Future<GetIotaResponseOutput?> handleOAuthRedirectWeb({
    required Uri callbackUri,
    // required String configurationId,
    // required String queryId,
    // required String redirectUri,
  });
}
