class Constants {}

class PaymentMethod {
  static int CASH = 1;
}

class OrderStatus {
  static final int FINDING = 0;
  static final int PREPARING = 1;
  static final int DELIVERING = 2;
  static final int DELIVERD = 3;
  static final int REVICED = 4;
}
// const String FINDING = 'FINDING';
// const String PREPARING = 'PREPARING';
// const String DELIVERING = 'DELIVERING';
// const String DELIVERD = 'DELIVERD';
// const String REVICED = 'REVICED';

// const Map<String, int> OrderStatus = {
//   FINDING: 0,
//   PREPARING: 1,
//   DELIVERING: 2,
//   DELIVERD: 3,
//   REVICED: 4
// };

class NotificationStaus {
  static int UNREAD = 0;
  static int READED = 1;
}

class TypeOfStore {
  static int RICE = 0;
  static int NOODLES = 1;
  static int DRINK = 2;
  static int FASTFOOD = 3;
  static int HEALTHY = 4;
  static int SNACKS = 5;
}
