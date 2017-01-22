global class WebServiceExample {
webservice static ID createProject(String name) {
Destination__c dest = new Destination__c(Name = name);
insert dest;
return dest.Id;
}
}