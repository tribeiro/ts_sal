/* Copyright 2010, Object Management Group, Inc.
 * Copyright 2010, PrismTech, Inc.
 * Copyright 2010, Real-Time Innovations, Inc.
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.lsst.sal.example;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import org.omg.dds.core.Bootstrap;
import org.omg.dds.core.InstanceHandle;
import org.omg.dds.core.status.DataAvailableStatus;
import org.omg.dds.domain.DomainParticipant;
import org.omg.dds.domain.DomainParticipantFactory;
import org.omg.dds.sub.DataReader;
import org.omg.dds.sub.DataReaderAdapter;
import org.omg.dds.sub.DataReaderListener;
import org.omg.dds.sub.Sample;
import org.omg.dds.sub.Subscriber;
import org.omg.dds.topic.Topic;

import org.lsst.sal.SALTopic;

public class SALSampleApp {
    private static int count = 0;

    SALTopicType thetype;

    public static void main(String[] args) {
        Bootstrap bstp = Bootstrap.createInstance();
        DomainParticipant dp =
                DomainParticipantFactory.getInstance(bstp).createParticipant();

        Topic<SALTopic> tp = dp.createTopic("Test", SALTopic.class);

        Subscriber sub = dp.createSubscriber();
        DataReaderListener<SALTopic> ls = new MyListener();
        DataReader<SALTopic> dr = sub.createDataReader(
                tp,
                sub.getDefaultDataReaderQos(),
                ls,
                null /* all status changes */);

        try {
            dr.waitForHistoricalData(10, TimeUnit.SECONDS);
        } catch (TimeoutException tx) {
            tx.printStackTrace();
        }
        for (int w = 0; w < 60; w++) {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException ie) {
                System.err.println("Sleep interrupted");
            }
            System.out.println("Rxcnt: " + count);
        }
        dp.close();
    }

    private SALSampleApp() {
        // do nothing
    }

    // -----------------------------------------------------------------------
    // Types
    // -----------------------------------------------------------------------

    private static class MyListener extends DataReaderAdapter<SALTopic> {
        @Override
        public void onDataAvailable(DataAvailableStatus<SALTopic> status) {
            DataReader<SALTopic> dr = status.getSource();
            Sample.Iterator<SALTopic> it = dr.take();
            while (it.hasNext()) {
                Sample<SALTopic> smp = it.next();
                // SampleInfo stuff is built into Sample:
                InstanceHandle inst = smp.getInstanceHandle();
                // Data accessible from Sample; null if invalid:
                SALTopic data = smp.getData();
                // ..
                System.out.println("Test: " + data.revCode + " " + data.private_sndStamp + " " +
                        + data.private_rcvStsamp + " " + data.private_seqNum + " " + data.private_origin);
                count++;
            }
        }
    }
}
