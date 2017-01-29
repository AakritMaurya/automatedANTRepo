trigger CreateOpp on Account (after insert, after update) 
{
//new list to add the new opps we are inserting
      LIST<Opportunity> lstOpps= new LIST<Opportunity>();
//loop through new Accounts
for(Account Acc : trigger.new){
//create a new opportunity 'opp'
       Opportunity opp = new Opportunity();
//name the opportunity and assign the fields
opp.Name = Acc.Name; 
opp.AccountId = Acc .Id;
opp.CloseDate = System.Today().adddays(50);
opp.Amount = Acc.AnnualRevenue;
//opp.RecordTypeId = Acc.RecordTypeId;
opp.StageName = 'Prospecting';
//add the new opp to the list
lstOpps.add(opp);
}

insert lstOpps; 

}