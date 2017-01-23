public class CtrlInvoiceMgt
{
    public Id InvoiceMgtID;
    public Invoice__c Invi{get;set;}

    public CtrlInvoiceMgt (ApexPages.StandardController controller)
    {
        InvoiceMgtID = ((Invoice__c)controller.getRecord()).id;
    }
    public void Submit()
    {
    
    }
}