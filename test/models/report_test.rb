# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')
    my_report = Report.create(user_id: me.id, title: '題名', content: '内容')
    her_report = Report.create(user_id: she.id, title: '題名', content: '内容')

    assert my_report.editable?(me)
    assert_not her_report.editable?(me)
  end

  test '#created_on' do
    me = User.create!(email: 'me@example.com', password: 'password')
    my_report = Report.create(user_id: me.id, title: '題名', content: '内容')
    assert_equal my_report.created_on, my_report.created_at.to_date
    assert_not_equal my_report.created_on, my_report.created_at
  end
end
