public with sharing class locationController{
 
    public list<Account> locationList{get;set;}
 
    public locationController(){
        locationList = [Select ID,  UpsellOpportunity__c, CustomerPriority__c From Account limit 1];
    }
     
}