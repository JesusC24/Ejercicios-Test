/**
 * Interfaz que debe impletar toda clase que quiera ser hanlder de un trigger, 
 * ya que implementa todos los métodos necesarios para poder controlarlo
 * https://debugonweb.com/2019/01/27/trigger-factory-salesforce/
 */
public interface ITrigger {

    /**
     * bulkBefore
     * 
     * Este método se llama antes de la ejecución de un BEFORE trigger. Se usa para cachear cualquier dato que se vaya a usar
     * después en la ejecución del trigger
     */
    void bulkBefore();

    /**
     * bulkAfter
     * 
     * Este método se llama antes de la ejecución de un AFTER trigger. Se usa para cachear cualquier dato que se vaya a usar
     * después en la ejecución del trigger
     */
    void bulkAfter();

    /**
     * beforeInsert
     * 
     * This method is called iteratively for each record to be inserted during a BEFORE
	 * trigger. Never execute any SOQL/SOSL etc in this and other iterative methods.
     */
    void beforeInsert(SObject so); 

    /**
	 * beforeUpdate
	 *
	 * This method is called iteratively for each record to be updated during a BEFORE
	 * trigger.
	 */
    void beforeUpdate(SObject oldSo, SObject so);
    
    /**
	 * beforeDelete
	 *
	 * This method is called iteratively for each record to be deleted during a BEFORE
	 * trigger.
	 */
    void beforeDelete(SObject so);
    
    /**
	 * afterInsert
	 *
	 * This method is called iteratively for each record inserted during an AFTER
	 * trigger. Always put field validation in the 'After' methods in case another trigger
	 * has modified any values. The record is 'read only' by this point.
	 */
    void afterInsert(SObject so); 

    /**
	 * afterUpdate
	 *
	 * This method is called iteratively for each record updated during an AFTER
	 * trigger.
	 */
    void afterUpdate(SObject oldSo, SObject so); 

    /**
	 * afterDelete
	 *
	 * This method is called iteratively for each record deleted during an AFTER
	 * trigger.
	 */
    void afterDelete(SObject so); 

    /**
	 * andFinally
	 *
	 * This method is called once all records have been processed by the trigger. Use this
	 * method to accomplish any final operations such as creation or updates of other records.
	 */
    void andFinally();
}
