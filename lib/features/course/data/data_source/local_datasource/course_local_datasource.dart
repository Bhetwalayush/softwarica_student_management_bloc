import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_data_source.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class CourseLocalDatasource implements ICourseDataSource {
  final HiveService _hiveService;
  CourseLocalDatasource(this._hiveService);
  @override
  Future<void> createCourse(CourseEntity courseEntity) async {
    try {
      final courseHiveModel = CourseHiveModel.fromEntity(courseEntity);
      await _hiveService.addCourse(courseHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      await _hiveService.deleteCourse(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getAllCourses() {
    try {
      return _hiveService.getAllCourses().then(
        (value) {
          return value.map((e) => e.toEntity()).toList();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
