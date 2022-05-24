public with sharing class AvaliacaoBO {
    

    public static ResponseTO buscarAvaliacoesPorOrcamentoChurras(Id idOrcamentoChurras){
        ResponseTO response = new ResponseTO();
            List<Avaliacao__c> lstAvaliacoes = AvaliacaoDAO.buscarAvaliacoesPorIdOrcamentoChurras(idOrcamentoChurras);
            List<AvaliacaoTO> lstAvaliacoesTO = transformarLstAvaliacoesParaLstAvaliacoesTO(lstAvaliacoes);
        try {
            response.mensagem = 'Dados carregados com sucesso!';
            response.sucesso = true;
            response.listObject = lstAvaliacoesTO;
            
        } catch (Exception e) {
            response.mensagem = e.getMessage();
            response.sucesso = false;
            response.listObject = null;

        }

        return response;

        
    }

    private static List<AvaliacaoTO> transformarLstAvaliacoesParaLstAvaliacoesTO(List<Avaliacao__c> lstAvaliacoes){
        List<AvaliacaoTO> lstAvaliacoesTO = new List<AvaliacaoTO>();

        for(Avaliacao__c avaliacao : lstAvaliacoes){
            AvaliacaoTO avaliacaoTO = new avaliacaoTO();

            avaliacaoTO.id = avaliacao.id;
            avaliacaoTO.nota = avaliacao.Nota__c;
            avaliacaoTO.observacoes = avaliacao.Observacoes__c;

            lstAvaliacoesTO.add(avaliacaoTO);
        }

        return lstAvaliacoesTO;
             
    }

    private static List<Avaliacao__c> transformarLstAvaliacoesTOParaLstAvaliacoes(List<AvaliacaoTO> lstAvaliacoesTO){
        List<Avaliacao__c> lstAvaliacoes = new List<Avaliacao__c>();

        for(AvaliacaoTO avaliacaoTO : lstAvaliacoesTO){
            Avaliacao__c avaliacao = new Avaliacao__c();

            avaliacao.id = avaliacaoTO.id;
            avaliacao.Nota__c = avaliacaoTO.nota;
            avaliacao.Observacoes__c = avaliacaoTO.observacoes;

            lstAvaliacoes.add(avaliacao);
        }

        return lstAvaliacoes;
    }
}
