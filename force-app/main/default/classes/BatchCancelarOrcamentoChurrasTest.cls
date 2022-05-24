@isTest

private class BatchCancelarOrcamentoChurrasTest{
    @TestSetup
    static void dataSetup(){
        TestDataFactory.criarOrcamentoComItens(2,2);   
    }

    @isTest 
    static void validarCancelarOrcamentosChurrasSucesso(){
        List<OrcamentoChurras__c> lstOrcamentos = [ SELECT
                                                        Id,
                                                        Fim__c,
                                                        Status__c 
                                                    FROM 
                                                        OrcamentoChurras__c
                                                    WHERE
                                                        Fim__c < LAST_N_DAYS:1 
                                                    AND 
                                                        (   Status__c = 'Agendado'
                                                        OR
                                                            Status__c = 'Novo'
                                                        )
                                                    ];


        Test.startTest();
            BatchCancelarOrcamentoChurras batch = new BatchCancelarOrcamentoChurras();
            Database.executeBatch(batch);
        Test.stopTest();

        OrcamentoChurras__c orcamentoRegistro = [SELECT Id, Status__c FROM OrcamentoChurras__c WHERE Fim__c < LAST_N_DAYS:1 LIMIT 1];
        
        System.assertEquals(orcamentoRegistro.Status__c, 'Cancelado');
    
    }
}