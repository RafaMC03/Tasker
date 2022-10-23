import 'dart:convert';

class Usuario {
  final String? nome;
  final String? email;

  Usuario({
    required this.nome,
    required this.email,
  });

  Usuario copyWith({
    String? nome,
    String? email,
  }) {
    return Usuario(
      nome: nome ?? this.nome,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(nome != null){
      result.addAll({'nome': nome});
    }
    if(email != null){
      result.addAll({'email': email});
    }
  
    return result;
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));

  @override
  String toString() => 'Usuario(nome: $nome, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Usuario &&
      other.nome == nome &&
      other.email == email;
  }

  @override
  int get hashCode => nome.hashCode ^ email.hashCode;

  bool isValid(){
    if (nome!.isEmpty || nome == null || email!.isEmpty || email == null) {
      throw Exception('Campos obrigatórios não informados!');
    }
    return true;
  }
}
