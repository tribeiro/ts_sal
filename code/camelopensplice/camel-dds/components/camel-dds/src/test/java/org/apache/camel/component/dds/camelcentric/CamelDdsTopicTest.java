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

import DDS.ContentFilteredTopic;
import DDS.Topic;

import org.apache.camel.CamelContext;
import org.apache.camel.Endpoint;
import org.apache.camel.impl.DefaultCamelContext;

public class CamelDdsTopicTest extends TestCase {

    protected CamelContext context = new DefaultCamelContext();

    /**
     * Test topic creation
     * @throws Exception
     */
    public void testcreateTopic() throws Exception {
        Endpoint endpoint =
            context.getEndpoint("dds:C7:5");
        assertTrue("Endpoint not an DdsEndpoint: " + endpoint, endpoint instanceof CamelDdsEndpoint);
        CamelDdsEndpoint ddsEndpoint = (CamelDdsEndpoint) endpoint;
        Topic topic = ddsEndpoint.getTopic();
        assertNotNull(topic);
        assertTrue(topic.get_name().equals("C7"));
        ContentFilteredTopic ctopic = ddsEndpoint.getContentFilteredTopic();
        assertNull(ctopic);
    }

    public void testcontentFilteredTopic() throws Exception {
        Endpoint endpoint =
            context.getEndpoint("dds:CF:5?target=SomeTopic");
        assertTrue("Endpoint not an DdsEndpoint: " + endpoint, endpoint instanceof CamelDdsEndpoint);
        CamelDdsEndpoint ddsEndpoint = (CamelDdsEndpoint) endpoint;
        Topic topic = ddsEndpoint.getTopic();
        assertNotNull(topic);
        assertTrue(topic.get_name().equals("CF"));
        ContentFilteredTopic ctopic = ddsEndpoint.getContentFilteredTopic();
        assertNotNull(ctopic);
    }

}
