public class TestPageController {

public TestPageController() {

    }
    public List < gaugeData > getData() {
        double NPS_score = 0;
        Account score = [Select Id, Name, score__c, score1__c From Account Where id ='0019000000o5tLm'LIMIT 1];
        Account score1 = [Select Id, Name, score1__c From Account LIMIT 1];
        List < gaugeData > data = new List < gaugeData >();
        data.add(new gaugeData('AMT1', score.score1__c));
        data.add(new gaugeData('AMT1', score.score__c));


        return data;
    }
    
    public class gaugeData {
    public String name {get;set;}
    public decimal score {get;set;}
    public gaugeData(String name, decimal npsScore) {
        this.name = name;
        this.score = npsScore;
    }
    }

}