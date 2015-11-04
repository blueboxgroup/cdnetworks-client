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

      expect(a_request(:post, "#{@url}/config/rest/pan/site/list").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
    end

    it "includes options passed as a hash" do
      @cdn_api.list(:prod => true)

      expect(a_request(:post, "#{@url}/config/rest/pan/site/list").
        with(:body    => 'prod=true&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
    end
  end

  context "view pad info" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/view").
        to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the view method of the cdnetworks api" do
      @cdn_api.view

      expect(a_request(:post, "#{@url}/config/rest/pan/site/view").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
      to have_been_made
    end

    it "includes options passed as a hash" do
      @cdn_api.view(:pad => "cache.foo.com")

      expect(a_request(:post, "#{@url}/config/rest/pan/site/view").
        with(:body    => 'pad=cache.foo.com&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
      to have_been_made
    end

  end

  context "add a pad" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/add").
      to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the add method of the cdnetworks api" do
      @cdn_api.add

      expect(a_request(:post, "#{@url}/config/rest/pan/site/add").
      with(:body    => 'user=user%40user.com&pass=secret',
           :headers => {
                         'Accept'      =>'*/*',
                         'Content-Type'=>'application/x-www-form-urlencoded',
                         'User-Agent'  =>'Ruby'})).
      to have_been_made
    end

    it "includes options passed as a hash" do
      @cdn_api.add(:pad => "cache.foo.com", :origin => "neworigin.foo.com")

      expect(a_request(:post, "#{@url}/config/rest/pan/site/add").
        with(:body    => 'pad=cache.foo.com&origin=neworigin.foo.com&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
      to have_been_made
    end
  end

  context "edit a pad" do
    before(:each) do
      stub_request(:post, "#{@url}/config/rest/pan/site/edit").
      to_return(:status => 200, :body => "", :headers => {})
    end

    it "calls the edit method of the cdnetworks api" do
      @cdn_api.edit

      expect(a_request(:post, "#{@url}/config/rest/pan/site/edit").
      with(:body    => 'user=user%40user.com&pass=secret',
           :headers => {
                         'Accept'      =>'*/*',
                         'Content-Type'=>'application/x-www-form-urlencoded',
                         'User-Agent'  =>'Ruby'})).
      to have_been_made
    end

    it "includes the options passed as a hash" do
      @cdn_api.edit(:pad => "cache.foo.com", :honor_byte_range => "1")

      expect(a_request(:post, "#{@url}/config/rest/pan/site/edit").
      with(:body    => 'pad=cache.foo.com&honor_byte_range=1&user=user%40user.com&pass=secret',
           :headers => {
                         'Accept'      =>'*/*',
                         'Content-Type'=>'application/x-www-form-urlencoded',
                         'User-Agent'  =>'Ruby'})).
      to have_been_made
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

        expect(a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        with(:body    => 'userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end

      it "includes the options passed as a hash" do
        @cdn_api.execute_cache_purge(:purgeUriList => "cdn.example.com")

        expect(a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        with(:body    => 'purgeUriList=cdn.example.com&userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end

      it "handles options passed as an array" do
        @cdn_api.execute_cache_purge(:purgeUriList => ["cdn.example.com", "pad.foo.com"])

        expect(a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/executeCachePurge").
        with(:body    => 'purgeUriList=cdn.example.com&purgeUriList=pad.foo.com&userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end
    end

    context "getting a cache domain list" do
      before(:each) do
        stub_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/getCacheDomainList").
          to_return(:status => 200, :body => "", :headers => {})
      end

      it "calls the cache domain list method of the cdnetworks api" do
        @cdn_api.get_cache_domain_list

        expect(a_request(:post, "#{@url}/OpenAPI/services/CachePurgeAPI/getCacheDomainList").
        with(:body    => 'userId=user%40user.com&password=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
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

        expect(a_request(:post, "#{@url}/purge/rest/doPurge").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end

      it "handles options passed as a hash" do
        @cdn_api.do_purge(:pad => "cdn.example.com", :type => "all")

        expect(a_request(:post, "#{@url}/purge/rest/doPurge").
        with(:body    => 'pad=cdn.example.com&type=all&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end

      it "handles options passed as an array" do
        @cdn_api.do_purge(:path => ["/images/one.jpg", "/images/two.jpg"])
        expect(a_request(:post, "#{@url}/purge/rest/doPurge").
        with(:body    => 'path=%2Fimages%2Fone.jpg&path=%2Fimages%2Ftwo.jpg&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end
    end

    context "getting a list of PADs" do
      before do
        stub_request(:post, "#{@url}/purge/rest/padList").
          with(:body => {"pass"=>"secret", "user"=>"user@user.com"}).
          to_return(:status => 200, :body => "", :headers => {})
      end

      it "calls the list method" do
        @cdn_api.pad_list

        expect(a_request(:post, "#{@url}/purge/rest/padList").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end
    end

    context "get the status of a purge" do
      before do
        stub_request(:post, "#{@url}/purge/rest/status").
          to_return(status: 200, body: "", headers: {})
      end

      it "calls the status method" do
        @cdn_api.status

        expect(a_request(:post, "#{@url}/purge/rest/status").
        with(:body    => 'user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end

      it "handles options passsed as a hash" do
        @cdn_api.status(pid: 1234)

        expect(a_request(:post, "#{@url}/purge/rest/status").
        with(:body    => 'pid=1234&user=user%40user.com&pass=secret',
             :headers => {
                           'Accept'      =>'*/*',
                           'Content-Type'=>'application/x-www-form-urlencoded',
                           'User-Agent'  =>'Ruby'})).
        to have_been_made
      end
    end
  end

  context "locations" do
    it "uses the US access domain by default" do
      request = @cdn_api.compose_request("/some/path",{})
      expect(request.path).to include("openapi.us.cdnetworks.com")
    end

    it "uses the Korean access domain when specified" do
      korean_cdn = CdnetworksClient.new(
                     :user     => @user,
                     :password => @password,
                     :location => "Korea"
                   )

      request = korean_cdn.compose_request("/some/path",{})
      expect(request.path).to include("openapi.kr.cdnetworks.com")
    end

    it "uses the Japanese access domain when specified" do
      japanese_cdn = CdnetworksClient.new(
                     :user     => @user,
                     :password => @password,
                     :location => "Japan"
                   )

      request = japanese_cdn.compose_request("/some/path",{})
      expect(request.path).to include("openapi.jp.cdnetworks.com")
    end

    it "uses the Chinese access domain when specified" do
      chinese_cdn = CdnetworksClient.new(
                     :user     => @user,
                     :password => @password,
                     :location => "China"
                   )

      request = chinese_cdn.compose_request("/some/path",{})
      expect(request.path).to include("openapi.txnetworks.cn")
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
      expect { @cdn_api.list }.to raise_error(Timeout::Error)
    end
  end


  context 'OpenApiV2' do
    before do
      @cdn_api           = CdnetworksClient.new(
                             user: @user,
                             pass: @password,
                             location: "Beta"
                           )

      @url               = "https://openapi-beta.cdnetworks.com"

      @fake_token, @fake_key, _, @fake_service = stub_auth_calls
    end

    context "Session Management" do
      let(:bad_token) { "oldtoken12345" }
      let(:expired_session_resp) { JSON.pretty_unparse(apiKeyInfo: {returnCode: 102}) }

      before do
        @good_token, _ = stub_auth_calls
        stub_request(:post, "#{@url}/api/rest/getApiKeyList").with(body: {"output"=>"json", "sessionToken"=>bad_token}).to_return(body: expired_session_resp)
      end

      it "re-establishes session if it expires" do
        session_keys = @cdn_api.get_api_key_list(bad_token)

        expect(a_request(:post, "#{@url}/api/rest/login")).to have_been_made
        expect(session_keys.length).to be > 0
      end

      it "doesn't infinite loop if session can't be re-established" do
        stub_request(:post, "#{@url}/api/rest/login").to_return(body: JSON.pretty_unparse(loginResponse: {resultCode: 101}))
        expect { @cdn_api.get_api_key_list(bad_token) }.to raise_error(OpenApiError::ApiError)
      end

      it "gives up if session is not re-established after MAX_SESSION_RETRIES tries" do
        stub_request(:post, "#{@url}/api/rest/getApiKeyList").with(body: {"output"=>"json", "sessionToken"=>@good_token}).to_return(body: expired_session_resp)

        expect { @cdn_api.get_api_key_list(bad_token) }.to raise_error(OpenApiError::CriticalApiError)

        expect(a_request(:post, "#{@url}/api/rest/login")).to have_been_made.times(3)
      end
    end

    describe ConfigOpenApi do
      before { stub_pad_list(@fake_service) }

      it "fetches list using api key endpoint for OpenApiV2" do
        expect(@cdn_api.list.first["origin"]).to eq(@fake_service)
      end
    end

    describe AuthOpenApi do
      it "raises error on failed login" do
        stub_failed_login
        expect{ @cdn_api.get_session_token }.to raise_error(OpenApiError::ApiError)
      end

      it "gets a session token" do
        session_token = @cdn_api.get_session_token

        expect(session_token).to eq(@fake_token)
      end

      skip "gets a service identifier" do
        session = @cdn_api.get_session_token

        expect(session[0]["svcGroupIdentifier"]).to eq(@fake_identifier)
      end
    end

    describe OpenApiKeys do
      it "gets api keys" do
        api_key = @cdn_api.get_api_key(@fake_token, @fake_service)

        expect(api_key).to eq(@fake_key)
      end
    end

    describe StatisticsOpenApi do
      describe "#bandwidth_usage" do
        let(:end_time)           { Time.now }
        let(:start_time)         { end_time - 1*60*60*24 }
        let(:expected_bandwidth) { 1.23456 }

        before do
          stub_get_edge_traffic(expected_bandwidth)
        end

        it "returns bandwidth usage for a given time period" do
          expect(@cdn_api.bandwidth_usage @fake_service, start_time, end_time).to eq expected_bandwidth
        end

        it "returns 0 for service with no traffic in given range (cdnetworks returns 404)" do
          resp = JSON.pretty_unparse(trafficResponse: {returnCode: 404})
          stub_request(:post, "#{@url}/api/rest/traffic/edge").to_return(body: resp)

          expect(@cdn_api.bandwidth_usage @fake_service, start_time, end_time).to eq(0)
        end
      end
    end

  end
end
