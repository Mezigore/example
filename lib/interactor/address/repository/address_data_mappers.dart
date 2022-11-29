import 'package:uzhindoma/api/data/address/new_address.dart';
import 'package:uzhindoma/api/data/address/user_address.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';

UserAddress mapUserAddress(UserAddressData data) {
  return UserAddress(
    id: data.id,
    cityId: data.cityId,
    cityName: data.cityName,
    comment: data.comment,
    coordinates: data.coordinates,
    isDefault: data.isDefault,
    flat: data.flat,
    floor: data.floor,
    name: data.name,
    fullName: data.fullName,
    house: data.house,
    section: data.section,
    street: data.street,
  );
}

NewAddressData mapNewAddressData(NewAddress domain) {
  return NewAddressData(
    comment: domain.comment,
    isDefault: domain.isDefault,
    flat: domain.flat,
    floor: domain.floor,
    name: domain.name,
    section: domain.section,
  );
}
