require 'redmine'
require 'closed_issue_hooks'

Redmine::Plugin.register :redmine_closed_issue do
  name 'Redmine Closed Date plugin'
  author 'Matheus Ashton Silva'
  description 'A plugin that save the date when the issue is closed, and shows it on issue/show view'
  version '0.0.1'
  url 'http://github.com/ashton/redmine_closed_date'
  author_url 'http://matheusashton.net'
  requires_redmine :version_or_higher => '2.0.0'
end

Rails.configuration.to_prepare do
  IssueQuery.add_available_column(
    QueryColumn.new(:closed_date, :sortable => "#{Issue.table_name}.closed_date", :groupable => true, :caption => :field_closed_date)
  )

  unless IssueQuery.include? ClosedIssue::IssueQueryPatch
    IssueQuery.send( :include, ClosedIssue::IssueQueryPatch)
  end
end
