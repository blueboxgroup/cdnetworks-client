require_relative '../../spec_helper'

describe CdnetworksClient do
  before(:each) do
    @user              = "user@user.com"
    @password          = "secret"
    @cdn_api           = CdnetworksClient.new(
                           :user     => @user,
                           :pass => @password
                         )

    @url               = "https://openapi.us.cdnetworks.com"
  end

  context "retrieving pad list" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/list").
        to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the list method of the cdnetworks api" do
      @cdn_api.list

      a_request(:post, "#{@url}/config/rest/pan/site/list").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
    end

    it "includes options passed as a hash" do
      @cdn_api.list(:prod => true)

      a_request(:post, "#{@url}/config/rest/pan/site/list").
        with(:body    => 'prod=true&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
    end
  end

  context "view pad info" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/view").
        to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the view method of the cdnetworks api" do
      @cdn_api.view

      a_request(:post, "#{@url}/config/rest/pan/site/view").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
      should have_been_made
    end

    it "includes options passed as a hash" do
      @cdn_api.view(:pad => "cache.foo.com")

      a_request(:post, "#{@url}/config/rest/pan/site/view").
        with(:body    => 'pad=cache.foo.com&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
      should have_been_made
    end

  end

  context "add a pad" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/add").
      to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the add method of the cdnetworks api" do
      @cdn_api.add

      a_request(:post, "#{@url}/config/rest/pan/site/add").
      with(:body    => 'user=user%40user.com&pass=secret',
           :headers => {
                         'Accept'      =>'*/*',
                         'Content-Type'=>'application/x-www-form-urlencoded',
                         'User-Agent'  =>'Ruby'}).
      should have_been_made
    end

    it "includes options passed as a hash" do
      @cdn_api.add(:pad => "cache.foo.com", :origin => "neworigin.foo.com")

      a_request(:post, "#{@url}/config/rest/pan/site/add").
        with(:body    => 'pad=cache.foo.com&origin=neworigin.foo.com&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
      should have_been_made
    end
  end

  context "edit a pad" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/edit").
      to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the edit method of the cdnetworks api" do
      @cdn_api.edit

      a_request(:post, "#{@url}/config/rest/pan/site/edit").
      with(:body    => 'user=user%40user.com&pass=secret',
           :headers => {
                         'Accept'      =>'*/*',
                         'Content-Type'=>'application/x-www-form-urlencoded',
                         'User-Agent'  =>'Ruby'}).
      should have_been_made
    end

    it "includes the options passed as a hash" do
      @cdn_api.edit(:pad => "cache.foo.com", :honor_byte_range => "1")

      a_request(:post, "#{@url}/config/rest/pan/site/edit").
      with(:body    => 'pad=cache.foo.com&honor_byte_range=1&user=user%40user.com&pass=secret',
           :headers => {
                         'Accept'      =>'*/*',
                         'Content-Type'=>'application/x-www-form-urlencoded',
                         'User-Agent'  =>'Ruby'}).
      should have_been_made
    end
  end

  context "with Cache Purge Open API v2.0" do
    context "purging a cache" do
      before(:each) do
        stub_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        to_return(:status => 200, :body => "", :headers => {})
      end

      it "calls the purge method of the cdnetworks api" do
        @cdn_api.execute_cache_purge

        a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        with(:body    => 'userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end

      it "includes the options passed as a hash" do
        @cdn_api.execute_cache_purge(:purgeUriList => "cdn.example.com")

        a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        with(:body    => 'purgeUriList=cdn.example.com&userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end

      it "handles options passed as an array" do
        @cdn_api.execute_cache_purge(:purgeUriList => ["cdn.example.com", "pad.foo.com"])

        a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        with(:body    => 'purgeUriList=cdn.example.com&purgeUriList=pad.foo.com&userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end
    end

    context "getting a cache domain list" do
      before(:each) do
        stub_request(:post, "https://openapi.us.cdnetworks.com/OpenAPI/services/CachePurgeAPI/getCacheDomainList").
          to_return(:status => 200, :body => "", :headers => {})
      end

      it "calls the cache domain list method of the cdnetworks api" do
        @cdn_api.get_cache_domain_list

        a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/getCacheDomainList").
        with(:body    => 'userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end
    end
  end

  context "with Cache Flush Open API v2.3.2" do
    context "purging a cache" do
      before(:each) do
        stub_request(:post, "#{@url}/purge/rest/doPurge").
          to_return(:status => 200, :body => "", :headers => {})
      end

      it "calls the purge method" do
        @cdn_api.do_purge

        a_request(:post, "#{@url}/purge/rest/doPurge").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end

      it "handles options passed as a hash" do
        @cdn_api.do_purge(:pad => "cdn.example.com", :type => "all")

        a_request(:post, "#{@url}/purge/rest/doPurge").
        with(:body    => 'pad=cdn.example.com&type=all&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end

      it "handles options passed as an array" do
        @cdn_api.do_purge(:path => ["/images/one.jpg", "/images/two.jpg"])
        a_request(:post, "#{@url}/purge/rest/doPurge").
        with(:body    => 'path=%2Fimages%2Fone.jpg&path=%2Fimages%2Ftwo.jpg&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end
    end

    context "getting a list of PADs" do
      it "calls the list method" do
        @cdn_api.pad_list

        a_request(:post, "#{@url}/purge/rest/padList").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end
    end

    context "get the status of a purge" do
      it "calls the status method" do
        @cdn_api.status

        a_request(:post, "#{@url}/purge/rest/status").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end

      it "handles options passsed as a hash" do
        @cdn_api.status(pid: 1234)

        a_request(:post, "#{@url}/purge/rest/status").
        with(:body    => 'pid=1234&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
        should have_been_made
      end
    end
  end

  context "locations" do
    it "uses the US access domain by default" do
      request = @cdn_api.compose_request("/some/path",{})
      request.path.should include("openapi.us.cdnetworks.com")
    end

    it "uses the Korean access domain when specified" do
      korean_cdn = CdnetworksClient.new(
                     :user     => @user,
                     :password => @password,
                     :location => "Korea"
                   )

      request = korean_cdn.compose_request("/some/path",{})
      request.path.should include("openapi.kr.cdnetworks.com")
    end

    it "uses the Japanese access domain when specified" do
      japanese_cdn = CdnetworksClient.new(
                     :user     => @user,
                     :password => @password,
                     :location => "Japan"
                   )

      request = japanese_cdn.compose_request("/some/path",{})
      request.path.should include("openapi.jp.cdnetworks.com")
    end

    it "uses the Chinese access domain when specified" do
      chinese_cdn = CdnetworksClient.new(
                     :user     => @user,
                     :password => @password,
                     :location => "China"
                   )

      request = chinese_cdn.compose_request("/some/path",{})
      request.path.should include("openapi.txnetworks.cn")
    end
  end

  context "error handling" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/list").
        with(:body    => {"pass"=>@password, "user"=>"#{@user}"},
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'}).
       to_timeout

    end

    it "returns an error" do
      error_result = @cdn_api.list
      error_result.should include("An error has occurred")
      error_result.should include("execution expired")
    end
  end

end
