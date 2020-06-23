import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:turismo_tnt_alumnos/bloc/alojamiento/alojamiento_event.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamiento/alojamiento_state.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamiento/sp_alojamiento_bloc.dart';
import 'package:turismo_tnt_alumnos/data/models/Alojamiento.dart';

class SharedPreferencesBlocDemoScreen extends StatelessWidget {
  static const ROUTE_NAME = '/sp-bloc-demo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SP Bloc demo"),
      ),
      body: BlocProvider(
          create: (context) =>
              SPAlojamientoBloc(httpClient: http.Client())..add(AlojamientoFetched()),
          child: SharedPreferencesBlocDemoUI(),
        ),
    );
  }
}

class SharedPreferencesBlocDemoUI extends StatefulWidget {
  @override
  _SharedPreferencesBlocDemoUIState createState() => _SharedPreferencesBlocDemoUIState();
}

class _SharedPreferencesBlocDemoUIState extends State<SharedPreferencesBlocDemoUI> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 1.0;
  SPAlojamientoBloc _spAlojamientoBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _spAlojamientoBloc = BlocProvider.of<SPAlojamientoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SPAlojamientoBloc, AlojamientoState>(
      builder: (context, state) {
        if (state is AlojamientoFailure) {
          return Center(
            child: Text('failed to fetch alojamientos'),
          );
        }
        if (state is AlojamientoSuccess) {
          if (state.alojamientos.isEmpty) {
            return Center(
              child: Text('no alojamientos'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.alojamientos.length
                  ? BottomLoader()
                  : AlojamientoWidget(alojamiento: state.alojamientos[index]);
            },
            itemCount: state.alojamientos.length + 1,
            controller: _scrollController,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _spAlojamientoBloc.add(AlojamientoFetched());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class AlojamientoWidget extends StatelessWidget {
  final Alojamiento alojamiento;

  const AlojamientoWidget({Key key, @required this.alojamiento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${alojamiento.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(alojamiento.nombre),
      isThreeLine: true,
      subtitle: Text(alojamiento.domicilio),
      dense: true,
    );
  }
}
