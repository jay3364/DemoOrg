trigger AssetManagerTrigger on buildertek__Asset_History__c(before insert,after insert, before update, after update, before delete, after delete){
    if (!BT_Utils.isTriggerDeactivate('buildertek__Asset_History__c') && !AssestManagerHandler.blnSkipAssetHistoryTrigger){
        AssestManagerHandler handler = new AssestManagerHandler(Trigger.isExecuting, Trigger.size);

        if (Trigger.isInsert && Trigger.isBefore){
          //  handler.OnBeforeInsert(Trigger.new);
        }
        
    }
     system.debug('$$$$$');
    AssestManagerHandler handler = new AssestManagerHandler(Trigger.isExecuting, Trigger.size);
    system.debug('^^^^^^^^^^');
    if (Trigger.isInsert && Trigger.isAfter){
            handler.afterInsert(Trigger.new, Trigger.newMap);
        }

      if(Trigger.isAfter && Trigger.isUpdate){
            handler.afterUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        }

        if(Trigger.isBefore && Trigger.isDelete){
          handler.beforeDelete(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        }

        
        if(Trigger.isBefore && Trigger.isInsert){
            handler.beforeInsert(Trigger.new);
        }

        if(Trigger.isAfter && Trigger.isInsert){
            handler.afterInsert(Trigger.new);
        }

        if(Trigger.isBefore && Trigger.isUpdate){
            handler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }

        if(Trigger.isAfter && Trigger.isUpdate){
            handler.afterUpdate(Trigger.new);
        }

        if(Trigger.isBefore && Trigger.isDelete){
            handler.beforeDelete(Trigger.old);
        }



}