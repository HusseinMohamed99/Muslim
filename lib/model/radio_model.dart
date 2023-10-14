class RadioModel {
  List<Radios>? radios;

  RadioModel({this.radios});

  RadioModel.fromJson(Map<String, dynamic> json) {
    if (json['radios'] != null) {
      radios = <Radios>[];
      json['radios'].forEach((v) {
        radios!.add(Radios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (radios != null) {
      data['radios'] = radios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Radios {
  int? id;
  String? name;
  String? url;

  Radios({this.id, this.name, this.url});

  Radios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
