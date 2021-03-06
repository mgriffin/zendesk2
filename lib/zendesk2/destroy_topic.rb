# frozen_string_literal: true
class Zendesk2::DestroyTopic
  include Zendesk2::Request

  request_method :delete
  request_path { |r| "/topics/#{r.topic_id}.json" }

  def topic_id
    params.fetch('topic').fetch('id')
  end

  def mock
    delete!(:topics, topic_id)

    mock_response(nil)
  end
end
