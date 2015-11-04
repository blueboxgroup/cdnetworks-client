module StatisticsOpenApi
  include AuthOpenApi
  include OpenApiKeys

  BANDWIDTH_PATH = "/api/rest/traffic/edge"

  def bandwidth_usage(service_name, from, to, time_interval = 2)
    session_token = get_session_token

    api_key = get_api_key(session_token, service_name)

    opts = {
      sessionToken: session_token,
      apiKey: api_key,
      fromDate: from.strftime("%Y%m%d"),
      toDate: to.strftime("%Y%m%d"),
      timeInterval: time_interval,
      output: "json"
    }

    response = call(BANDWIDTH_PATH, opts)

    if response[:code].to_s == "404"
      0.0
    else
      Array.wrap(response[:body]['trafficResponse']['trafficItem']).map{|i| i['dataTransferred']}.inject(&:+)
    end
  end
end
