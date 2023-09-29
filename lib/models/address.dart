class Address {
  String country;
  String city;
  String street;
  String houseNumber;

  Address({
    required this.country,
    required this.city,
    required this.street,
    required this.houseNumber,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      city: json['city'],
      street: json['street'],
      houseNumber: json['houseNumber'],
    );
  }

  String getFullAddress() {
    return '$street  #$houseNumber, $city, $country';
  }
}
