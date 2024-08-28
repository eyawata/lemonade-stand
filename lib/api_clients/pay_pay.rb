require 'base64'
require 'json'
require 'openssl'
require 'securerandom'
require 'time'
require 'httpclient'

module PayPay
  PROD = 'api.paypay.ne.jp'
  STAGING = 'stg-api.sandbox.paypay.ne.jp'
  PERF_MODE = 'perf-api.paypay.ne.jp'

  class QrCodeCreateBuilder
    def initialize()
      @result = {
        amount: {
          amount: 1000,
          currency: 'JPY',
        },
        orderItems: [],
        metadata: {},
        codeType: 'ORDER_QR',
        storeInfo: 'store',
        storeId: '1',
        terminalId: '1',
        requestedAt: Time.now.to_i,
        redirectUrl: 'https://paypay.ne.jp/',
        redirectType: 'WEB_LINK',
        isAuthorization: false,
        authorizationExpiry: Time.now.to_i + 60,
      }
    end

    def merchantPaymentId(uuid = nil)
      @result["merchantPaymentId"] = uuid.nil? ? SecureRandom::uuid : uuid
    end

    def addItem(name, category, quantity, product_id, unit_amount)
      item = {
        name: name,
        # category: category,
        quantity: quantity,
        # productId: product_id,
        unitPrice: {
          amount: unit_amount.to_i,
          currency: 'JPY',
        },
      }
      @result[:orderItems] << item
      @result[:amount][:amount] = @result[:amount][:amount] + quantity * unit_amount.to_i
    end

    def finish()
      @result
    end
  end

  class Client
    def initialize(api_key, api_secret, merchant_id, production_flag = false, pref_flag = false)
      @api_key = api_key
      @api_secret = api_secret
      @merchant_id = merchant_id
      @host_name = 'https://' + if pref_flag
        PERF_MODE
      elsif production_flag
        PROD
      else
        STAGING
      end
    end

    def qr_code_create(params)
      method = 'POST'
      url = '/v2/codes'
      opa, content_type = PayPay.calc(@api_key, @api_secret, url, method, params)
      client = HTTPClient.new()
      #client.debug_dev = STDOUT
      client.post(@host_name + url, params.to_json, {"Authorization" => opa, "X-ASSUME-MERCHANT" => @merchant_id, 'Content-Type' => content_type})
    end
  end

  def self.calc(api_key, api_secret, url, method, body)
    nonce = SecureRandom.alphanumeric(8)
    epoch = Time.now.to_i
    payload, content_type = if body.nil? || body == ""
      ['empty', 'empty']
    else
      content_type = 'application/json;charset=UTF-8;'
      [
        Base64.strict_encode64(
          OpenSSL::Digest::MD5.digest(
            content_type + body.to_json
          )
        ),
        content_type
      ]
    end
    hashed64 = Base64.strict_encode64(
      OpenSSL::HMAC.digest(
        'sha256',
        api_secret,
        # [url, method, nonce, epoch, content_type, payload].join("\n")
        [url, method, nonce.to_s, epoch.to_s, content_type, payload].map(&:to_s).join("\n")
      )
    )
    ["hmac OPA-Auth:#{[api_key, hashed64, nonce, epoch, payload].join(":")}", content_type]
  end
end
