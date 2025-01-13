import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchDataSource {
  Future<void> createBatch(BatchEntity batchEntity);
  Future<List<BatchEntity>> getAllBatches();
  Future<void> deleteBatch(String id);
}
