/* 
 * Copyright 2017 University College London, Yatu Li
 * Released under GPLv3. See LICENSE.txt for details. 
 */
package routing;

import core.DTNHost;
import core.Settings;
import java.util.HashSet;
import java.util.List;
import routing.util.EnergyModel;
import core.ModuleCommunicationBus;


public class EnergyAwareEpidRouter extends ActiveRouter {
	
	/** EnergyAware router's settings name space ({@value}}). */
	public static final String ENERGYAWAREEPID_NS = "EnergyAwareEpidRouter";
	/** Initial units of energy -setting id ({@value}). Can be either a 
	 * single value, or a range of two values. In the latter case, the used
	 * value is a uniformly distributed random value between the two values. */
	public static final String INIT_ENERGY_S = "Group.initialEnergy";
	/** First Energy Threshold (between 0-1) for Scan Interval -setting id ({@value}}). */
	public static final String F_ENEERGY_THRESHOLD = "Group.EnergyAwareEpidRouter.firstEnergyThreshold";
	/** Second Energy Threshold (between 0-1) for Scan Interval -setting id ({@value}}). */
	public static final String S_ENEERGY_THRESHOLD = "Group.EnergyAwareEpidRouter.secondEnergyThreshold";
	/** Default Energy Threshold for Scan Interval -setting id ({@value}}). */
	public static final double DEFAULT_THRESHOLD = 1;
	/** Extra inactive time for Scan Interval when First Threshold is reached -setting id ({@value}}). */
	public static final String F_EXTRA_INACTIVE_TIME = "Group.EnergyAwareEpidRouter.firstExtraInactiveTime";
	/** Extra inactive time for Scan Interval when Second Threshold is reached -setting id ({@value}}). */
	public static final String S_EXTRA_INACTIVE_TIME = "Group.EnergyAwareEpidRouter.secondExtraInactiveTime";
	/** Default Extra inactive time for Scan Interval -setting id ({@value}}). */
	public static final double DEFAULT_EXTRA_INACTIVE_TIME = 0;
	/** Tram Model (true/false) for No Energy Consumption on Trams -setting id ({@value}}). */
	public static final String TRAM_MODEL = "Group.EnergyAwareEpidRouter.tramModel";
	/** Bus Model (true/false) for No Energy Consumption on buses -setting id ({@value}}). */
	public static final String BUS_MODEL = "Group.EnergyAwareEpidRouter.busModel";
	
	// ComBus Identifiers
	/** {@link ModuleCommunicaitonBus} identifier for the "scanning interval"} */
	public static final String SCAN_INTERVAL_ID = "Network.scanInterval";
	/** {@link ModuleCommunicationBus} identifier for the "current amount of 
	 * energy left" variable. Value type: double */
	public static final String ENERGY_VALUE_ID = "Energy.value";
	
	
	protected double firstEnergyScanThreshold;
	protected double secondEnergyScanThreshold;
	protected DTNHost host;
	protected double firstExtraInactiveTime;
	protected double secondExtraInactiveTime;
	protected boolean alreadyIncreaseOnce = false;
	protected boolean alreadyIncreaseTwice = false;
	protected double initialEnergy;
	protected boolean tramModel;
	protected boolean busModel;

	public EnergyAwareEpidRouter(Settings s){
		super(s);
		//Settings earSettings = new Settings(ENERGYAWARE_NS);
		Settings earSettings = new Settings();
		
		firstEnergyScanThreshold = earSettings.getDouble(F_ENEERGY_THRESHOLD, DEFAULT_THRESHOLD);
		secondEnergyScanThreshold = earSettings.getDouble(S_ENEERGY_THRESHOLD, DEFAULT_THRESHOLD);
		firstExtraInactiveTime = earSettings.getDouble(F_EXTRA_INACTIVE_TIME, 0);
		secondExtraInactiveTime = earSettings.getDouble(S_EXTRA_INACTIVE_TIME, 0);
		tramModel = earSettings.getBoolean(TRAM_MODEL);
		busModel = earSettings.getBoolean(BUS_MODEL);
		initialEnergy = earSettings.getDouble(INIT_ENERGY_S);
	}
	
	/**
	 * Copy constructor.
	 * @param r router prototype where setting values are copied from
	 */
	protected EnergyAwareEpidRouter(EnergyAwareEpidRouter r){
		super(r);
		this.firstEnergyScanThreshold = r.firstEnergyScanThreshold;
		this.secondEnergyScanThreshold = r.secondEnergyScanThreshold;
		this.firstExtraInactiveTime = r.firstExtraInactiveTime;
		this.secondExtraInactiveTime = r.secondExtraInactiveTime;
		this.tramModel = r.tramModel;
		this.busModel = r.busModel;
		this.initialEnergy = r.initialEnergy;
	}
	
	/**
	 * Return the current energy level of this router (node)
	 * @return the current energy level of this router (node)
	 */
	public double getEnergy(){
		return super.getEnergyModelinActiveRouter().getEnergy();
	}
	
	/**
	 * Return the scanInterval of the network interface of this router (node)
	 * It works fine in EpidemicRouter.java, update()
	 */
	public double getScanInterval(){
		double scanInterval = host.getComBus().getDouble(SCAN_INTERVAL_ID, 100);
		return  scanInterval;
	}
	
	/**
	 * Return the new scanInterval
	 */
	public double changeScanInterval(double scanInterval, double extraInactiveTime){
		double newScanInterval = getScanInterval() + extraInactiveTime;
		return newScanInterval;
	}
	
	/**
	 * Increase the scanInterval as the current energy level is below the first threshold
	 */
	public void updateFisrtScanInterval(){
		host = this.getHost();
		host.getComBus();
		double initialEnergy = new Settings().getDouble(INIT_ENERGY_S);
		if(getEnergy() < initialEnergy * firstEnergyScanThreshold){
			host.getComBus().updateProperty(SCAN_INTERVAL_ID, changeScanInterval(getScanInterval(), firstExtraInactiveTime));
			alreadyIncreaseOnce = true;
			}
		}
	
	/**
	 * Increase the scanInterval as the current energy level is below the first threshold
	 */
	public void updateSecondScanInterval(){
		host = this.getHost();
		host.getComBus();
		double initialEnergy = new Settings().getDouble(INIT_ENERGY_S);
		
		if(getEnergy() < initialEnergy * secondEnergyScanThreshold){
		host.getComBus().updateProperty(SCAN_INTERVAL_ID, changeScanInterval(getScanInterval(), secondExtraInactiveTime));
		alreadyIncreaseTwice = true;
		}
	}
	
	/**
	 * Recover the currentEnergy level into initialEnergy for Trams 
	 */
	public void recoverTramEnergy(){
		// A switch here
		if(tramModel){
			if (this.getHost().toString().substring(0, 1).equals("t")){
			this.getHost().getComBus().updateProperty(ENERGY_VALUE_ID, initialEnergy);
			}
		}
	}
	
	/**
	 * Recover the currentEnergy level into initialEnergy for Buses
	 */
	public void recoverBusEnergy(){
		// A switch here
		if(busModel){
			if (this.getHost().toString().substring(0, 1).equals("b")){
			this.getHost().getComBus().updateProperty(ENERGY_VALUE_ID, initialEnergy);
			}
		}
	}
	
	@Override
	public void update() {
		super.update();
		if (isTransferring() || !canStartTransfer()) {
			return; // transferring, don't try other connections yet
		}
		
		// Try first the messages that can be delivered to final recipient
		if (exchangeDeliverableMessages() != null) {
			return; // started a transfer, don't try others (yet)
		}
		
		// then try any/all message to any/all connection
		this.tryAllMessagesToAllConnections();
		
		
		recoverTramEnergy();
		recoverBusEnergy();
				
//		updateScanInterval();
		// Try only once increase in scanInterval
		if(!alreadyIncreaseOnce){
			updateFisrtScanInterval();
		}
		if(!alreadyIncreaseTwice){
			updateSecondScanInterval();
			}
		}
	
	
	@Override
	public EnergyAwareEpidRouter replicate() { // this 'this' is an object of this class.
		return new EnergyAwareEpidRouter(this); // RHS of an instanistaion 
	}

}
