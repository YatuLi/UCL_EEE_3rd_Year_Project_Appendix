/* 
 * Copyright 2010 Aalto University, ComNet
 * Released under GPLv3. See LICENSE.txt for details. 
 */
package routing;

import core.Settings;
import java.util.HashSet;
import java.util.List;
import routing.util.EnergyModel;
import core.DTNHost;
import core.ModuleCommunicationBus; // imported by Yatu
 

/**
 * Epidemic message router with drop-oldest buffer and only single transferring
 * connections at a time.
 */
public class EpidemicRouter extends ActiveRouter {
	
	protected DTNHost host;
	
	/**
	 * Constructor. Creates a new message router based on the settings in
	 * the given Settings object.
	 * @param s The settings object
	 */
	public EpidemicRouter(Settings s) {
		super(s);
		// New method created by Yatu. 07/02/2017
//		double [] initEnergy = s.getCsvDoubles("initialEnergy");
//		System.out.println(initEnergy [0]);
		//TODO: read&use epidemic router specific settings (if any)
	}
	
	/**
	 * Copy constructor.
	 * @param r The router prototype where setting values are copied from
	 */
	protected EpidemicRouter(EpidemicRouter r) {
		super(r);
		//TODO: copy epidemic settings here (if any)
	}
			
	@Override
	public void update() {
		super.update();
		
		// Yatu new lines. 20/12/2016
//		double current_energy = super.getEnergyModelinActiveRouter().getEnergy();
//		System.out.println("Newly Energy Level: " + current_energy);
		
		// A new method created by Yatu to test whether we can have an access to the ScanInterval on ComBus of the node
//		ModuleCommunicationBus comBus = new ModuleCommunicationBus();
//		System.out.println(comBus.getDouble("Network.scanInterval", 100));
//		System.out.println(comBus.containsProperty("Network.scanInterval"));
		
		/**
		 *  The following 3 lines are written by Yatu to try to access the scanInterval on comBus.
		 *  @author Yatu
		 */
//		host = this.getHost();
//		System.out.println(host);
//		System.out.println(host.getComBus());
//		Object obj_scanInterval = host.getComBus().getProperty("Network.scanInterval");
////		System.out.println(obj_scanInterval);
////		System.out.println("The Settings: " + new Settings().getSetting("Group.initialEnergy"));
//		String LocalHostName = this.getHost().toString();
//		// it prints out all of the name of hosts.
////		System.out.println(LocalHostName);
//		double newScanInterval = (double)obj_scanInterval + 100;
//		host.getComBus().updateProperty("Network.scanInterval", newScanInterval);
//		Object obj_scanIntervalNew = host.getComBus().getProperty("Network.scanInterval");
////		System.out.println(obj_scanIntervalNew);
		
		if (isTransferring() || !canStartTransfer()) {
			return; // transferring, don't try other connections yet
		}
		
		// Try first the messages that can be delivered to final recipient
		if (exchangeDeliverableMessages() != null) {
			return; // started a transfer, don't try others (yet)
		}
		
		// then try any/all message to any/all connection
		this.tryAllMessagesToAllConnections();
	}
	
	
	@Override
	public EpidemicRouter replicate() { // this 'this' is an object of this class.
		return new EpidemicRouter(this); // RHS of an instanistaion 
	}
	


}