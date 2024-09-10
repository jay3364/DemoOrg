trigger Task2 on lead (after insert) {
    if(Trigger.IsAfter && trigger.isInsert){
		TriggerHandler2.updateLead(Trigger.new);

    }
}