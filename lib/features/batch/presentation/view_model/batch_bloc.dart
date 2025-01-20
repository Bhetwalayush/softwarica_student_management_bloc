import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final CreateBatchUseCase _createBatchUseCase;
  final GetAllBatchUseCase _getAllBatchUseCase;
  final DeleteBatchUsecase _deleteBatchUsecase;

  BatchBloc({
    required CreateBatchUseCase createBatchUseCase,
    required GetAllBatchUseCase getAllBatchUseCase,
    required DeleteBatchUsecase deleteBatchUsecase,
  })  : _createBatchUseCase = createBatchUseCase,
        _getAllBatchUseCase = getAllBatchUseCase,
        _deleteBatchUsecase = deleteBatchUsecase,
        super(BatchState.initial()) {
    on<LoadBatches>(_onLoadBatches);
    on<AddBatch>(_onAddBatch);
    on<DeleteBatch>(_onDeleteBatch);

    // Call this event whenever the bloc is created to load the batches
    add(LoadBatches());
  }

  Future<void> _onLoadBatches(
      LoadBatches event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllBatchUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) => emit(state.copyWith(isLoading: false, batches: batches)),
    );
  }

  Future<void> _onAddBatch(AddBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createBatchUseCase
        .call(CreateBatchParams(batchName: event.batchName));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));

        add(LoadBatches());
      },
    );
  }

  Future<void> _onDeleteBatch(
      DeleteBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteBatchUsecase
        .call(DeleteBatchParams(batchId: event.batchId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBatches());
      },
    );
  }
}
