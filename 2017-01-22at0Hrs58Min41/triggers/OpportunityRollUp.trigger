trigger OpportunityRollUp on Opportunity(after delete, after insert, after update, after undelete) {

    RollUpSummaryUtility rollup = new RollUpSummaryUtility();
    set<Id> setOppurtunityId = new Set<id>();
    if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
        list<RollUpSummaryUtility.FieldDefinition> fieldDefinitions = new list<RollUpSummaryUtility.FieldDefinition>{new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Roll_up_Field__c')};
        //fieldDefinitions.add(new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Roll_up_Field__c'));
        for(Opportunity iteratorOpportunity: trigger.new){
            setOppurtunityId.add(iteratorOpportunity.id);
        }
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, setOppurtunityId , 'Opportunity', 'Opportunities', 'Account', '');
    }

    if(trigger.isDelete){
        list<RollUpSummaryUtility.FieldDefinition> fieldDefinitions = new list<RollUpSummaryUtility.FieldDefinition>();
        fieldDefinitions.add(new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Roll_up_Field__c'));
        for(Opportunity iteratorOpportunity: trigger.old){
            setOppurtunityId.add(iteratorOpportunity.id);
        }
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, setOppurtunityId , 'Opportunity', 'Opportunities', 'Account', '');
    }
}