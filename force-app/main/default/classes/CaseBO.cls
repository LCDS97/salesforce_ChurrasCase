/**
 * @Descrição                : Case Business Object
 * @Autor                    : 
 * @Empresa:                 : Everymind LTDA.
 * @Ultima modificação em:   : [05, 06, 2022]
 * @Ultima modificação por:  : Lucas Conceição dos Santos / lucas.santos@everymind.com.br
**/
public with sharing class CaseBO {
    
    public static void setTempoDiasUteis(List<Case> triggerNew, Map<Id,Case> triggerOldMap){

        Long businessHoursDiff;
        Long mins;
        Long hours;
        Long remainingMins;


        
        BusinessHours bh = BusinessHoursDAO.buscarHorarioComercial();

        for(Case caso : triggerNew){
            Datetime dataEntrada = caso.EntradaProduto__c;
            Datetime dataSaida = caso.SaidaProduto__c;

            businessHoursDiff = BusinessHours.diff(bh.id,dataEntrada,dataSaida);

            mins = businessHoursDiff / 60000;
            hours = mins / 60;
            remainingMins = mins - ( hours * 60);
            String totalTime = String.valueOf(hours) + ' hrs ' + String.valueOf(remainingMins) + ' mins úteis';
            String totalTimeHourMin = validarFormatoDataHora(hours, remainingMins);

            caso.TempoDiasUteis__c = totalTime;
            caso.TempoDiasUteisFormatoHora__c = totalTimeHourMin;

        }

    }

    @TestVisible
    private static String validarFormatoDataHora(Long hours, Long mins){
        String horaMinFormatada;

         if(hours >= 0 && hours < 10 && mins >= 10){
            horaMinFormatada = '0' + String.valueOf(hours) + ':' + String.valueOf(mins);

        }   else if (mins >= 0 && mins < 10 && hours >= 10){
            horaMinFormatada = String.valueOf(hours) + ':0' + String.valueOf(mins);

        }  else if ((hours >= 0 && hours < 10) && (mins >= 0 && mins < 10)){
            horaMinFormatada = '0' + String.valueOf(hours) + ':0' + String.valueOf(mins);
        } else {
            horaMinFormatada = String.valueOf(hours) + ':' + String.valueOf(mins);
        }

        return horaMinFormatada;
    }


}
