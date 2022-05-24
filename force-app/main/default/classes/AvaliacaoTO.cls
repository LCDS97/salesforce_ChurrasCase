public with sharing class AvaliacaoTO {
    @AuraEnabled
    public String id { get;set; }

    @AuraEnabled
    public Decimal nota { get;set; }

    @AuraEnabled
    public String observacoes { get;set; }

}
