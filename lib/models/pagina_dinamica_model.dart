// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaginaDinamicaModel {
  final String endpoint;
  final String titulo;
  final String? leading;
  final List<Map<String, dynamic>> payload;
  final List<Map<String, dynamic>>? drawer;
  PaginaDinamicaModel({
    required this.endpoint,
    required this.titulo,
    this.leading,
    required this.payload,
    this.drawer,
  });

  PaginaDinamicaModel copyWith({
    String? endpoint,
    String? titulo,
    String? leading,
    List<Map<String, dynamic>>? payload,
    List<Map<String, dynamic>>? drawer,
  }) {
    return PaginaDinamicaModel(
      endpoint: endpoint ?? this.endpoint,
      titulo: titulo ?? this.titulo,
      leading: leading ?? this.leading,
      payload: payload ?? this.payload,
      drawer: drawer ?? this.drawer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endpoint': endpoint,
      'titulo': titulo,
      'leading': leading,
      'payload': payload,
      'drawer': drawer,
    };
  }

  factory PaginaDinamicaModel.fromMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> payloadList =
        List<Map<String, dynamic>>.from(map['payload'] as List);
    payloadList = payloadList.map((item) {
      return item.map((key, value) {
        if (value is int) {
          return MapEntry(key, value.toString());
        }
        return MapEntry(key, value);
      });
    }).toList();

    List<Map<String, dynamic>> drawerList =
        List<Map<String, dynamic>>.from(map['drawer'] as List);
    drawerList = drawerList.map((item) {
      return item.map((key, value) {
        if (value is int) {
          return MapEntry(key, value.toString());
        }
        return MapEntry(key, value);
      });
    }).toList();

    return PaginaDinamicaModel(
      endpoint: map['endpoint'] as String,
      titulo: map['title'] as String,
      leading: map['leading'] as String?,
      payload: payloadList,
      drawer: drawerList,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginaDinamicaModel.fromJson(String source) =>
      PaginaDinamicaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaginaDinamicaModel(endpoint: $endpoint, titulo: $titulo, leading: $leading, payload: $payload, drawer: $drawer)';
  }

  @override
  bool operator ==(covariant PaginaDinamicaModel other) {
    if (identical(this, other)) return true;

    return other.endpoint == endpoint &&
        other.titulo == titulo &&
        other.leading == leading &&
        listEquals(other.payload, payload) &&
        listEquals(other.drawer, drawer);
  }

  @override
  int get hashCode {
    return endpoint.hashCode ^
        titulo.hashCode ^
        leading.hashCode ^
        payload.hashCode ^
        drawer.hashCode;
  }
}
