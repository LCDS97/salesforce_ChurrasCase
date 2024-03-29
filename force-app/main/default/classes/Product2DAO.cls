public with sharing class Product2DAO {
    public static List<Product2> buscarProdutosTipoRegistro(Set<Id> setIdsProdutos){
        return [
                SELECT
                    Id,
                    Valor__c,
                    RecordTypeId,
                    Servico__c
                FROM
                    Product2
                WHERE
                    Id
                =:
                    setIdsProdutos
        ];
    }
}
