enum DynamicLinkType { emailLink, anonymous }

extension DynamicLinkTypeExtension on DynamicLinkType {
  String get subDomain {
    switch (this) {
      case DynamicLinkType.emailLink:
        return 'email-link-type';
      case DynamicLinkType.anonymous:
        return 'anonymous-type';
        break;
    }
  }
}
