const String appName = 'D Manager';
const String appVersion = '1.0.0';
const String baseUrl = 'https://dm.techtrial.work';

// Auth URLS
const String loginUrl = '$baseUrl/api/login';
const String googleLoginUrl = '$baseUrl/api/google-login-callback';
const String forgotPasswordUrl = '$baseUrl/api/forgot-password';
const String resetPasswordUrl = '$baseUrl/api/reset-password';
const String verifyOtpUrl = '$baseUrl/api/confirm-otp';
const String resendOtpUrl = '$baseUrl/api/forgot-password';
const String changePasswordUrl = '$baseUrl/api/change-password';

// Manage Masters
const String addFirmUrl = '$baseUrl/api/add-firm';
const String firmListUrl = '$baseUrl/api/my-firm';
const String getFirmUrl = '$baseUrl/api/get-firm';
const String updateFirmUrl = '$baseUrl/api/update-firm';
const String updateFirmStatusUrl = '$baseUrl/api/update-firm-status';

const String addPartyUrl = '$baseUrl/api/add-party';
const String partyListUrl = '$baseUrl/api/party';
const String getPartyUrl = '$baseUrl/api/get-party';
const String updatePartyUrl = '$baseUrl/api/update-party';
const String updatePartyStatusUrl = '$baseUrl/api/update-party-status';

const String addClothQualityUrl = '$baseUrl/api/add-quality';
const String clothQualityListUrl = '$baseUrl/api/cloth-quality';
const String getClothQualityUrl = '$baseUrl/api/get-quality';
const String updateClothQualityUrl = '$baseUrl/api/update-quality';
const String updateClothQualityStatusUrl = '$baseUrl/api/update-quality-status';

const String addYarnUrl = '$baseUrl/api/add-yarn';
const String yarnListUrl = '$baseUrl/api/yarn';
const String getYarnUrl = '$baseUrl/api/get-yarn';
const String updateYarnUrl = '$baseUrl/api/update-yarn';
const String updateYarnStatusUrl = '$baseUrl/api/update-yarn-status';

const String addHammalUrl = '$baseUrl/api/add-hammal';
const String hammalListUrl = '$baseUrl/api/hammal';
const String getHammalUrl = '$baseUrl/api/get-hammal';
const String updateHammalUrl = '$baseUrl/api/update-hammal';
const String updateHammalStatusUrl = '$baseUrl/api/update-hammal-status';

const String addTransportUrl = '$baseUrl/api/add-transport';
const String transportListUrl = '$baseUrl/api/transport';
const String getTransportUrl = '$baseUrl/api/get-transport';
const String updateTransportUrl = '$baseUrl/api/update-transport';
const String updateTransportStatusUrl = '$baseUrl/api/update-transport-status';

// Dropdown Lists
const String dropdownFirmListUrl = '$baseUrl/api/firm-list';
const String dropdownPartyListUrl = '$baseUrl/api/party-list';
const String dropdownClothQualityListUrl = '$baseUrl/api/quality-list';
const String dropdownYarnListUrl = '$baseUrl/api/yarn-list';
const String dropdownHammalListUrl = '$baseUrl/api/hammal-list';
const String dropdownTransportListUrl = '$baseUrl/api/transport-list';
const String dropdownStateListUrl = '$baseUrl/api/state-list';

// Manage Yarn Purchase Deals
const String addYarnPurchaseDealUrl = '$baseUrl/api/add-purchase-deal';
const String yarnPurchaseDealListUrl = '$baseUrl/api/yarn-purchase';
const String getYarnPurchaseDealUrl = '$baseUrl/api/get-purchase-deal';
const String updateYarnPurchaseDealUrl = '$baseUrl/api/update-purchase-deal';
const String updateYarnPurchaseDealStatusUrl = '$baseUrl/api/update-purchase-status';

// Manage Delivery Details
const String addDeliveryDetailUrl = '$baseUrl/api/add-delivery';
const String deliveryDetailListUrl = '$baseUrl/api/purchase-deal-details';
const String getDeliveryDetailUrl = '$baseUrl/api/get-delivery-details';
const String updateDeliveryDetailUrl = '$baseUrl/api/update-delivery';

// Manage Sell Deals
const String createSellDeal = '$baseUrl/api/add-sell-deal';
const String sellDealList = '$baseUrl/api/cloth-sell-deal';
const String getSellDeal = '$baseUrl/api/get-sell-deal';
const String updateSellDeal = '$baseUrl/api/update-sell-deal';
const String statusSellDeal = '$baseUrl/api/update-sell-deal-status';
const String activeFirmsList = '$baseUrl/api/firm-list';
const String activePartiesWithoutPagination = '$baseUrl/api/party-list';

// Manage Invoices
const String addInvoiceUrl = '$baseUrl/api/add-invoice';
const String invoiceListUrl = '$baseUrl/api/invoice';
const String getInvoiceUrl = '$baseUrl/api/get-invoice';
const String updateInvoiceUrl = '$baseUrl/api/update-invoice';
const String updateInvoiceStatusUrl = '$baseUrl/api/update-invoice-status';
const String addTransportDetailUrl = '$baseUrl/api/add-transport-details';
const String downloadInvoiceUrl = '$baseUrl/api/download-invoice';

// Reminders
const String yarnToBeReceivedForReminder = '$baseUrl/api/reminder-yarn-to-be-received';
const String yarnPaymentToBePaidForReminder = '$baseUrl/api/reminder-yarn-purchase-payment-due';
const String thansToBeDelivered = '$baseUrl/api/reminder-than-to-be-delivered';
const String paymentToBeReceivedApi = '$baseUrl/api/reminder-cloth-payment-to-be-received';

// History
const String sellHistoryApi = '$baseUrl/api/sale-history';
const String purchaseHistoryApi = '$baseUrl/api/purchase-history';
const String exportSellHistoryApi = '$baseUrl/api/export-sell-history';
const String exportPurchaseHistoryApi = '$baseUrl/api/export-purchase-history';
const String unpaidPurchaseListUrl = '$baseUrl/api/purchase-unpaid';
const String unpaidSellListUrl = '$baseUrl/api/sell-unpaid';

// Invoice list
const String invoiceListApi = '$baseUrl/api/sell-deal-details';
const String getInvoiceApi = '$baseUrl/api/get-invoice';

// Dashboard
const String dashBoardApi = '$baseUrl/api/dashboard';

// GST Return
const String gstReturnApi = '$baseUrl/api/gst-difference';

// Notification
const String notificationListApi = '$baseUrl/api/notification-list';
const String readNotificationApi = '$baseUrl/api/notification-read';

// Manage Inventory
const String inventoryDashboardUrl = '$baseUrl/api/inventory';
const String purchaseInventoryListUrl = '$baseUrl/api/yarn-inventory';
const String sellInventoryListUrl = '$baseUrl/api/cloth-inventory';
const String addInventoryUrl = '$baseUrl/api/add-inventory';
const String getInventoryUrl = '$baseUrl/api/get-inventory';
const String updateInventoryUrl = '$baseUrl/api/update-inventory';




