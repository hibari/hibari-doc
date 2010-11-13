#!/usr/local/bin/thrift --gen erl --gen java --gen py
#----------------------------------------------------------------------
# Copyright: (c) 2008-2010 Gemini Mobile Technologies, Inc.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# File    : hibari.thrift
# Purpose : simplified Hibari "thrift" API for ntbf gdss plugin contract
#----------------------------------------------------------------------

namespace java com.hibari.rpc

enum ErrorCode {
  UNKNOWN           = 1,
  UNKNOWN_ARGS      = 2,
  SERVICE_NOT_AVAIL = 3,
  NOT_IMPLEMENTED   = 4,
  TIME_OUT          = 5,
  KEY_EXISTS        = 101,
  KEY_NOT_EXISTS    = 102,
}

struct Add {
  1: required string table,
  2: required binary key,
  3: required binary value,
}

struct Replace {
  1: required string table,
  2: required binary key,
  3: required binary value,
}

struct Set {
  1: required string table,
  2: required binary key,
  3: required binary value,
}

struct Delete {
  1: required string table,
  2: required binary key,
  3: optional bool must_exist,
}

struct Get {
  1: required string table,
  2: required binary key,
  3: optional bool is_witness,
}

struct HibariResponse {
  1: optional i64 timestamp,
  2: optional binary key,
  3: optional binary value,
}

/**
 * Generic Exception thrown by Hibari
 * @param what = ErrorCode | A custom integer
 * @param why = a string to explain
 */
exception HibariException {
  1: optional i64 timestamp,
  2: required i32 what,
  3: required string why,
}

service Hibari {

  /**
   * Check connection availability / keepalive
   */
  oneway void keepalive()

  /**
   * Hibari Server Info
   */
  string info()

  /**
   * Hibari Description
   */
  string description()

  /**
   * Hibari Contract
   */
  string contract()

  /**
   * Add
   */
  HibariResponse Add(1: Add request)
      throws (1:HibariException ouch)

  /**
   * Replace
   */
  HibariResponse Replace(1: Replace request)
      throws (1:HibariException ouch)

  /**
   * Set
   */
  HibariResponse Set(1: Set request)
      throws (1:HibariException ouch)

  /**
   * Delete
   */
  HibariResponse Delete(1: Delete request)
      throws (1:HibariException ouch)

  /**
   * Get
   */
  HibariResponse Get(1: Get request)
      throws (1:HibariException ouch)
}
