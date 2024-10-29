// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:appwrite/appwrite.dart' as _i317;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lets_blog/data/repositories/auth_repository_impl.dart' as _i29;
import 'package:lets_blog/di/modules/app_write_module/app_write_module.dart'
    as _i489;
import 'package:lets_blog/domain/repositories/auth_repository.dart' as _i950;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appWriteModule = _$AppWriteModule();
    gh.singleton<_i317.Client>(() => appWriteModule.appWriteClient);
    gh.singleton<_i317.Account>(
        () => appWriteModule.provideAccount(gh<_i317.Client>()));
    gh.singleton<_i317.Databases>(
        () => appWriteModule.provideDatabase(gh<_i317.Client>()));
    gh.singleton<_i950.AuthRepository>(
        () => _i29.AuthRepositoryImpl(account: gh<_i317.Account>()));
    return this;
  }
}

class _$AppWriteModule extends _i489.AppWriteModule {}
