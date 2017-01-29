public class MyAccountListCntrlr {
     // PROPERTIES
     public List<AccountWrapperCls> acctList {get;set;}
     public Set<String> selAccountNames {get;set;}
     public Boolean hasSelAcct {get;set;}

     // CONSTRUCTOR
     public MyAccountListCntrlr(){
          acctList = new List<AccountWrapperCls>();
          selAccountNames = new Set<String>();

          for(Account a : [SELECT AccountNumber, Name 
          FROM Account WHERE AccountNumber != NULL 
          LIMIT 5]){
               acctList.add(new AccountWrapperCls(a));
          }
     }

     // METHODS
     public void displaySelectedAccountNumbers(){
          selAccountNames.clear();
          hasSelAcct = false;
          for(AccountWrapperCls cWrapper : acctList){
               if(cWrapper.isSelected){
                    hasSelAcct = true;
                    selAccountNames.add(cWrapper.cAccount.AccountNumber);
               }
          }
     }
     
     public class AccountWrapperCls {
     public Boolean isSelected {get;set;}
     public Account cAccount {get;set;}

     public AccountWrapperCls(Account cAccount){
          this.cAccount = cAccount;
     }
}
}