import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/sources/remote_data_source.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _error = '';
  String _selectedCountry = 'All';

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get selectedCountry => _selectedCountry;

  List<String> get availableCountries {
    final countries = _users.map((user) => user.country).toSet().toList();
    countries.sort();
    return ['All'] + countries;
  }

  List<User> get filteredUsers {
    if (_selectedCountry == 'All') {
      return _users;
    }
    return _users.where((user) => user.country == _selectedCountry).toList();
  }

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final remoteDataSource = RemoteDataSource();
      final userRepository = UserRepositoryImpl(remoteDataSource: remoteDataSource);
      final getUsersUseCase = GetUsersUseCase(repository: userRepository);

      _users = await getUsersUseCase();
      _error = '';
    } catch (e) {
      _error = 'Failed to load users: $e';
      _users = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }
  void toggleLike(String userId) {
    final index = _users.indexWhere((user) => user.id == userId);
    if (index != -1) {
      _users[index] = _users[index].copyWith(isLiked: !_users[index].isLiked);
      notifyListeners();
    }
  }

  void setSelectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}