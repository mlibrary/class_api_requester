# frozen_string_literal: true

#########################################################################
# ClassAPIRequester
# This class is to aid in the access to the Class Schedule and Roster API
# Documentation for the APIs:
# https://api.umich.edu/node/1218
# https://api.umich.edu/node/1119
class ClassAPIRequester
  def initialize(api_id,
                 api_secret,
                 request_url,
                 scope,
                 token_url)
    @api_id = api_id.freeze
    @api_secret = api_secret.freeze
    @request_url = request_url.freeze
    @scope = scope.freeze
    @token_url = token_url.freeze
  end

  ## The actual API calls
  def send_request(postfix)
    uri = URI(@request_url + postfix)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(uri)
    request['x-ibm-client-id'] = @api_id
    request['authorization'] = 'Bearer ' + token
    request['accept'] = 'application/json'
    http.request(request)
  end

  private

  # Get the Access token
  # Documentation: https://api.umich.edu/node/986
  def token
    url = URI(@token_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/x-www-form-urlencoded'
    request['accept'] = 'application/json'
    request.body = 'grant_type=client_credentials&client_id=' + @api_id + '&client_secret=' + @api_secret + '&scope=' + @scope
    response = http.request(request)
    JSON.parse(response.body)['access_token']
  end
end
