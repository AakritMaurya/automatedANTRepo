trigger AccountDuplicate on Account (before insert, before update)
{
    for (Account a: Trigger.new)
    {
        List<Account> acc = [SELECT Id FROM Account WHERE Name=:a.Name and Rating=:a.Rating];
        
        if (acc.size() > 0)
        {
            a.Name.addError('Account already Exists! You cannot create Duplicate Accounts');
        }
    }
}