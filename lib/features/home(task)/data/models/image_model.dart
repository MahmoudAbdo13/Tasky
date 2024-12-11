import '../../domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  String image;

  ImageModel({required this.image,}): super(image_: image);

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    image: json["image"],
  );
}
