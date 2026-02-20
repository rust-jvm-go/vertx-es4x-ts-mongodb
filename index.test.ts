/// <reference types="@vertx/core" />
// @ts-check

import { TestSuite } from '@vertx/unit';

const suite = TestSuite.create("the_test_suite");

// Basic assertion test
suite.test("my_test_case", (context: any) => {
  let s: string = "value";
  context.assertEquals("value", s);
});

// Verify vertx instance is available
suite.test("vertx_instance_available", (context: any) => {
  context.assertNotNull(vertx);
});

suite.run();
