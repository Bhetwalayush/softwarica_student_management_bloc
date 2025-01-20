import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchDataSource {
  Future<List<BatchEntity>> getBatches();
  Future<void> createBatch(BatchEntity batch);
  Future<void> deleteBatch(String id);
}
