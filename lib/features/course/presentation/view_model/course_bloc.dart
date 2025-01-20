import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetAllCourseUsecase _getAllCourseUsecase;
  final CreateCourseUsecase _createCourseUsecase;
  final DeleteCourseUsecase _deleteCourseUsecase;
  CourseBloc({
    required GetAllCourseUsecase getAllCourseUsecase,
    required CreateCourseUsecase createCourseUsecase,
    required DeleteCourseUsecase deleteCourseUsecase,
  })  : _getAllCourseUsecase = getAllCourseUsecase,
        _createCourseUsecase = createCourseUsecase,
        _deleteCourseUsecase = deleteCourseUsecase,
        super(CourseState.initial()) {
    on<CourseLoad>(_onCourseLoad);
    on<CreateCourse>(_onCreateCourse);
    on<DeleteCourse>(_onDeleteCourse);

    add(CourseLoad());
  }

  Future<void> _onCourseLoad(
    CourseLoad event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCourseUsecase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) => emit(state.copyWith(isLoading: false, courses: courses)),
    );
  }

  Future<void> _onCreateCourse(
    CreateCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCourseUsecase(
        CreateCourseParams(courseName: event.courseName));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(CourseLoad());
      },
    );
  }

  Future<void> _onDeleteCourse(
    DeleteCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteCourseUsecase(DeleteCourseParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(CourseLoad());
      },
    );
  }
}
