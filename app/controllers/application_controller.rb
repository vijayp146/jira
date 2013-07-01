require 'jira'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  end

  def show
    client = get_jira_client({username: params[:username], password: params[:password], site: params[:host], context_path: params[:context]})
    @issues = client.Issue.jql(params[:jql])
  end

  rescue_from JIRA::OauthClient::UninitializedAccessTokenError do
    redirect_to new_jira_session_url
  end

  private

  def get_jira_client(options={})

    options[:use_ssl] = true
    options[:auth_type] = :basic

    @jira_client = JIRA::Client.new(options)

    # Add AccessToken if authorised previously.
    if session[:jira_auth]
      @jira_client.set_access_token(
        session[:jira_auth][:access_token],
        session[:jira_auth][:access_key]
      )
    end

    @jira_client
  end

end
