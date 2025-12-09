# Adding a New Feature

This guide walks you through creating a new feature module following Clean Architecture principles.

## Step 1: Create Feature Structure

Create the folder structure for your feature:

```bash
mkdir -p lib/features/your_feature/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets}}
```

## Step 2: Define the Entity (Domain Layer)

Create your business entity in `lib/features/your_feature/domain/entities/`:

```dart
// lib/features/your_feature/domain/entities/your_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'your_entity.freezed.dart';

@freezed
class YourEntity with _$YourEntity {
  const factory YourEntity({
    required String id,
    required String name,
    // Add your fields
  }) = _YourEntity;
}
```

## Step 3: Define Repository Interface (Domain Layer)

Create the repository interface in `lib/features/your_feature/domain/repositories/`:

```dart
// lib/features/your_feature/domain/repositories/your_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/your_entity.dart';

abstract class YourRepository {
  Future<Either<Failure, List<YourEntity>>> getItems();
  Future<Either<Failure, YourEntity>> getItem(String id);
  Future<Either<Failure, void>> createItem(YourEntity entity);
}
```

## Step 4: Create Use Cases (Domain Layer)

Create use cases in `lib/features/your_feature/domain/usecases/`:

```dart
// lib/features/your_feature/domain/usecases/get_items.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/base_usecase.dart';
import '../entities/your_entity.dart';
import '../repositories/your_repository.dart';

@injectable
class GetItems implements UseCase<List<YourEntity>, NoParams> {
  final YourRepository repository;

  GetItems(this.repository);

  @override
  Future<Either<Failure, List<YourEntity>>> call(NoParams params) {
    return repository.getItems();
  }
}
```

## Step 5: Create Model (Data Layer)

Create the data model in `lib/features/your_feature/data/models/`:

```dart
// lib/features/your_feature/data/models/your_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/your_entity.dart';

part 'your_model.freezed.dart';
part 'your_model.g.dart';

@freezed
class YourModel with _$YourModel {
  const YourModel._();
  
  const factory YourModel({
    required String id,
    required String name,
  }) = _YourModel;

  factory YourModel.fromJson(Map<String, dynamic> json) =>
      _$YourModelFromJson(json);

  YourEntity toEntity() => YourEntity(
        id: id,
        name: name,
      );
}
```

## Step 6: Create Data Source (Data Layer)

Create data sources in `lib/features/your_feature/data/datasources/`:

```dart
// lib/features/your_feature/data/datasources/your_remote_data_source.dart
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../models/your_model.dart';

abstract class YourRemoteDataSource {
  Future<List<YourModel>> getItems();
}

@Injectable(as: YourRemoteDataSource)
class YourRemoteDataSourceImpl implements YourRemoteDataSource {
  final ApiClient apiClient;

  YourRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<YourModel>> getItems() async {
    final response = await apiClient.get('/your-endpoint');
    return (response.data as List)
        .map((json) => YourModel.fromJson(json))
        .toList();
  }
}
```

## Step 7: Implement Repository (Data Layer)

Create repository implementation in `lib/features/your_feature/data/repositories/`:

```dart
// lib/features/your_feature/data/repositories/your_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/your_entity.dart';
import '../../domain/repositories/your_repository.dart';
import '../datasources/your_remote_data_source.dart';

@Injectable(as: YourRepository)
class YourRepositoryImpl implements YourRepository {
  final YourRemoteDataSource remoteDataSource;

  YourRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<YourEntity>>> getItems() async {
    try {
      final models = await remoteDataSource.getItems();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

## Step 8: Create BLoC (Presentation Layer)

Create BLoC files in `lib/features/your_feature/presentation/bloc/`:

```dart
// lib/features/your_feature/presentation/bloc/your_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/your_entity.dart';
import '../../domain/usecases/get_items.dart';
import '../../../../core/utils/base_usecase.dart';

part 'your_event.dart';
part 'your_state.dart';
part 'your_bloc.freezed.dart';

@injectable
class YourBloc extends Bloc<YourEvent, YourState> {
  final GetItems getItems;

  YourBloc(this.getItems) : super(const YourState.initial()) {
    on<_LoadItems>(_onLoadItems);
  }

  Future<void> _onLoadItems(
    _LoadItems event,
    Emitter<YourState> emit,
  ) async {
    emit(const YourState.loading());
    
    final result = await getItems(NoParams());
    
    result.fold(
      (failure) => emit(YourState.error(failure.message)),
      (items) => emit(YourState.loaded(items)),
    );
  }
}
```

## Step 9: Generate Code

Run code generation:

```bash
make gen
```

## Step 10: Create UI (Presentation Layer)

Create your page in `lib/features/your_feature/presentation/pages/`:

```dart
// lib/features/your_feature/presentation/pages/your_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/locator/injectable.dart';
import '../bloc/your_bloc.dart';

class YourPage extends StatelessWidget {
  const YourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<YourBloc>()..add(const YourEvent.loadItems()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Feature')),
        body: BlocBuilder<YourBloc, YourState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Ready')),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (items) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(title: Text(item.name));
                },
              ),
              error: (message) => Center(child: Text('Error: $message')),
            );
          },
        ),
      ),
    );
  }
}
```

## Step 11: Add Route

Add your route in `lib/features/app/presentation/router/app_router.dart`.

## Step 12: Write Tests

Create tests following the same structure in the `test/` directory.

## Checklist

- [ ] Created feature folder structure
- [ ] Defined entity
- [ ] Created repository interface
- [ ] Implemented use cases
- [ ] Created data model
- [ ] Implemented data source
- [ ] Implemented repository
- [ ] Created BLoC
- [ ] Generated code (`make gen`)
- [ ] Created UI pages/widgets
- [ ] Added routes
- [ ] Written tests
- [ ] Updated documentation

## Next Steps

- [Creating Use Cases](creating-usecases.md)
- [API Integration](api-integration.md)
- [Testing Guide](../development/testing.md)
