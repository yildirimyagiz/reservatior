import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/video_content_repository.dart';
import '../entities/video_content_entity.dart';

class GetVideosUseCase extends UseCase {
  final VideoContentRepository repository;
  GetVideosUseCase(this.repository);
  @override  Future<Either<Failure, List<VideoContentEntity>> call() async => Left(ServerFailure('Unimplemented'));
}

class GetVideoByIdUseCase extends UseCase {
  final VideoContentRepository repository;
  GetVideoByIdUseCase(this.repository);
  @override  Future<Either<Failure, VideoContentEntity> call(String id) async => Left(ServerFailure('Unimplemented'));
}

class CreateVideoUseCase extends UseCase {
  final VideoContentRepository repository;
  CreateVideoUseCase(this.repository);
  @override  Future<Either<Failure, VideoContentEntity> call(Map<String, dynamic> video) async => Left(ServerFailure('Unimplemented'));
}

class UpdateVideoUseCase extends UseCase {
  final VideoContentRepository repository;
  UpdateVideoUseCase(this.repository);
  @override  Future<Either<Failure, VideoContentEntity> call(Map<String, dynamic> video) async => Left(ServerFailure('Unimplemented'));
}

class DeleteVideoUseCase extends UseCase {
  final VideoContentRepository repository;
  DeleteVideoUseCase(this.repository);
  @override  Future<Either<Failure, void> call(String id) async => Left(ServerFailure('Unimplemented'));
}

class UploadVideoUseCase extends UseCase {
  final VideoContentRepository repository;
  UploadVideoUseCase(this.repository);
  @override  Future<Either<Failure, VideoContentEntity> call(String filePath, String title, String description) async => Left(ServerFailure('Unimplemented'));
}
