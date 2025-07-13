class AllApps {
  late String message;
 late bool status;
 late List<AppsList> appsList;

  AllApps({required this.message, required this.status, required this.appsList});

  AllApps.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['apps_list'] != null) {
      appsList = <AppsList>[];
      json['apps_list'].forEach((v) {
        appsList.add(new AppsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.appsList != null) {
    //  data['apps_list'] = this.appsList.map((v) => v.toJson()).toList();
    }else{
      data['apps_list'] = this.appsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppsList {
 late String id;
 late String name;
 late String server;
 late String totalPages;
 late String ext;
 late String fileName;
 late String img;
 late String hasCategory;

  AppsList(
      {required this.id,
      required this.name,
      required this.server,
      required this.totalPages,
      required this.ext,
      required this.fileName,
      required this.img,
      required this.hasCategory});

  AppsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    server = json['server'];
    totalPages = json['total_pages'];
    ext = json['ext'];
    fileName = json['file_name'];
    img = json['img'];
    hasCategory = json['hasCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['server'] = this.server;
    data['total_pages'] = this.totalPages;
    data['ext'] = this.ext;
    data['file_name'] = this.fileName;
    data['img'] = this.img;
    data['hasCategory'] = this.hasCategory;
    return data;
  }
}
