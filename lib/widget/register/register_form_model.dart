class Model {
  String Name;
  String email;
  String password;
  String phone;
  String City;
  String address;
  String password_confirmation;
  String gender="1";
  String photo;
  String city_id;
  String company;
  String country_id;

  Model(
      {this.Name,
        this.email,
        this.password,
        this.phone,
        this.City,
        this.address,
        this.password_confirmation,
        this.gender,
        this.photo,
        this.city_id,
        this.company,
        this.country_id
      });
}
