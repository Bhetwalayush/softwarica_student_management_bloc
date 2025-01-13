import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchRepository {
  Future<Either<Failure, List<BatchEntity>>> getBatches();
  Future<Either<Failure, void>> createBatch(BatchEntity batch);
  Future<Either<Failure, void>> deleteBatch(String id);
}
