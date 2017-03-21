/* 
 * Copyright 2017 University College London, Yatu Li
 * Released under GPLv3. See LICENSE.txt for details. 
 */
package routing;

import java.util.ArrayList;
import java.util.List;

import core.Connection;
import core.DTNHost;
import core.Message;
import core.Settings;

// Extra import from EnergyAwareEpidRouter.java
import java.util.HashSet;
import java.util.List;
import routing.util.EnergyModel;
import core.ModuleCommunicationBus;

/**
 * Implementation of Spray and wait router as depicted in 
 * <I>Spray and Wait: An Efficient Routing Scheme for Intermittently
 * Connected Mobile Networks</I> by Thrasyvoulos Spyropoulus et al.
 *
 */
public class EnergyAwareSAWRouter extends ActiveRouter {
	
	/** EnergyAware router's settings name space ({@value}}). */
	public static final String ENERGYAWAREEPID_NS = "EnergyAwareSAWRouter";
	
	/** identifier for the initial number of copies setting ({@value})*/ 
	public static final String NROF_COPIES = "nrofCopies";
	/** identifier for the binary-mode setting ({@value})*/ 
	public static final String BINARY_MODE = "binaryMode";
	/** Message property key */
	public static final String MSG_COUNT_PROPERTY = ENERGYAWAREEPID_NS + "." +
		"copies";
	/** Initial units of energy -setting id ({@value}). Can be either a 
	 * single value, or a range of two values. In the latter case, the used
	 * value is a uniformly distributed random value between the two values. */
	public static final String INIT_ENERGY_S = "Group.initialEnergy";
	/** First Energy Threshold (between 0-1) for Scan Interval -setting id ({@value}}). */
	public static final String F_ENEERGY_THRESHOLD = "Group.EnergyAwareSAWRouter.firstEnergyThreshold";
	/** Second Energy Threshold (between 0-1) for Scan Interval -setting id ({@value}}). */
	public static final String S_ENEERGY_THRESHOLD = "Group.EnergyAwareSAWRouter.secondEnergyThreshold";
	/** Default Energy Threshold for Scan Interval -setting id ({@value}}). */
	public static final double DEFAULT_THRESHOLD = 1;
	/** Extra inactive time for Scan Interval when First Threshold is reached -setting id ({@value}}). */
	public static final String F_EXTRA_INACTIVE_TIME = "Group.EnergyAwareSAWRouter.firstExtraInactiveTime";
	/** Extra inactive time for Scan Interval when Second Threshold is reached -setting id ({@value}}). */
	public static final String S_EXTRA_INACTIVE_TIME = "Group.EnergyAwareSAWRouter.secondExtraInactiveTime";
	/** Default Extra inactive time for Scan Interval -setting id ({@value}}). */
	public static final double DEFAULT_EXTRA_INACTIVE_TIME = 0;
	/** Tram Model (true/false) for No Energy Consumption on Trams -setting id ({@value}}). */
	public static final String TRAM_MODEL = "Group.EnergyAwareSAWRouter.tramModel";
	/** Bus Model (true/false) for No Energy Consumption on buses -setting id ({@value}}). */
	public static final String BUS_MODEL = "Group.EnergyAwareSAWRouter.busModel";
	
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
	
	protected int initialNrofCopies;
	protected boolean isBinary;

	public EnergyAwareSAWRouter(Settings s) {
		super(s);
		Settings snwSettings = new Settings(ENERGYAWAREEPID_NS);
		Settings easawSettings = new Settings();
		
		initialNrofCopies = snwSettings.getInt(NROF_COPIES);
		isBinary = snwSettings.getBoolean( BINARY_MODE);
		firstEnergyScanThreshold = easawSettings.getDouble(F_ENEERGY_THRESHOLD, DEFAULT_THRESHOLD);
		secondEnergyScanThreshold = easawSettings.getDouble(S_ENEERGY_THRESHOLD, DEFAULT_THRESHOLD);
		firstExtraInactiveTime = easawSettings.getDouble(F_EXTRA_INACTIVE_TIME, 0);
		secondExtraInactiveTime = easawSettings.getDouble(S_EXTRA_INACTIVE_TIME, 0);
		tramModel = easawSettings.getBoolean(TRAM_MODEL);
		busModel = easawSettings.getBoolean(BUS_MODEL);
		initialEnergy = easawSettings.getDouble(INIT_ENERGY_S);
	}
	
	/**
	 * Copy constructor.
	 * @param r The router prototype where setting values are copied from
	 */
	protected EnergyAwareSAWRouter(EnergyAwareSAWRouter r) {
		super(r);
		this.initialNrofCopies = r.initialNrofCopies;
		this.isBinary = r.isBinary;
		
		this.firstEnergyScanThreshold = r.firstEnergyScanThreshold;
		this.secondEnergyScanThreshold = r.secondEnergyScanThreshold;
		this.firstExtraInactiveTime = r.firstExtraInactiveTime;
		this.secondExtraInactiveTime = r.secondExtraInactiveTime;
		this.tramModel = r.tramModel;
		this.busModel = r.busModel;
		this.initialEnergy = r.initialEnergy;
	}
	
	@Override
	public int receiveMessage(Message m, DTNHost from) {
		return super.receiveMessage(m, from);
	}
	
	@Override
	public Message messageTransferred(String id, DTNHost from) {
		Message msg = super.messageTransferred(id, from);
		Integer nrofCopies = (Integer)msg.getProperty(MSG_COUNT_PROPERTY);
		
		assert nrofCopies != null : "Not a SnW message: " + msg;
		
		if (isBinary) {
			/* in binary S'n'W the receiving node gets ceil(n/2) copies */
			nrofCopies = (int)Math.ceil(nrofCopies/2.0);
		}
		else {
			/* in standard S'n'W the receiving node gets only single copy */
			nrofCopies = 1;
		}
		
		msg.updateProperty(MSG_COUNT_PROPERTY, nrofCopies);
		return msg;
	}
	
	@Override 
	public boolean createNewMessage(Message msg) {
		makeRoomForNewMessage(msg.getSize());

		msg.setTtl(this.msgTtl);
		msg.addProperty(MSG_COUNT_PROPERTY, new Integer(initialNrofCopies));
		addToMessages(msg, true);
		return true;
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
		
		if (!canStartTransfer() || isTransferring()) {
			return; // nothing to transfer or is currently transferring 
		}

		/* try messages that could be delivered to final recipient */
		if (exchangeDeliverableMessages() != null) {
			return;
		}
		
		/* create a list of SAWMessages that have copies left to distribute */
		@SuppressWarnings(value = "unchecked")
		List<Message> copiesLeft = sortByQueueMode(getMessagesWithCopiesLeft());
		
		if (copiesLeft.size() > 0) {
			/* try to send those messages */
			this.tryMessagesToConnections(copiesLeft, getConnections());
		}
			recoverTramEnergy();
			recoverBusEnergy();
					
//			updateScanInterval();
			// Try only once increase in scanInterval
			if(!alreadyIncreaseOnce){
				updateFisrtScanInterval();
			}
			if(!alreadyIncreaseTwice){
				updateSecondScanInterval();
				}
		
		
	}
	
	/**
	 * Creates and returns a list of messages this router is currently
	 * carrying and still has copies left to distribute (nrof copies > 1).
	 * @return A list of messages that have copies left
	 */
	protected List<Message> getMessagesWithCopiesLeft() {
		List<Message> list = new ArrayList<Message>();

		for (Message m : getMessageCollection()) {
			Integer nrofCopies = (Integer)m.getProperty(MSG_COUNT_PROPERTY);
			assert nrofCopies != null : "SnW message " + m + " didn't have " + 
				"nrof copies property!";
			if (nrofCopies > 1) {
				list.add(m);
			}
		}
		
		return list;
	}
	
	/**
	 * Called just before a transfer is finalized (by 
	 * {@link ActiveRouter#update()}).
	 * Reduces the number of copies we have left for a message. 
	 * In binary Spray and Wait, sending host is left with floor(n/2) copies,
	 * but in standard mode, nrof copies left is reduced by one. 
	 */
	@Override
	protected void transferDone(Connection con) {
		Integer nrofCopies;
		String msgId = con.getMessage().getId();
		/* get this router's copy of the message */
		Message msg = getMessage(msgId);

		if (msg == null) { // message has been dropped from the buffer after..
			return; // ..start of transfer -> no need to reduce amount of copies
		}
		
		/* reduce the amount of copies left */
		nrofCopies = (Integer)msg.getProperty(MSG_COUNT_PROPERTY);
		if (isBinary) { 
			nrofCopies /= 2;
		}
		else {
			nrofCopies--;
		}
		msg.updateProperty(MSG_COUNT_PROPERTY, nrofCopies);
	}
	
	@Override
	public EnergyAwareSAWRouter replicate() {
		return new EnergyAwareSAWRouter(this);
	}
}

