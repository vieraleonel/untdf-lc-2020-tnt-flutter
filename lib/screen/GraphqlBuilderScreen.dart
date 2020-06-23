import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlBuilderScreen extends StatefulWidget {
  static const ROUTE_NAME = '/graphql-builder';

  @override
  _GraphqlBuilderScreen createState() => _GraphqlBuilderScreen();
}

class _GraphqlBuilderScreen extends State<GraphqlBuilderScreen> {
  final String gastronomicosQuery = """
    query GastronimicosPorLocalidad(\$localidad: Int) {
      gastronomicos(where: {localidad_id: {_eq: \$localidad}}) {
        id
        nombre
        domicilio
        localidade {
          nombre
        }
      }
    }
  """;

  final String gastronomicoAdd = """
    mutation addGastronomico(\$nombre: String, \$localidad_id: Int, \$lng: numeric, \$lat: numeric, \$foto: String, \$domicilio: String) {
      insert_gastronomicos(objects: {nombre: \$nombre, localidad_id: \$localidad_id, lng: \$lng, lat: \$lat, foto: \$foto, domicilio: \$domicilio}) {
        returning {
          id
          nombre
          domicilio
          localidade {
            nombre
          }
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GraphQL builder'),
        ),
        body: Query(
          options: QueryOptions(
            documentNode: gql(
                gastronomicosQuery), // this is the query string you just created
            variables: {
              'localidad': 3
            },
            // pollInterval: 10,
          ),
          // Just like in apollo refetch() could be used to manually trigger a refetch
          // while fetchMore() can be used for pagination purpose
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.loading) {
              return Text('Loading');
            }

            // it can be either Map or List
            List gastronomicos = result.data['gastronomicos'];

            return Column(
              children: <Widget>[
                RaisedButton(
                  color: Colors.indigo,
                  onPressed: refetch,
                  padding: EdgeInsets.all(10),
                  child: Text('Fetch More',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Mutation(
                  options: MutationOptions(
                    documentNode: gql(gastronomicoAdd), // this is the mutation string you just created
                    // you can update the cache based on results
                    update: (Cache cache, QueryResult result) {
                      print(result.data);
                      refetch();
                    },
                    // or do something with the result.data on completion
                    onCompleted: (dynamic resultData) {
                      //print(resultData);
                    },
                    onError: (error) => {
                      print(error)
                    }
                  ),
                  builder: (
                    RunMutation runMutation,
                    QueryResult result,
                  ) {
                    return RaisedButton(
                      color: Colors.indigo,
                      onPressed: () => runMutation({
                        "nombre": "6 Restó desde btn",
                        "localidad_id": 3,
                        "lng":0,
                        "lat":0,
                        "foto": "",
                        "domicilio": "Tolhuin 123"
                      }),
                      padding: EdgeInsets.all(10),
                      child: Text('Add gastronómico',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: gastronomicos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          title: Text(gastronomicos[index]['nombre']),
                          trailing:
                              Text(gastronomicos[index]['localidade']['nombre']),
                        );
                      }),
                )
              ],
            );
          },
        ));
  }
}
