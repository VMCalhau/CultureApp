import 'package:culture_app/models/Location.dart';

class Event {
  String nome;
  String descricao;
  String url;
  String imagem;
  Location localizacao;

  Event(this.nome, this.descricao, this.url, this.imagem, this.localizacao);

}