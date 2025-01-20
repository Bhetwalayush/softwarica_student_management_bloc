import 'package:dio/dio.dart';
import 'package:softwarica_student_management_bloc/app/constants/api_endpoints.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_api_model.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

class BatchRemoteDataSource implements IBatchDataSource {
  final Dio _dio;

  BatchRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createBatch(BatchEntity batch) async {
    try {
      var batchApiModel = BatchApiModel.fromEntity(batch);
      var response = await _dio.post(
        ApiEndpoints.createBatch,
        data: batchApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBatch(String id) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<List<BatchEntity>> getBatches() {
    // TODO: implement getBatches
    throw UnimplementedError();
  }
}
