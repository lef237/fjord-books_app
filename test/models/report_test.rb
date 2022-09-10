# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    alice = users(:alice)
    bob = users(:bob)
    alice_report = reports(:alice_report)
    bob_report = reports(:bob_report)

    assert alice_report.editable?(alice)
    assert_not bob_report.editable?(alice)
  end

  test '#created_on' do
    alice = users(:alice)
    alice_report = reports(:alice_report)
    assert_equal Date.today, alice_report.created_at.to_date
  end
end
