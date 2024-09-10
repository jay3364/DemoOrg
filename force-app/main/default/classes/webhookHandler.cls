@RestResource(urlMapping='/webhook/*')
global with sharing class webhookHandler {
    @HttpGet
    @RestResource(urlMapping='/accountsApi/')
    global static List<Account> doGetAll() {
      
        List<Account> results = [SELECT Id, Name FROM Account];
        return results;
    }
    }