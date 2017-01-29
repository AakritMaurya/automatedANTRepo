trigger OpportunityTrigger on Opportunity(after delete, after insert, after undelete, after update, before delete, before insert, before update) 
{
    if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            if(trigger.new.size() == 1) // Lets only do this if trigger size is 1
            {
                OpportunityPDFGenerator.generateOpportunityPDF(trigger.new[0]);
            }
        }else if(trigger.isUpdate)
        {
            if(trigger.new.size() == 1) // Lets only do this if trigger size is 1
            {
                OpportunityPDFGenerator.generateOpportunityPDF(trigger.new[0]);
            }
        }
    }
}