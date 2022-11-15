class LoggedUserInfo {
  UserInfo? userInfo;
  List<Pagamentos>? pagamentos;
  List<Favoritos>? favorito;
  String? continuarLoggado;
  String? idLoggedUser;

  LoggedUserInfo({this.userInfo, this.pagamentos, this.favorito, this.continuarLoggado, this.idLoggedUser});

  LoggedUserInfo.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null ? new UserInfo.fromJson(json['userInfo']) : null;
    if (json['pagamentos'] != null) {
      pagamentos = <Pagamentos>[];
      json['pagamentos'].forEach((v) {
        pagamentos!.add(new Pagamentos.fromJson(v));
      });
    }
    if (json['favorito'] != null) {
      favorito = <Favoritos>[];
      json['favorito'].forEach((v) {
        favorito!.add(new Favoritos.fromJson(v));
      });
    }
    continuarLoggado = json['continuarLoggado'];
    idLoggedUser = json['idLoggedUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    if (this.pagamentos != null) {
      data['pagamentos'] = this.pagamentos!.map((v) => v.toJson()).toList();
    }
    if (this.favorito != null) {
      data['favorito'] = this.favorito!.map((v) => v.toJson()).toList();
    }
    data['continuarLoggado'] = this.continuarLoggado;
    data['idLoggedUser'] = this.idLoggedUser;
    return data;
  }
}

class UserInfo {
  int? idCliente;
  String? nomeCliente;
  String? cpfCliente;
  String? emailCliente;
  String? senhaCliente;
  String? statusCliente;

  UserInfo({this.idCliente, this.nomeCliente, this.cpfCliente, this.emailCliente, this.senhaCliente, this.statusCliente});

  UserInfo.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    nomeCliente = json['nomeCliente'];
    cpfCliente = json['cpfCliente'];
    emailCliente = json['emailCliente'];
    senhaCliente = json['senhaCliente'];
    statusCliente = json['statusCliente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCliente'] = this.idCliente;
    data['nomeCliente'] = this.nomeCliente;
    data['cpfCliente'] = this.cpfCliente;
    data['emailCliente'] = this.emailCliente;
    data['senhaCliente'] = this.senhaCliente;
    data['statusCliente'] = this.statusCliente;
    return data;
  }
}

class Pagamentos {
  int? idPagamento;
  String? numeroCartao;
  String? dataValidade;
  String? apelidoCartao;
  String? nomeTitular;
  String? cvv;

  Pagamentos({this.idPagamento, this.numeroCartao, this.dataValidade, this.apelidoCartao, this.nomeTitular, this.cvv});

  Pagamentos.fromJson(Map<String, dynamic> json) {
    idPagamento = json['idPagamento'];
    numeroCartao = json['numeroCartao'];
    dataValidade = json['dataValidade'];
    apelidoCartao = json['apelidoCartao'];
    nomeTitular = json['nomeTitular'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPagamento'] = this.idPagamento;
    data['numeroCartao'] = this.numeroCartao;
    data['dataValidade'] = this.dataValidade;
    data['apelidoCartao'] = this.apelidoCartao;
    data['nomeTitular'] = this.nomeTitular;
    data['cvv'] = this.cvv;
    return data;
  }
}

class Favoritos {
  int? idVendedor;
  String? nomeVendedor;
  String? cpfCnpjVendedor;
  String? emailVendedor;
  String? senhaVendedor;
  String? urlImagenVendedor;
  String? enderecoVendedor;
  int? statusContaVendedor;
  dynamic? selo;

  Favoritos({this.idVendedor, this.nomeVendedor, this.cpfCnpjVendedor, this.emailVendedor, this.senhaVendedor, this.urlImagenVendedor, this.enderecoVendedor, this.statusContaVendedor, this.selo});

  Favoritos.fromJson(Map<String, dynamic> json) {
    idVendedor = json['idVendedor'];
    nomeVendedor = json['nomeVendedor'];
    cpfCnpjVendedor = json['cpfCnpjVendedor'];
    emailVendedor = json['emailVendedor'];
    senhaVendedor = json['senhaVendedor'];
    urlImagenVendedor = json['urlImagenVendedor'];
    enderecoVendedor = json['enderecoVendedor'];
    statusContaVendedor = json['statusContaVendedor'];
    selo = json['selo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idVendedor'] = this.idVendedor;
    data['nomeVendedor'] = this.nomeVendedor;
    data['cpfCnpjVendedor'] = this.cpfCnpjVendedor;
    data['emailVendedor'] = this.emailVendedor;
    data['senhaVendedor'] = this.senhaVendedor;
    data['urlImagenVendedor'] = this.urlImagenVendedor;
    data['enderecoVendedor'] = this.enderecoVendedor;
    data['statusContaVendedor'] = this.statusContaVendedor;
    data['selo'] = this.selo;
    return data;
  }
}
