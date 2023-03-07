@isTest

public class ClonarOrcamentoChurrasControllerTest {

    @TestSetup
    static void dataSetup(){
        TestDataFactory.criarOrcamentoComContatoItens(2,2,2);   
    }


    @isTest
    private static void clonarAnexosValida(){

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


    

    

    }

}
