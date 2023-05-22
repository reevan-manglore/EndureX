class StepsApiResponse {
  final DateTime date;
  final int steps;
  StepsApiResponse({required this.date, required this.steps});

  factory StepsApiResponse.fromJson(DateTime date, Map<dynamic, dynamic> json) {
    // print(data["bucket"][0]["dataset"][0]["point"][0]["value"]); //prints  [{intVal: 6768, mapVal: []}]
    // print(data["bucket"][0]["dataset"][0]["point"]); //prints  [] i.e to indidcate not data point exist
    int steps = 0;
    if (json["bucket"][0]["dataset"][0]["point"]?.isEmpty) {
      steps = 0;
    } else {
      steps = json["bucket"][0]["dataset"][0]["point"][0]["value"][0]["intVal"];
    }
    return StepsApiResponse(date: date, steps: steps);
  }

  Map<String, dynamic> toJson() {
    return {"date": date, "steps": steps};
  }
}
