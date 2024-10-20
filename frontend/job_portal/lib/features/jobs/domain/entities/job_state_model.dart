import 'package:job_portal/features/jobs/domain/entities/job.dart';

class JobStateModel {
  Job job;
  List<Map<String, dynamic>> certificates;
  JobStateModel({
    required this.job,
    required this.certificates,
  });
}
