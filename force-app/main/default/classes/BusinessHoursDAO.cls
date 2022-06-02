public with sharing class BusinessHoursDAO {
    
    public static BusinessHours buscarHorarioComercial(){
        return [
                    SELECT
                        Id 
                    FROM 
                        BusinessHours
                    WHERE
                        IsDefault = true
        ];
    }
}
