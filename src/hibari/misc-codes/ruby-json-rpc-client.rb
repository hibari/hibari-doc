#!/usr/bin/ruby

###----------------------------------------------------------------------
### Copyright (c) 2005-2017 Hibari developers.  All rights reserved.
###
### Licensed under the Apache License, Version 2.0 (the "License");
### you may not use this file except in compliance with the License.
### You may obtain a copy of the License at
###
###     http://www.apache.org/licenses/LICENSE-2.0
###
### Unless required by applicable law or agreed to in writing, software
### distributed under the License is distributed on an "AS IS" BASIS,
### WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
### See the License for the specific language governing permissions and
### limitations under the License.
###
### File    : ruby-json-rpc-client.rb
### Purpose : ruby json rpc client
###----------------------------------------------------------------------

# See 'Important Variables' section for stuff to edit

# See the 'require' statements below to see all module dependencies.
# The two that are not included as part of Ruby v1.8:
#   rubygems
#   json
# Once the 'rubygems' package is installed, use "gem install json" to
# install the 'json' package.

require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

def to_ubf_atom(arg)   # arg should be a Ruby string
  {'$A' => arg}        # return a Ruby hash
end

def to_ubf_tuple(arg)  # arg should be a Ruby array
  {'$T' => arg}        # return a Ruby hash
end

# Important variables
# 1. Change the "url" variable to fit your local environment
# 2. Uncomment one pair of method/params attributes in the "req" variable

url = "http://localhost:7583/gdss"
req = {
  "version" => "1.1",
  "id"      => "my id foo",

# Uncomment one of the pairs below.  Don't forget to uncomment all of
# the lines, in case 'params' uses more than one!

#  "method"  => "info",
#  "params"  => []

#  "method"  => "description",
#  "params"  => []

#  "method"  => "set",
#  "params"  => [to_ubf_atom("tab1"), "fookey2", "Hello, world!", 0,
#                  [], 4000]

   "method"  => "replace",
   "params"  => [to_ubf_atom("tab1"), "fookey2", "Hello, world!", 0,
                 [to_ubf_tuple([to_ubf_atom("testset"), 42])], 4000]

#  "method"  => "get",
#  "params"  => [to_ubf_atom("tab1"), "foo", [], 4000]

#  "method"  => "get_many",
#  "params"  => [to_ubf_atom("tab1"), "f", 10,
#                [to_ubf_atom("witness"), to_ubf_atom("get_all_attribs")], 4000]

## NOTE: Comment out/remove the 'to_ubf_atom("txn"),' line to change behavior.

#  "method"  => "do",
#  "params"  => [to_ubf_atom("tab1"),
#                [
#                 to_ubf_atom("txn"),
#                 to_ubf_tuple([to_ubf_atom("get"), "foo", []]),
#                 to_ubf_tuple([to_ubf_atom("get"), "bar",
#                               [to_ubf_atom("must_exist")]])
#                ], [], 4000]
}

# Nothing else to edit here.

def to_ubf_string(arg) # arg should be a Ruby string
  {'$S' => arg}        # return a Ruby hash
end

def from_ubf(arg)
  if arg.kind_of?(Hash)
    if arg.has_key?('$S')
      #return "string:" + arg['$S']
      return arg['$S']
    elsif arg.has_key?('$A')
      #return "atom:" + arg['$A']
      if arg['$A'] == "undefined"
        return nil
      else
        return arg['$A']
      end
    elsif arg.has_key?('$T')
      #return [arg['$T'].size.to_s+"-tuple"] + from_ubf(arg['$T'])
      return from_ubf(arg['$T'])
    else
      raise "hash with unknown type", arg
    end
  elsif arg.kind_of?(Array)
    a = Array.new
    #a.push("length-" + arg.size.to_s + "-list")
    arg.each { |item|
      a.push(from_ubf(item))
    }
    return a
  else
    return arg
  end
end

uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri)
request["Accept"] = "application/json"
request["Content-Type"] = "application/json"
request.body = req.to_json()
response = http.request(request)

if response.code == "200":
  result = JSON.parse(response.body)
  if result["error"] == nil
    rubyterm = from_ubf(result["result"])
    formatted = if rubyterm.kind_of?(Array)
                  rubyterm.join(",")
                else
                  rubyterm
                end
    print "Result: ", formatted, "\n"
#    result.each { |key, value|
#      puts "key #{key} value #{value}"
#    }
  else
    print "Error body: ", response.body, "\n"
    #puts "Error", from_ubf(result["error"]).join(",")
  end
else
  puts "Bummer"
  puts response.body
end

