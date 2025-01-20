import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:softwarica_student_management_bloc/app/constants/hive_table_constant.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/auth_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final BatchHiveModel batch;
  @HiveField(6)
  final List<CourseHiveModel> courses;
  @HiveField(7)
  final String username;
  @HiveField(8)
  final String password;

  AuthHiveModel({
    String? studentId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        fName = '',
        lName = '',
        image = '',
        phone = '',
        batch = const BatchHiveModel.initial(),
        courses = const [],
        username = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phone: entity.phone,
      batch: BatchHiveModel.fromEntity(entity.batch),
      courses: CourseHiveModel.fromEntityList(entity.courses),
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      fName: fName,
      lName: lName,
      image: image,
      phone: phone,
      batch: batch.toEntity(),
      courses: CourseHiveModel.toEntityList(courses),
      username: username,
      password: password,
    );
  }

  @override
  List<Object?> get props =>
      [studentId, fName, lName, image, batch, courses, username, password];
}
