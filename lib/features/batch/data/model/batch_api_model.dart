//need to map the private id's to make same
//dart understand _something thats in json as a private so need to map it

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/batch_entity.dart';

@JsonSerializable()
class BatchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  const BatchApiModel({
    this.batchId,
    required this.batchName,
  });
  const BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  //from json
  factory BatchApiModel.fromJson(Map<String, dynamic> json) {
    return BatchApiModel(
      batchId: json['_id'],
      batchName: json['batchName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': batchId,
      'batchName': batchName,
    };
  }

  // From Entity
  factory BatchApiModel.fromEntity(BatchEntity entity) {
    return BatchApiModel(
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

  //Convert APi list to Entity list
  List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [batchId, batchName];
}
