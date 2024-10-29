import 'package:appwrite/appwrite.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppWriteModule {
  @singleton
  Client get appWriteClient {
    const projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
    return Client().setProject(projectId);
  }

  @singleton
  Account provideAccount(Client client) => Account(client);

  @singleton
  Databases provideDatabase(Client client) => Databases(client);
}
