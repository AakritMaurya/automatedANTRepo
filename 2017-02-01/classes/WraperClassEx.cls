public with sharing class WraperClassEx 
{
    List<Account> LstAcc = new List<Account>();
    List<Contact> LstCon = new List<Contact>();
    
    public List<wrapper> lstwrap = new List<wrapper>();
    
    public List<wrapper> getLstWrapper()
    {
        LstAcc = [SELECT Name, AccountSource FROM Account];
        LstCon = [SELECT Name, Languages__c FROM Contact];
        
        for(Integer i=0; i<LstCon.size(); i++)
        {
            lstwrap.add(new wrapper(LstAcc[i].Name, LstAcc[i].AccountSource, LstCon[i].Name, LstCon[i].Languages__c));
        }
        return lstwrap;
    }
    
    public class wrapper
    {
        public String Aname{get;set;}
        public String ASource{get;set;}
        public String CName{get;set;}
        public String CLang{get;set;}
        
        public wrapper(String Aname, String ASource, String CName, String CLang)
        {
            this.Aname = Aname;
            this.ASource = ASource;
            this.CName = CName;
            this.CLang = CLang;
        }
    }
}