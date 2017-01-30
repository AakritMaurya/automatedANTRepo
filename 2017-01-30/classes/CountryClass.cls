public class CountryClass
{
public CountryClass(ApexPages.StandardController controller)
{

}
public List<SelectOption> getTypes()
{
Schema.sObjectType sobject_type = account.getSObjectType();
Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();

List<Schema.PicklistEntry> pick_list_values = field_map.get('Active__c').getDescribe().getPickListValues();
List<selectOption> options = new List<selectOption>();
for (Schema.PicklistEntry a : pick_list_values)
{
options.add(new selectOption(a.getLabel(), a.getValue()));
}
return options;
}

}