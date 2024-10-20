import 'package:job_portal/features/jobs/domain/entities/job.dart';
import 'package:job_portal/features/jobs/domain/entities/job_state_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'job.provider.g.dart';

@Riverpod(keepAlive: true)
class JobState extends _$JobState {
  @override
  JobStateModel build() {
    return JobStateModel(
      job: Job(),
      certificates: [],
    );
  }

  setJob({required Job job}) {
    state.job = job;
  }

  addCertificates({required List<Map<String, dynamic>> certificates}) {
    state.certificates = [
      ...state.certificates,
      ...certificates,
    ];
  }

  void clear() {
    state = JobStateModel(
      job: Job(),
      certificates: [],
    );
  }
}
