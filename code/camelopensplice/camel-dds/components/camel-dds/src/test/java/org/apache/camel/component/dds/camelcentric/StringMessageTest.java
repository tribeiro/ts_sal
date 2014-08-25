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

import org.apache.camel.CamelContext;
import org.apache.camel.ContextTestSupport;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.mock.MockEndpoint;



public class StringMessageTest extends ContextTestSupport {
    protected String componentName = "dds";

    public void testStringMessage() throws Exception {
        MockEndpoint result = getMockEndpoint("mock:result");
        result.expectedMessageCount(1);
        template.sendBody("dds:CS:5?target=testTarget", "TestMessage");
        result.assertIsSatisfied();
        CamelDdsMessage msg = (CamelDdsMessage)result.getExchanges().get(0).getIn();
        assertTrue(msg.getMessage().target.equals("testTarget"));
        Object obj = result.getExchanges().get(0).getIn().getBody();
        assertTrue(obj instanceof String);
        String ret = (String)obj;
        assertTrue(ret.equals("TestMessage"));
    }

    protected CamelContext createCamelContext() throws Exception {
        CamelContext camelContext = super.createCamelContext();
        return camelContext;
    }

    protected RouteBuilder createRouteBuilder() throws Exception {
        return new RouteBuilder() {
            public void configure() throws Exception {
                from("dds:CS:5?target=testTarget").to("mock:result");
            }
        };
    }
}
