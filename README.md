# Cdnetworks Client

The Cdnetworks Client is a simple wrapper for three [Cdnetworks](http://www.cdnetworks.com/) APIs
* Config Open API v1.0
* Cache Purge Open API v2.0 (older cache flushing API)
* Cache Flush Open API v2.3.2 (most current cache flushing API)

This gem allows a user to call methods from either of these APIs using the same syntax.

# Requirements
* A CDNetworks OCSP Account

# Installation
<pre> gem install cdnetworks-client </pre>

Or, in your Gemfile, add
<pre> gem 'cdnetworks-client' </pre>

And run
<pre> bundle </pre>
# Usage

## Creating an instance of Cdnetworks Client
Create an instance:
<pre>
  cdn = CdnetworksClient.new(:user => [Your CDNetworks User Name], :pass => [Your CDNetworks Password])
</pre>

CDNetworks uses different access domains for some locations.  You can optionally specify a location when you create a new instance.

By default, the location is set to US/Global and uses the access domain https://openapi.us.cdnetworks.com

You can specify the following locations:
* Korea (uses access domain https://openapi.us.cdnetworks.com)
* Japan (uses access domain https://openapi.jp.cdnetworks.com)
* China (uses access domain https://openapi.txnetworks.cn)

<pre>
  cdn = CdnetworksClient.new(
    :user     => [Your CDNetworks User Name],
    :pass     => [Your CDNetworks Password],
    :location => "Korea"
  )
</pre>

Again, the default location is US/Global using the access domain https://openapi.us.cdnetworks.com

Please see the CDNetworks API documentation for a full list of options and parameters for each API call

After each call, the gem will return a hash including the response code and the response body from CDNetworks.

## Listing PADs and their information
<pre>
  cdn.list
</pre>

You can also add in parameters
<pre>
  cdn.list(:prod => 1)
</pre>

## Viewing a PAD
<pre>
  cdn.view(:pad => "cache.foo.com")
</pre>

## Adding a PAD
<pre>
  cdn.add(:pad => "cache.foo.com", :origin => "neworigin.foo.com")
</pre>

## Editing a PAD
<pre>
  cdn.edit(:pad => "cache.foo.com", :honor_byte_range => "1")
</pre>

## Purging a cache

### If you are using Cache Flush Open API v2.3.2

<pre>
  cdn.do_purge(:pad => "cdn.example.com", :type => "all")
</pre>

<pre>
  cdn.do_purge(:pad => "cdn.example.com", :path => ["images/one.jpg", "images/two.jpg"])
</pre>

### If you are using Cache Purge Open API v2.0
<pre>
  cdn.execute_cache_purge(:purgeUriList => "cdn.example.com")
</pre>

<pre>
  cdn.execute_cache_purge(:purgeUriList => ["cdn.example.com", "cdn.foo.com"])
</pre>

## Getting the status of a cache purge
<pre>
  cdn.status(:pid => 1234)
</pre>

## Listing all PAD domain names

### If you are using Cache Flush Open API v2.3.2
<pre>
  cdn.pad_list
</pre>

### If you are using Cache Purge Open API v2.0
<pre>
  cdn.get_cache_domain_list
</pre>

# License
License is Apache License v2.0 by Blue Box, Inc., Nell Shamrell, unless otherwise noted.
