class TaskModel {
  String title;
  String subTitle;
  String id;
  bool isDone;
  int date;
String userId ;
  TaskModel(
      {required this.title,
      required this.subTitle,
      this.id = "",
      this.isDone = false,
       required this.userId ,
      required this.date});

  // طريقه تانيه للفرم
  // TaskModel fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //       title: json["title"],
  //       subTitle: json["subTitle"],
  //       date: json["date"],
  //       id: json["id"],
  //       isDone: json["isDone"]);
  // }


  // named con :
  TaskModel.fromJson(Map<String, dynamic> json):this(
      userId:json["userId"],
          title: json["title"],
          subTitle: json["subTitle"],
          date: json["date"],
          id: json["id"],
          isDone: json["isDone"]
  );


  Map<String, dynamic> toJson(){
    return {"userId" :userId,
      "title": title,
      "subTitle": subTitle,
      "date": date,
      "id": id,
      "isDone": isDone ,
    };
  }
}
