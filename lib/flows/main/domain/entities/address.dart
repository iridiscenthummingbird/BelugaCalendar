import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String formattedAddress;
  final List<AddressComponent> addressComponents;

  const Address({
    required this.formattedAddress,
    required this.addressComponents,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressComponents: (json['address_components'] as List)
          .map(
            (item) => AddressComponent.fromJson(item),
          )
          .toList(),
      formattedAddress: json['formatted_address'],
    );
  }

  @override
  List<Object?> get props => [formattedAddress, addressComponents];
}

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name'],
      shortName: json['short_name'],
      types: (json['types'] as List)
          .map(
            (item) => item.toString(),
          )
          .toList(),
    );
  }
}
