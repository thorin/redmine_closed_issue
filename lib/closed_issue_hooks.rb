module ClosedIssueHooks
  class Hooks < Redmine::Hook::ViewListener
    def controller_issues_new_before_save(context)
      save_closed_date(context[:issue])
    end

    def controller_issues_edit_before_save(context)
      save_closed_date(context[:issue])
    end

    def save_closed_date(issue)
      return if issue.blank?

      if issue.closed?
        issue.closed_date = Time.now if issue.closing? or issue.new_record?
      else
        issue.closed_date = nil if issue.closed_date
      end
    end
  end

  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => "issues/show_start_end_date"
  end
end
