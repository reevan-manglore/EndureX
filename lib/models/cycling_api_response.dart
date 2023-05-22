class CyclingApiResponse {
  final DateTime date;
  final double distanceCoverd;
  CyclingApiResponse({required this.date, required this.distanceCoverd});

  factory CyclingApiResponse.fromJson(
      DateTime date, Map<dynamic, dynamic> json) {
    // print(data["bucket"][0]["dataset"][0]["point"][0]["fpVal"]); //prints  [{"fpVal": 5066.7888, mapVal: []}]
    // print(data["bucket"][0]["dataset"][0]["point"]); //prints  [] i.e to indidcate not data point exist
    double steps = 0;
    print("data before converting ${json["bucket"][0]["dataset"][0]["point"]}");
    if (json["bucket"][0]["dataset"][0]["point"]?.isEmpty) {
      steps = 0;
    } else {
      steps = json["bucket"][0]["dataset"][0]["point"][0]["value"][0]["fpVal"];
    }
    return CyclingApiResponse(date: date, distanceCoverd: steps);
  }

  Map<String, dynamic> toJson() {
    return {"date": date, "steps": distanceCoverd};
  }
}
