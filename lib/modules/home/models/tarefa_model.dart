import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaAgendada {
  final String titulo;
  final String descricao;
  final DateTime data;
  final String id;

  TarefaAgendada({
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.id,
  });

  TarefaAgendada copyWith({
    String? titulo,
    String? descricao,
    DateTime? data,
    String? id,
  }) {
    return TarefaAgendada(
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'titulo': titulo});
    result.addAll({'descricao': descricao});
    result.addAll({'data': data});
    result.addAll({'id': id});

    return result;
  }

  factory TarefaAgendada.fromMap(Map<String, dynamic> map) {
    return TarefaAgendada(
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      data: (map['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TarefaAgendada.fromJson(String source) =>
      TarefaAgendada.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TarefaAgendada(titulo: $titulo, descricao: $descricao, data: $data, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TarefaAgendada &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.data == data &&
        other.id == id;
  }

  @override
  int get hashCode {
    return titulo.hashCode ^ descricao.hashCode ^ data.hashCode ^ id.hashCode;
  }
}
