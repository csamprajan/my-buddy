import 'package:dio/dio.dart';
import 'package:job_portal/features/jobs/domain/entities/get_iota_response_input.dart';
import 'package:job_portal/features/jobs/domain/entities/get_iota_response_output.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_flow_response.dart';
import 'package:job_portal/features/jobs/domain/entities/start_iota_redirect_flow_input.dart';
import 'package:retrofit/retrofit.dart';

part 'backend_iota_api.g.dart';

@RestApi()
abstract class BackendIotaApi {
  factory BackendIotaApi(Dio dio, {String baseUrl}) = _BackendIotaApi;
  @POST('/api/iota/start-redirect-flow')
  Future<StartIotaFlowResponse> startRedirectFlow(
    @Body() StartIotaRedirectFlowInput input,
  );

  @POST('/api/iota/iota-response')
  Future<GetIotaResponseOutput> getIotaResponse(
    @Body() GetIotaResponseInput input,
  );

// async function getIotaResponse(iotaRedirect: any, responseCode: string) {
//   const params = { ...iotaRedirect, responseCode };
//   const response = await fetch("/api/iota/iota-response", {
//     method: "POST",
//     body: JSON.stringify(params),
//     headers: {
//       "Content-Type": "application/json",
//       Accept: "application/json",
//     },
//   });
//   return await response.json();
// }

// export default function useIotaQueryRedirect({
//   configurationId,
//   redirectUrl,
// }: IotaRequestRedirectType) {
//   const router = useRouter();
//   const searchParams = useSearchParams();
//   const pathname = usePathname()
//   const [isInitializing, setIsInitializing] = useState(false);
//   const [errorMessage, setErrorMessage] = useState<string>();
//   const [dataRequest, setDataRequest] = useState<any>();
//   const [data, setData] = useState<any>();
//   const [queryId, setQueryId] = useState<string>();

//   const handleInitiate = async (queryId: string) => {
//     try {
//       if (!queryId) {
//         setErrorMessage("queryId is required to initiate Iota request");
//         return;
//       }

//       setQueryId(queryId);
//       setErrorMessage(undefined);
//       setIsInitializing(true);

//       const nonce = uuidv4().slice(0, 10);

//       const iotaResponseData = await getIotaRequestStart(
//         configurationId,
//         redirectUrl || `${hostUrl}${pathname}`,
//         queryId,
//         nonce
//       );
//       if (!iotaResponseData.correlationId || !iotaResponseData.transactionId) {
//         console.error("Error while calling API", iotaResponseData);
//         setErrorMessage("Error Occcured :" + iotaResponseData.message);
//         return;
//       }
//       setDataRequest((prevRequests: any) => ({
//         ...prevRequests,
//         request: iotaResponseData,
//       }));

//       const toStore = {
//         nonce,
//         configurationId: configurationId,
//         correlationId: iotaResponseData.correlationId,
//         transactionId: iotaResponseData.transactionId,
//       };

//       localStorage.setItem("iotaRedirect", JSON.stringify(toStore));

//       const vaultLink = VaultUtils.buildShareLink(iotaResponseData.jwt, "client_id");
//       router.push(vaultLink);
//     } catch (error: any) {
//       console.error("Error initializing Iota Session:", error);
//       setErrorMessage("IotaSession response error: " + error.message);
//     } finally {
//       setIsInitializing(false);
//     }
//   };

//   const handleCallback = async (responseCode: string) => {
//     setErrorMessage(undefined);
//     const iotaRedirectString = localStorage.getItem("iotaRedirect") || "{}";
//     const iotaRedirect = JSON.parse(iotaRedirectString);

//     const iotaResponse = await getIotaResponse(iotaRedirect, responseCode);
//     console.log('iotaResponse', iotaResponse);

//     if (!iotaResponse?.vp || !iotaResponse?.nonce) {
//       console.error("Error while calling API", iotaResponse);
//       setErrorMessage("Error Occcured :" + iotaResponse.message);
//       return;
//     }
//     setIsInitializing(true);

//     const generatedNonce = iotaRedirect?.nonce;
//     const receivedNonce = iotaResponse?.nonce;
//     const matched = generatedNonce === receivedNonce;
//     setDataRequest((prevRequests) => ({
//       ...prevRequests,
//       response: {
//         verifiablePresentation: iotaResponse.vp,
//         nonce: iotaResponse?.nonce
//       },
//     }));

//     const allCrdentialSubjectArray = iotaResponse.vp.verifiableCredential?.map((vc) => vc.credentialSubject) || [];
//     const allCredentailSubject = Object.assign({}, ...allCrdentialSubjectArray);
//     console.log(allCredentailSubject)
//     setData(allCredentailSubject);

//     setErrorMessage(undefined);
//     setIsInitializing(false);
//   };

//   useEffect(() => {
//     console.log("configurationId", configurationId);
//     if (!configurationId) {
//       setErrorMessage("ConfigurationID missing");
//       return;
//     }
//   }, [configurationId]);

//   useEffect(() => {
//     const responseCode = searchParams.get("response_code");
//     const errorMessage = searchParams.get("error");
//     if (errorMessage) {
//       setIsInitializing(false);
//       setErrorMessage(errorMessage);
//       router.push(pathname)
//     }
//     else if (responseCode) {
//       handleCallback(responseCode);
//       router.push(pathname)
//     }
//   }, [searchParams]);

//   return {
//     isInitializing,
//     handleInitiate,
//     errorMessage,
//     dataRequest,
//     data,
//     queryId,
//   };
}
