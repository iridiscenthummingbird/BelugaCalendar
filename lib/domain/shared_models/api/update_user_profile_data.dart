class UpdateUserProfileData {
  UpdateUserProfileData({
    this.phoneNumber,
    this.email,
    this.isTermsAccepted,
  });

  final String? phoneNumber;
  final String? email;
  final bool? isTermsAccepted;

  Map<String, dynamic> toJson() {
    return {
      if (phoneNumber != null) 
        "phoneNumber": phoneNumber,
      if (email != null) 
        "email": email,
      if (isTermsAccepted != null) 
        "isTermsNConditionsAccepted": isTermsAccepted,
    };
  }
}
