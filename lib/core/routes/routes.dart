

import 'package:taskmanager/core/routes/exports.dart';


final appProviders = [
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
  ),      
  ChangeNotifierProvider<TaskProvider>(
    create: (_) => TaskProvider(),
  ),
  
];