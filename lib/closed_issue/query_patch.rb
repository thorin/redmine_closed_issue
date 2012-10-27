module ClosedIssue
  module QueryPatch
    def self.included(base) # :nodoc:
      base.class_eval do
        unloadable
  
        def available_filters_with_closed_date
          return @available_filters if @available_filters
          available_filters_without_closed_date
  
          @available_filters["closed_date"] = { :name => l(:field_closed_date), :type => :date_past, :order => 11 }
          @available_filters
        end
        alias_method_chain :available_filters, :closed_date
      end
    end
  end
end