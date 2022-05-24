public with sharing class AvaliarChurrasController {
    @AuraEnabled
    public static ResponseTO buscarAvaliacoesPorOrcamentoChurras(Id idOrcamentoChurras){
        return AvaliacaoBO.buscarAvaliacoesPorOrcamentoChurras(idOrcamentoChurras);
    }
}
