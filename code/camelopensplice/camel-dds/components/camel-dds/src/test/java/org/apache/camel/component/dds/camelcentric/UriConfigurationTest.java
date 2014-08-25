/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.camel.component.dds.camelcentric;

import junit.framework.TestCase;

import org.apache.camel.CamelContext;
import org.apache.camel.Endpoint;
import org.apache.camel.impl.DefaultCamelContext;

/**
 * @version $Revision: 142 $
 */
public class UriConfigurationTest extends TestCase {
    protected CamelContext context = new DefaultCamelContext();

    public void testDdsConfiguration() throws Exception {
        Endpoint endpoint =
            context.getEndpoint("dds:C1:5?HistoryKind=KEEP_ALL&HistoryDepth=15&LifespanDuration=50&contentFilter=height%3C1000%20AND%20x%3C23");
        assertTrue("Endpoint not an DdsEndpoint: " + endpoint, endpoint instanceof CamelDdsEndpoint);
        CamelDdsEndpoint ddsEndpoint = (CamelDdsEndpoint) endpoint;

        assertEquals("C1", ddsEndpoint.getTopicName());
        assertEquals("5", ddsEndpoint.getDomainId());
        assertEquals(DDS.HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS, ddsEndpoint.getHistoryKind());
        assertEquals(15, ddsEndpoint.getHistoryDepth());
        assertEquals(50.0, ddsEndpoint.getLifespanDuration());
        assertEquals("height<1000 AND x<23", ddsEndpoint.getContentFilter());
    }

}
