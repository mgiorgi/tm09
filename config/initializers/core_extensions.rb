module ActionController
  class Base
    def process_with_browser_profiling(request, response,
                                       method = :perform_action,
                                       *arguments)
      if request.parameters.key?('browser_profile!' )
        require 'ruby-prof'
        # Profile only the action
        profile_results = RubyProf.profile {
          response = process_without_browser_profiling(request, response,
                                                        method, *arguments)
        }
        # Use RubyProf's built in HTML printer to format the results
        printer = RubyProf::GraphHtmlPrinter.new(profile_results)
        # Append the results to the HTML response
        response.body << printer.print("" , 0)
        # Reset the content length (for Rails 2.0)
        response.send("set_content_length!" )
        response
      else
        process_without_browser_profiling(request, response,
                                           method, *arguments)
      end
    end
    alias_method_chain :process, :browser_profiling
  end
end
