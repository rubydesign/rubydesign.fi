require "i18n"
WillPaginate::ViewHelpers.pagination_options[:inner_window] = 4
WillPaginate::ViewHelpers.pagination_options[:outer_window] = 2
WillPaginate::ViewHelpers.pagination_options[:previous_label] = "prev"
WillPaginate::ViewHelpers.pagination_options[:next_label]     = "next"
