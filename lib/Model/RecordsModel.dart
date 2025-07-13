class RecordsModel {
 late List<Records> records;

  RecordsModel({required this.records});

  RecordsModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = [];
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
 late String name;
 late String server;
 late String totalPages;
 late String ext;
 late String fileName;
 late String img;
 late String hasCategory;
 late String baseUrl;

  Records(
      {required this.name,
       required this.server,
       required this.totalPages,
       required this.ext,
       required this.fileName,
       required this.img,
       required this.hasCategory,
       required this.baseUrl});

  Records.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    server = json['server'];
    totalPages = json['total_pages'];
    ext = json['ext'];
    fileName = json['file_name'];
    img = json['img'];
    hasCategory = json['hasCategory'];
    baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['server'] = this.server;
    data['total_pages'] = this.totalPages;
    data['ext'] = this.ext;
    data['file_name'] = this.fileName;
    data['img'] = this.img;
    data['hasCategory'] = this.hasCategory;
    data['base_url'] = this.baseUrl;
    return data;
  }
}
