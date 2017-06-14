require 'yaml'

config = YAML.load(ERB.new(File.read("#{Rails.root}/config/saml_config.yml")).result)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
           :issuer => config['auth']['issuer'],
           :idp_sso_target_url => config['auth']['target_url'],
           :idp_cert_fingerprint => config['auth']['fingerprint'],
           :name_identifier_format => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
           :assertion_consumer_service_url =>"http://localhost:3000/auth/saml/callback",
           :idp_sso_target_url_runtime_params => {:redirectUrl => :RelayState}
end