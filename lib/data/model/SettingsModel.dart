class SettingsModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  SettingsModel({this.status, this.errNum, this.msg, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? id;
  String? websiteName;
  String? websiteLogo;
  String? websiteWideLogo;
  String? websiteIcon;
  String? websiteCover;
  String? address;
  String? websiteBio;
  String? contactEmail;
  String? phone;
  String? phone2;
  String? whatsappPhone;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? youtubeLink;
  String? telegramLink;
  String? whatsappLink;
  String? tiktokLink;
  String? upworkLink;
  String? nafezlyLink;
  String? linkedinLink;
  String? githubLink;
  String? contactPage;
  String? anotherLink1;
  String? anotherLink2;
  String? anotherLink3;
  String? mainColor;
  String? hoverColor;
  String? headerCode;
  String? footerCode;
  String? robotsTxt;
  String? privacyPolicy;
  String? termsAndConditions;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.websiteName,
        this.websiteLogo,
        this.websiteWideLogo,
        this.websiteIcon,
        this.websiteCover,
        this.address,
        this.websiteBio,
        this.contactEmail,
        this.phone,
        this.phone2,
        this.whatsappPhone,
        this.facebookLink,
        this.twitterLink,
        this.instagramLink,
        this.youtubeLink,
        this.telegramLink,
        this.whatsappLink,
        this.tiktokLink,
        this.upworkLink,
        this.nafezlyLink,
        this.linkedinLink,
        this.githubLink,
        this.contactPage,
        this.anotherLink1,
        this.anotherLink2,
        this.anotherLink3,
        this.mainColor,
        this.hoverColor,
        this.headerCode,
        this.footerCode,
        this.robotsTxt,
        this.privacyPolicy,
        this.termsAndConditions,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    websiteName = json['website_name'];
    websiteLogo = json['website_logo'];
    websiteWideLogo = json['website_wide_logo'];
    websiteIcon = json['website_icon'];
    websiteCover = json['website_cover'];
    address = json['address'];
    websiteBio = json['website_bio'];
    contactEmail = json['contact_email'];
    phone = json['phone'];
    phone2 = json['phone2'];
    whatsappPhone = json['whatsapp_phone'];
    facebookLink = json['facebook_link'];
    twitterLink = json['twitter_link'];
    instagramLink = json['instagram_link'];
    youtubeLink = json['youtube_link'];
    telegramLink = json['telegram_link'];
    whatsappLink = json['whatsapp_link'];
    tiktokLink = json['tiktok_link'];
    upworkLink = json['upwork_link'];
    nafezlyLink = json['nafezly_link'];
    linkedinLink = json['linkedin_link'];
    githubLink = json['github_link'];
    contactPage = json['contact_page'];
    anotherLink1 = json['another_link1'];
    anotherLink2 = json['another_link2'];
    anotherLink3 = json['another_link3'];
    mainColor = json['main_color'];
    hoverColor = json['hover_color'];
    headerCode = json['header_code'];
    footerCode = json['footer_code'];
    robotsTxt = json['robots_txt'];
    privacyPolicy = json['privacy_policy'];
    termsAndConditions = json['terms_and_conditions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}