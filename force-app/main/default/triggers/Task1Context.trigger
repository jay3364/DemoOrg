trigger Task1Context on Account (before insert,before update,before delete, after insert,after update, after delete, after undelete) {
    //TriggerHandler1 TH1 = new TriggerHandler1();
    if(Trigger.IsBefore){
        if(Trigger.isInsert){
            System.debug('trigger is before insert '+Trigger.new);
            TriggerHandler1.beforeInsert(Trigger.new);

        }
        else if(Trigger.isUpdate){
           /* System.debug('trigger is before update New '+ Trigger.new);
            System.debug('trigger is before update old '+ Trigger.old);
            System.debug('Trigger.newMap: ' + Trigger.newMap);
            System.debug('Trigger.oldMap: ' + Trigger.oldMap);*/
            TriggerHandler1.beforeUpdate(Trigger.new , Trigger.old, Trigger.newMap, trigger.oldMap);
        }
        else if(Trigger.isDelete){
            //System.debug('Trigger is before delete Old'+ Trigger.old);
            TriggerHandler1.beforeDelete(Trigger.old);
        }
    }
    else if(Trigger.IsAfter){
        if(Trigger.isInsert){
            // System.debug('Trigger is AFTER Insert new '+Trigger.new);
            // System.debug('Trigger.newMap: ' + Trigger.newMap);
            TriggerHandler1.afterInsert(Trigger.new, trigger.newMap);

        }else if(Trigger.isUpdate){
            // System.debug('Trigger is after Update New '+Trigger.new);
            // System.debug('Trigger is after Update old '+Trigger.old);
            // System.debug('Trigger.newMap: ' + Trigger.newMap);
            // System.debug('Trigger.oldMap: ' + Trigger.oldMap);
            TriggerHandler1.afterUpdate(trigger.new , Trigger.old , trigger.newMap , Trigger.oldMap);


        }else if(Trigger.isDelete){
            //System.debug('Trigger is After delete old '+Trigger.old);
            TriggerHandler1.afterDelete(Trigger.old);

        }else if(Trigger.isUndelete){
            // System.debug('Trigger is after Undelete new '+Trigger.new);
            // System.debug('Trigger.oldMap: ' + Trigger.oldMap);
            TriggerHandler1.afterUndelete(Trigger.new , Trigger.oldmap);
        }
    }
    
}