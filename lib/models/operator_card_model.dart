import 'package:ewallet_app/models/data_plan_model.dart';

class OperatorCardModel {
  final int? id;
  final String? name;
  final String? thumbnail;
  final List<DataPlanModel>? dataPlans;

  OperatorCardModel({this.id, this.name, this.thumbnail, this.dataPlans});

  factory OperatorCardModel.fromJson(Map<String, dynamic> json) =>
      OperatorCardModel(
          id: json['id'],
          name: json['name'],
          thumbnail: json['thumbnail'],
          dataPlans: json['data_plans'] == null
              ? null
              : (json['data_plans'] as List)
                  .map((dataPlan) => DataPlanModel.fromJson(dataPlan))
                  .toList());
}
