// Mocks generated by Mockito 5.4.4 from annotations
// in task_manager_app/test/bloc/tasks_cubit/tasks_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:task_manager_app/data/models/enums/tasks_filter/domain/tasks_filter.dart'
    as _i7;
import 'package:task_manager_app/data/models/general_error/domain/general_error.dart'
    as _i5;
import 'package:task_manager_app/data/models/task/domain/task.dart' as _i6;
import 'package:task_manager_app/data/repositories/tasks_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TasksRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTasksRepository extends _i1.Mock implements _i3.TasksRepository {
  @override
  _i4.Future<_i2.Either<_i5.GeneralError, void>> add(_i6.Task? item) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [item],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.GeneralError, void>>.value(
            _FakeEither_0<_i5.GeneralError, void>(
          this,
          Invocation.method(
            #add,
            [item],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.GeneralError, void>>.value(
                _FakeEither_0<_i5.GeneralError, void>(
          this,
          Invocation.method(
            #add,
            [item],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.GeneralError, void>>);

  @override
  _i4.Future<_i2.Either<_i5.GeneralError, void>> update(_i6.Task? item) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [item],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.GeneralError, void>>.value(
            _FakeEither_0<_i5.GeneralError, void>(
          this,
          Invocation.method(
            #update,
            [item],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.GeneralError, void>>.value(
                _FakeEither_0<_i5.GeneralError, void>(
          this,
          Invocation.method(
            #update,
            [item],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.GeneralError, void>>);

  @override
  _i4.Future<_i2.Either<_i5.GeneralError, void>> delete(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.GeneralError, void>>.value(
            _FakeEither_0<_i5.GeneralError, void>(
          this,
          Invocation.method(
            #delete,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.GeneralError, void>>.value(
                _FakeEither_0<_i5.GeneralError, void>(
          this,
          Invocation.method(
            #delete,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.GeneralError, void>>);

  @override
  _i4.Future<_i2.Either<_i5.GeneralError, _i6.Task>> findById(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.GeneralError, _i6.Task>>.value(
            _FakeEither_0<_i5.GeneralError, _i6.Task>(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.GeneralError, _i6.Task>>.value(
                _FakeEither_0<_i5.GeneralError, _i6.Task>(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.GeneralError, _i6.Task>>);

  @override
  _i2.Either<_i5.GeneralError, _i4.Stream<List<_i6.Task>>> queryListener(
          _i7.TasksFilter? filter) =>
      (super.noSuchMethod(
        Invocation.method(
          #queryListener,
          [filter],
        ),
        returnValue:
            _FakeEither_0<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>(
          this,
          Invocation.method(
            #queryListener,
            [filter],
          ),
        ),
        returnValueForMissingStub:
            _FakeEither_0<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>(
          this,
          Invocation.method(
            #queryListener,
            [filter],
          ),
        ),
      ) as _i2.Either<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>);

  @override
  _i2.Either<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>
      queryListenerDeadlineTasks() => (super.noSuchMethod(
            Invocation.method(
              #queryListenerDeadlineTasks,
              [],
            ),
            returnValue:
                _FakeEither_0<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>(
              this,
              Invocation.method(
                #queryListenerDeadlineTasks,
                [],
              ),
            ),
            returnValueForMissingStub:
                _FakeEither_0<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>(
              this,
              Invocation.method(
                #queryListenerDeadlineTasks,
                [],
              ),
            ),
          ) as _i2.Either<_i5.GeneralError, _i4.Stream<List<_i6.Task>>>);
}
