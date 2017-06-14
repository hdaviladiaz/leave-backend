require 'yaml'

CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/saml_config.yml")).result)
ENVIROMENT = ENV.fetch("RAILS_ENV") || 'test'
CONFIG_AUTH = CONFIG[ENVIROMENT]['auth']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
           :issuer => CONFIG_AUTH['issuer'],
           :idp_sso_target_url => CONFIG_AUTH['target_url'],
           :idp_cert_fingerprint => CONFIG_AUTH['fingerprint'],
           :name_identifier_format => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
           :assertion_consumer_service_url => CONFIG_AUTH['assertion_url'],
           :idp_sso_target_url_runtime_params => {:redirectUrl => :RelayState}
end
