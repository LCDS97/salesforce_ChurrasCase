public with sharing class ResponseTO {
    @AuraEnabled
    public String mensagem {get;set;}

    @AuraEnabled
    public Boolean sucesso {get;set;}

    @AuraEnabled
    public String jsonRetorno {get;set;}

    @AuraEnabled
    public List<Object> listObject {get;set;}

    @AuraEnabled
    public List<SObject> listSObject {get;set;}

}