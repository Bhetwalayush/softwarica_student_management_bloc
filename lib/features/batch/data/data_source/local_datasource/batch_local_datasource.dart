import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

class BatchLocalDatasource implements IBatchDataSource {
  final HiveService _hiveService;
  BatchLocalDatasource(this._hiveService);

  @override
  Future<void> createBatch(BatchEntity batchEntity) async {
    try {
      final batchHiveModel = BatchHiveModel.fromEntity(batchEntity);
      await _hiveService.addBatch(batchHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBatch(String id) async {
    try {
      await _hiveService.deleteBatch(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BatchEntity>> getAllBatches() {
    try {
      return _hiveService.getAllBatches().then(
        (value) {
          return value.map((e) => e.toEntity()).toList();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
