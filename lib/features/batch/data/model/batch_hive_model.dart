import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:softwarica_student_management_bloc/app/constants/hive_table_constant.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:uuid/uuid.dart';

part 'batch_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel extends Equatable {
  @HiveField(0)
  final String? batchId;
  @HiveField(1)
  final String batchName;

  BatchHiveModel({
    String? batchId,
    required this.batchName,
  }) : batchId = batchId ?? const Uuid().v4();

  // Initail Constructor
  const BatchHiveModel.initial()
      : batchId = '',
        batchName = '';

  // From Entity
  factory BatchHiveModel.fromEntity(BatchEntity entity) {
    return BatchHiveModel(
      batchId: entity.batchId,
      batchName: entity.batchName,
    );
  }

  // To Entity
  BatchEntity toEntity() {
    return BatchEntity(
      batchId: batchId,
      batchName: batchName,
    );
  }

  @override
  List<Object?> get props => [batchId, batchName];
}



  // // // From Entity List
  // // static List<BatchHiveModel> fromEntityList(List<BatchEntity> entityList) {
  // //   return entityList
  // //       .map((entity) => BatchHiveModel.fromEntity(entity))
  // //       .toList();
  // // }

  // // To Entity List
  // static List<BatchEntity> toEntityList(List<BatchHiveModel> hiveList) {
  //   return hiveList.map((hive) => hive.toEntity()).toList();
  // }