import 'package:flutter_boilerplate/enum.dart';

class Resource<T> {
  final BlocStatus status;
  final T? data;
  final String? error;

  const Resource._({this.status = BlocStatus.initial, this.data, this.error});

  factory Resource.initial() => const Resource._(status: BlocStatus.initial);

  factory Resource.loading() =>
      const Resource._(status: BlocStatus.loading, error: null);

  factory Resource.success(T data) =>
      Resource._(status: BlocStatus.success, data: data);

  factory Resource.error(String message) =>
      Resource._(status: BlocStatus.failed, error: message);

  bool get isLoading => status == BlocStatus.loading;
  bool get isSuccess => status == BlocStatus.success;
  bool get isError => status == BlocStatus.failed;
}
