import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../sources/remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getUsers() async {
    return await remoteDataSource.getUsers();
  }
}