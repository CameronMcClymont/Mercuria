import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:challenge_3/cargo.dart';
import 'package:challenge_3/voyage.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  List<Voyage> voyage_list;
  List<Cargo> cargo_list;

  MatchPage({Key? key, required this.voyage_list, required this.cargo_list}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Number of voyage entries: ${widget.voyage_list.length}'),
            Text('Number of cargo entries: ${widget.cargo_list.length}'),
            const SizedBox(height: 16),
            FutureBuilder<http.Response>(
              future: http.get(
                Uri.parse('https://api.hackathon.mercuria-apps.com/api/ais-hourly/?imo=9187643'),
                headers: {
                  // Todo: security of API token
                  HttpHeaders.authorizationHeader: 'Token 9ca61ddaff632398f35fcaa19348fec9b3fbd449',
                },
              ),
              builder: (_, AsyncSnapshot<http.Response> response) {
                if (response.hasData) {
                  final body = json.decode(response.data!.body);
                  return Text('Data (${body['results'].length} results, ${body["count"]}): ${body['results'][0]}');
                } else if (response.hasError) {
                  return Text('Error: ${response.error}');
                } else {
                  return const Text('Fetching...');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
