public with sharing class ItemOrcamentoChurrasDAO {
    
        public static List<ItemOrcamentoChurras__c> buscarItemOrcamentoPorIdEProduto(Set<Id> setIdOrcamentoChurras, Set<Id> setProductItem){
            return [
                    SELECT
                        Id,
                        Produto__c
                    FROM
                        ItemOrcamentoChurras__c
                    WHERE
                        OrcamentoChurras__c
                    =:
                        setIdOrcamentoChurras
                    AND
                        Produto__c
                    =: 
                        setProductItem
            ];
        }
    
}
