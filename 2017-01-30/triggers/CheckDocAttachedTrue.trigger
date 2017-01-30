trigger CheckDocAttachedTrue on Destination__c (before insert, before update) 
{
    for(Destination__c Dest: trigger.new)
    {
        Dest.Document_Attached__c = true;
        Dest.Handoff_Attahced__c= 'Yes';
    }   
}