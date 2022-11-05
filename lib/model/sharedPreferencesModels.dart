class LoggedUserInfo {
  UserInfo? userInfo;
  Pagamentos? pagamentos;
  Favoritos? favoritos;
  String? continuarLoggado;
  String? idLoggedUser;

  LoggedUserInfo({this.userInfo, this.pagamentos, this.favoritos, this.continuarLoggado, this.idLoggedUser});

  LoggedUserInfo.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
    pagamentos = json['pagamentos'] != null ? Pagamentos.fromJson(json['pagamentos']) : null;
    favoritos = json['favoritos'] != null ? Favoritos.fromJson(json['favoritos']) : null;
    continuarLoggado = json['continuarLoggado'];
    idLoggedUser = json['idLoggedUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    if (this.pagamentos != null) {
      data['pagamentos'] = this.pagamentos!.toJson();
    }
    if (this.favoritos != null) {
      data['favoritos'] = this.favoritos!.toJson();
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
  String? idPagamento;
  String? numeroCartao;
  String? dataValidade;
  String? nomeTitular;
  String? apelidoCartao;
  String? cvv;

  Pagamentos({this.idPagamento, this.numeroCartao, this.dataValidade, this.nomeTitular, this.apelidoCartao, this.cvv});

  Pagamentos.fromJson(Map<String, dynamic> json) {
    idPagamento = json['idPagamento'];
    numeroCartao = json['numeroCartao'];
    dataValidade = json['dataValidade'];
    nomeTitular = json['nomeTitular'];
    apelidoCartao = json['apelidoCartao'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPagamento'] = this.idPagamento;
    data['numeroCartao'] = this.numeroCartao;
    data['dataValidade'] = this.dataValidade;
    data['nomeTitular'] = this.nomeTitular;
    data['apelidoCartao'] = this.apelidoCartao;
    data['cvv'] = this.cvv;
    return data;
  }
}

class Favoritos {
  String? idVendedor;
  String? nomeVendedor;
  String? cpfCnpjVendedor;
  String? emailVendedor;
  String? senhaVendedor;
  String? urlImagemVendedor;
  String? enderecoVendedor;
  String? statusContaVendedor;
  String? selo;

  Favoritos({this.idVendedor, this.nomeVendedor, this.cpfCnpjVendedor, this.emailVendedor, this.senhaVendedor, this.urlImagemVendedor, this.enderecoVendedor, this.statusContaVendedor, this.selo});

  Favoritos.fromJson(Map<String, dynamic> json) {
    idVendedor = json['idVendedor'];
    nomeVendedor = json['nomeVendedor'];
    cpfCnpjVendedor = json['cpfCnpjVendedor'];
    emailVendedor = json['emailVendedor'];
    senhaVendedor = json['senhaVendedor'];
    urlImagemVendedor = json['urlImagemVendedor'];
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
    data['urlImagemVendedor'] = this.urlImagemVendedor;
    data['enderecoVendedor'] = this.enderecoVendedor;
    data['statusContaVendedor'] = this.statusContaVendedor;
    data['selo'] = this.selo;
    return data;
  }
}
