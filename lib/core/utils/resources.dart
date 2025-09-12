import 'enum.dart';

class Resource<T> {
  factory Resource.success(T data) =>
      Resource._(status: ResourceStatus.success, data: data);

  Resource._({this.status = ResourceStatus.initial, this.data, this.error});

  factory Resource.initial() => Resource._(status: ResourceStatus.initial);
  factory Resource.loading() => Resource._(status: ResourceStatus.loading);
  factory Resource.error(String message) =>
      Resource._(status: ResourceStatus.failed, error: message);
  final ResourceStatus status;
  final T? data;
  final String? error;

  bool get isLoading => status == ResourceStatus.loading;
  bool get isSuccess => status == ResourceStatus.success;
  bool get isError => status == ResourceStatus.failed;
  bool get isInitial => status == ResourceStatus.initial;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    switch (status) {
      case ResourceStatus.initial:
        return initial();
      case ResourceStatus.loading:
        return loading();
      case ResourceStatus.success:
        return success(data as T);
      case ResourceStatus.failed:
        return error(this.error!);
    }
  }
}
