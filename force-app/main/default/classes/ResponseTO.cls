public with sharing class ResponseTO {
    @AuraEnabled
    public String mensagem {get;set;}

    @AuraEnabled
    public Boolean sucesso {get;set;}

    @AuraEnabled
    public String jsonRetorno {get;set;}

    @AuraEnabled
    public List<Object> lstObject {get;set;}

    @AuraEnabled
    public List<SObject> lstSObject {get;set;}

}