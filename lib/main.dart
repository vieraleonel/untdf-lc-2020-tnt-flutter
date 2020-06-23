import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/HomeScreen.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(
        uri: 'http://192.168.1.10:8080/v1/graphql',
      ),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: this.client,
      child: MaterialApp(
        title: 'Travel App',
        initialRoute: HomeScreen.ROUTE_NAME,
        routes: routes,
      )
    );
  }
}
