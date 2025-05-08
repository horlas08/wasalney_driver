import 'config.dart';

const String baseApiUrl=baseUrl+'/api/v2';
const String basePathImgMain=baseUrl;
const String basePathImgPv=baseUrl+'/api';

const String findAddressUrl=baseApiUrl+'/findAddress';
//main
const String sliderUrl=baseApiUrl+'/getSlider';
const String termsUrl=baseApiUrl+'/terms';
const String gendersUrl=baseApiUrl+'/gender';
const String getMessageUrl=baseApiUrl+'/driver/messages';


const String servicesUrl=baseUrl+'/api/v1'+'/getServices';
const String infoSupportUrl=baseUrl+'/api/v1'+'/getInfoSupport';
const String infoServicesUrl=baseApiUrl+'/getInfoServices';
const String infoProductUrl=baseApiUrl+'/getInfoProduct';
const String provincesUrl=baseApiUrl+'/address/provinces';
const String citiesUrl=baseApiUrl+'/address/cities';
const String sliderTagsUrl=baseApiUrl+'/tag/listWithService';
const String searchTagsUrl=baseApiUrl+'/tag/list';
const String settingUrl=baseApiUrl+'/setting/getInfo';
const String mainInfoUrl=baseApiUrl+'/setting/getMainInfo';
const String tagInfoUrl=baseApiUrl+'/tag/info';
const String linksUrl=baseApiUrl+'/setting/getLinks';
//driver
const String loginUrl=baseApiUrl+'/driver/login';
const String logoutUrl=baseApiUrl+'/driver/logout';
const String setLocationUrl=baseApiUrl+'/driver/setLocation';
const String driverInfoUrl=baseApiUrl+'/driver/getInfo';
const String getUserUrl=baseApiUrl+'/driver/getUser';
const String verifyUrl=baseApiUrl+'/driver/verify';
const String setTokenUrl=baseApiUrl+'/driver/setToken';
const String updateUserUrl=baseApiUrl+'/driver/update';
const String editProfileUrl=baseApiUrl+'/driver/editProfile';
const String editDocUrl=baseApiUrl+'/driver/editCar';
const String changeStateUserUrl=baseApiUrl+'/driver/changeState';
const String setStateDriverUrl=baseApiUrl+'/driver/setState';
const String favoritePlacesUrl=baseApiUrl+'/driver/getFavoritePlaces';
const String addFavoriteUrl=baseApiUrl+'/driver/addFavorite';
const String addWalletUrl=baseApiUrl+'/driver/chargeWallet';
const String deleteFavoriteUrl=baseApiUrl+'/driver/deleteFavorite';
const String addressListUrl=baseApiUrl+'/driver/addresses';
const String addAddressUrl=baseApiUrl+'/address/add';
const String deleteAddressUrl=baseApiUrl+'/driver/deleteAddress';
const String getUserCityUrl=baseApiUrl+'/driverCities';
const String addUserCityUrl=baseApiUrl+'/driverCity/add';
const String deleteUserCityUrl=baseApiUrl+'/driverCity/delete';
const String avatarUrl=baseApiUrl+'/driver/updateAvatar';
const String editDoc1Url=baseApiUrl+'/driver/editDoc1';
const String editDoc2Url=baseApiUrl+'/driver/editDoc2';
const String editDoc3Url=baseApiUrl+'/driver/editDoc3';
const String editDoc4Url=baseApiUrl+'/driver/editDoc4';
const String accountCheckUrl=baseApiUrl+'/driver/accountCheck';
// const String addWalletUrl=baseApiUrl+'/user/chargeWallet';
const String editBankInfoUrl=baseApiUrl+'/driver/addBank';
const String addressFindUrl=baseApiUrl+'/address/find';
const String getDocumentsUrl=baseApiUrl+'/get/documents';
const String dailyReportUrl=baseApiUrl+'/driver/dailyReport';
const String weeklyReportUrl=baseApiUrl+'/driver/weeklyReport';
const String monthlyReportUrl=baseApiUrl+'/driver/monthlyReport';
const String rateReportUrl=baseApiUrl+'/driver/rateReport';

const String categoryListUrl=baseApiUrl+'/category/list';
const String serviceListUrl=baseApiUrl+'/service/list';
const String findServiceUrl=baseApiUrl+'/service/find';
const String relatedServicesUrl=baseApiUrl+'/service/related';
const String serviceProviderListUrl=baseApiUrl+'/service/getProviders';

//order
const String ordersListUrl=baseApiUrl+'/order/all';
const String myOrderUrl=baseApiUrl+'/order/myOrders';
const String acceptOrderUrl=baseApiUrl+'/order/status/accept';
const String arriveOrderUrl=baseApiUrl+'/order/status/arrive';
const String receiveOrderUrl=baseApiUrl+'/order/status/receive';
const String doneOrderUrl=baseApiUrl+'/order/status/done';
const String getCvFilesUrl=baseApiUrl+'/provider/getCvFiles';
const String setMarkProviderUrl=baseApiUrl+'/provider/setMark';
const String reserveProviderUrl=baseApiUrl+'/order/getReservation';
const String giftCodeUrl=baseApiUrl+'/order/checkGiftCode';
const String getOrderMessagesUrl=baseApiUrl+'/order/getMessages';
const String getOrderMessageUrl=baseApiUrl+'/order/getMessage';
const String sendMessageUrl=baseApiUrl+'/order/sendMessage';
const String futureOrderUrl=baseApiUrl+'/order/futureOrders';
const String lastOrdersUrl=baseApiUrl+'/order/lastOrders';

const String questionUrl=baseApiUrl+'/question/getQuestions';
const String getMessageItemUrl=baseApiUrl+'/driver/getMessageAdmin';
const String dateUrl=baseApiUrl+'/order/getDate';
// const String timeUrl=baseApiUrl+'/order/getTime';
const String createOrderUrl=baseApiUrl+'/order/store';
const String getOrderUrl=baseApiUrl+'/order/get';
const String getMyOrderUrl=baseApiUrl+'/order/getMyOrder';
const String getAddOrderUrl=baseApiUrl+'/order/getAddOrder';
const String orderListUrl=baseApiUrl+'/order/myOrders';
const String motorOrderDetailsUrl=baseApiUrl+'/order/orderDetails';
const String confirmOrderUrl=baseApiUrl+'/order/confirm';
const String setRateUrl=baseApiUrl+'/order/setRate';
const String cancelOrderRequestUrl=baseApiUrl+'/order/cancelRequest';
const String cancelOrderUrl=baseApiUrl+'/order/cancel';
const String additionOrderUrl=baseApiUrl+'/order/addition';
const String callProviderUrl=baseApiUrl+'/order/call';
const String callPrivateUrl=baseApiUrl+'/order/callPrivate';

const String payOrderUrl=baseApiUrl+'/payment/order';
const String paymentListUrl=baseApiUrl+'/payment/list';
const String getWalletItemUrl=baseApiUrl+'/driver/getWallet';
const String walletListUrl=baseApiUrl+'/wallet/list';
const String walletIncreaseUrl=baseApiUrl+'/wallet/increase';
const String walletDecreaseUrl=baseApiUrl+'/wallet/decrease';


const String mapApiKey='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjQzYmZhMjc4MzE3ZGNmODFhZDUzZjNmMjQ2MGVhNWFhMzJmMWQ3YzgxNTZkOGM3NmM5OGU4NzE1ZDE4YTRjODM2MTJiOWFkMzAwZmVlZTM3In0.eyJhdWQiOiIxOTA1NiIsImp0aSI6IjQzYmZhMjc4MzE3ZGNmODFhZDUzZjNmMjQ2MGVhNWFhMzJmMWQ3YzgxNTZkOGM3NmM5OGU4NzE1ZDE4YTRjODM2MTJiOWFkMzAwZmVlZTM3IiwiaWF0IjoxNjYwMjMyNjQzLCJuYmYiOjE2NjAyMzI2NDMsImV4cCI6MTY2MjgyNDY0Mywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.Y0kU-dMjtNJs2cpscoHjwGRoeDhCA4y1SfMchiGL9Nxlx4g9HdukvMBoCB00hkGY5UU1Qfaw9iOHQAgqbWD5qCvqelDSs4xDnnLlyCicDsuqpof2eej2l6twSTdDVaFtCOQiG_LcjusPFZIQP7QNuXI5um-2sYLMvPMmKcuzG6EO2GfVM9vtlftRtmTZ2nvKh3GgRKjqOb8lFKAIw3jKSe9qKj2tPActUAraCHpFWYqhb9bKyR-ODAbo2e2AscZKCcxB97-vj9my8w8eeVh_BQ3i34ijiTzpvPDrLaeGfruphSlusKLzG-7nJKpxRTTPXOJaTcpJaFlQ2l2JsTHqpQ';