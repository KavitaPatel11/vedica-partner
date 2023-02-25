class Endpoint {
  static String baseUrl = "http://139.59.22.125:7050/v1/";
  static String login = "auth/login";
  static String updateUser = "investor/onboard";
  static String otoVerification = "auth/verify";
  static String profile = "investor";
  static String getAllPortfolio = "investor/all/portfolio";
  static String getBalance = "investor/balance";
  static String getAllTransactions = "investor/all/transaction";
  static String getWithdrawlTransactions = "investor/withdrawl/transaction";
  static String editBank = "investor/edit/bank";
  static String getBank = "investor/bank";
  static String updateLocking = "investor/edit/locking/";
  static String addKyc = "investor/add/kyc";
  static String getKyc = "investor/kyc";
  static String addNominee = "investor/add/nominee";
  static String getNominee = "investor/nominee";
  static String createWithdrawlRequest = "investor/create/withdrawl";
  static String addBank = "investor/add/bank";
  static String addPortfolio = "investor/add/portfolio";

  static int timeout = 60;
}
