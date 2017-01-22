trigger CreateInvoice on Opportunity (after insert)
{
    double upcharge = 1.2;
    
    List<Invoice__c> newInvoices = new List<Invoice__c> ();
    
    for (Opportunity oppa : Trigger.new)
    {
        Invoice__c freshInvoice = new Invoice__c();


        

        
        newInvoices.add(freshInvoice);
    }
    
    insert newInvoices;
    
}