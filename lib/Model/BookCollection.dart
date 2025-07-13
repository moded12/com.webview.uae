class BookCollection {
 late List<Dashboard> dashboard;

  BookCollection({required this.dashboard});

  BookCollection.fromJson(Map<String, dynamic> json) {
    if (json['dashboard'] != null) {
      dashboard = [];
      json['dashboard'].forEach((v) {
        dashboard.add(new Dashboard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
 late String title;
 late String ext;
 late String fileName;
 late String apiUrl;
 late String startPage;
 late String count;

  Dashboard(
      {required this.title,
       required this.ext,
       required this.fileName,
       required this.apiUrl,
       required this.startPage,
       required this.count});

  Dashboard.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    ext = json['ext'];
    fileName = json['file_name'];
    apiUrl = json['api_url'];
    startPage = json['start_page'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['ext'] = this.ext;
    data['file_name'] = this.fileName;
    data['api_url'] = this.apiUrl;
    data['start_page'] = this.startPage;
    data['count'] = this.count;
    return data;
  }
}
