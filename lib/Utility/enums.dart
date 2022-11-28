class AccessToken {
  static String? token;
}

enum TextFieldType {
  numberOrEmail,
  name,
  email,
  password,
  mobile,
  custom,
  date,
  clock,
  location,
  tripName,
}

enum CircularButtonType { invite, milestone }

enum MilestoneType { from, to }

enum CreateTripType { from, to }
