trigger dateUpdate on Account  (before insert, before update)
{
    for(Account  p : trigger.New)
    {
		if(p.Destinatinon_Date_Field__c == null)
		{	
         p.Source_Date_Field__c = p.Destinatinon_Date_Field__c.addDays(364);
		}
    }
}