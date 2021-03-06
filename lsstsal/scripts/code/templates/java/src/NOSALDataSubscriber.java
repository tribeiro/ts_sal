/*
 *                         OpenSplice DDS
 *
 *   This software and documentation are Copyright 2006 to 2013 PrismTech
 *   Limited and its licensees. All rights reserved. See file:
 *
 *                     $OSPL_HOME/LICENSE 
 *
 *   for full copyright notice and license terms. 
 *
 */


import DDS.ANY_INSTANCE_STATE;
import DDS.ANY_SAMPLE_STATE;
import DDS.ANY_VIEW_STATE;
import DDS.DataReader;
import DDS.LENGTH_UNLIMITED;
import DDS.SampleInfoSeqHolder;
import SALData.SALTopicDataReader;
import SALData.SALTopicDataReaderHelper;
import SALData.SALTopicSeqHolder;
import SALData.SALTopicTypeSupport;
import org.lsst.sal.SALDDS;

public class NOSALDataSubscriber {

	public static void main(String[] args) {
		SALDDS mgr = new SALDDS();
		String partitionName = "SAL LSST";

		// create Domain Participant
		mgr.createParticipant(partitionName);

		// create Type
		SALTopicTypeSupport SALTopicTS = new SALTopicTypeSupport();
		mgr.registerType(SALTopicTS);

		// create Topic
		mgr.createTopic("SALData_SALTopic");

		// create Subscriber
		mgr.createSubscriber();

		// create DataReader
		mgr.createReader();

		// Read Events

		DataReader dreader = mgr.getReader();
		SALTopicDataReader SALReader = SALTopicDataReaderHelper.narrow(dreader);

		SALTopicSeqHolder SALTopicSeq = new SALTopicSeqHolder();
		SampleInfoSeqHolder infoSeq = new SampleInfoSeqHolder();

                System.out.println ("=== [Subscriber] Ready ...");
		boolean terminate = false;
		int count = 0;
		while (!terminate && count < 1500) { // We dont want the example to run indefinitely
			SALReader.take(SALTopicSeq, infoSeq, LENGTH_UNLIMITED.value,
					ANY_SAMPLE_STATE.value, ANY_VIEW_STATE.value,
					ANY_INSTANCE_STATE.value);
			for (int i = 0; i < SALTopicSeq.value.length; i++) {
					System.out.println("=== [Subscriber] message received :");
					System.out.println("    revCode  : "
							+ SALTopicSeq.value[i].private_revCode);
			}
			try
			{
				Thread.sleep(200);
			}
			catch(InterruptedException ie)
			{
				// nothing to do
			}
			++count;
			
		}
                SALReader.return_loan(SALTopicSeq, infoSeq);
		
		// clean up
		mgr.getSubscriber().delete_datareader(SALReader);
		mgr.deleteSubscriber();
		mgr.deleteTopic();
		mgr.deleteParticipant();

	}
}
