// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:cleanarchitecture/core/services/base_network/error/handler/error_model.dart';

abstract class BaseState extends Equatable {
  const BaseState();
  @override
  List<Object> get props => [];
}

class InitialState extends BaseState {
  const InitialState({this.count});
  final int? count;
}

class LoadingState extends BaseState {}

class LoadingCalendarArrowState extends BaseState {}

class NotificationReadingLoadingState extends BaseState {}

class ErrorState extends BaseState {
  const ErrorState(this.data);

  final ErrorExceptionModel? data;
}

class LoadedState<T> extends BaseState {
  const LoadedState(this.data, {this.mappedData, this.canPop = false});
  final T? data;
  final bool? canPop;
  final dynamic mappedData;
}

class PaginatedListLoadedState<T> extends BaseState {
  final List<dynamic> list;
  final T? data;
  final bool hasReachedMax;
  final String? total;
  const PaginatedListLoadedState({
    this.data,
    required this.list,
    required this.hasReachedMax,
    this.total,
  });
  @override
  List<Object> get props => [list, hasReachedMax];
}

class NotificationDeletedState<T> extends BaseState {
  const NotificationDeletedState(this.data, this.id);
  final String id;
  final T? data;
}

class NotificationReadState<T> extends BaseState {
  const NotificationReadState(this.data, this.id);
  final String id;
  final T? data;
}

class NotificationCountState extends BaseState {
  final int count;
  const NotificationCountState(this.count);
}

class EmptyState<T> extends BaseState {
  const EmptyState(this.data);

  final T? data;
}

class ButtonEnabledState extends BaseState {}

class ButtonDisabledState extends BaseState {}

class ButtonLoadingState extends BaseState {
  final bool isFirstButtonLoading;
  const ButtonLoadingState({this.isFirstButtonLoading = true});
}

class FavouriteAddOrDeletedState<T> extends BaseState {
  const FavouriteAddOrDeletedState(this.data, this.id, this.index);
  final int index;
  final String id;
  final T? data;
}

class FormLoadedState<T> extends BaseState {
  const FormLoadedState(this.data, {this.mappedData, this.canPop = false});
  final T? data;
  final bool? canPop;
  final dynamic mappedData;
}

class CategoryUpdatedState extends BaseState {
  // final Map<String, dynamic>? selectedCategory;
  const CategoryUpdatedState();
}

class SelectState extends BaseState {}

class LoadedStateSubCategoryItems<T> extends BaseState {
  const LoadedStateSubCategoryItems(
    this.data, {
    this.mappedData,
    this.canPop = false,
  });
  final T? data;
  final bool? canPop;
  final dynamic mappedData;
}
