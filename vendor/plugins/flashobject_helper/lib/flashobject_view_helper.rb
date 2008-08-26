# Author:: Davide D'Agostino aka DAddYE
# WebSite:: http://www.lipsiasoft.com
require 'action_view'

module ActionView #:nodoc:
  module Helpers # :nodoc:
    module FlashObjectHelper # :nodoc:
      def self.included(base)
        base.class_eval do
          include InstanceMethods
        end
      end
      module InstanceMethods
        # Returns a set of tags that display a Flash object within an
        # HTML page.
        #
        # Options:
        # * <tt>:div_id</tt> - the HTML +id+ of the +div+ element that is used to contain the Flash object; default "flashcontent"
        # * <tt>:flash_id</tt> - the +id+ of the Flash object itself.
        # * <tt>:background_color</tt> - the background color of the Flash object; default white
        # * <tt>:flash_version</tt> - the version of the Flash player that is required; default "7"
        # * <tt>:size</tt> - the size of the Flash object, in the form "100x100".  Defaults to "100%x100%"
        # * <tt>:variables</tt> - a Hash of initialization variables that are passed to the object; default <tt>{:lzproxied => false}</tt>
        # * <tt>:parameters</tt> - a Hash of parameters that configure the display of the object; default <tt>{:scale => 'noscale'}</tt>
        # * <tt>:fallback_html</tt> - HTML text that is displayed when the Flash player is not available.
        #
        # The following options are for developers.  They default to true in
        # development mode, and false otherwise.
        # * <tt>:check_for_javascript_include</tt> - if true, the return value will cause the browser to display a diagnostic message if the FlashObject JavaScript was not included.
        # * <tt>:verify_file_exists</tt> - if true, the return value will cause the browser to display a diagnostic message if the Flash object does not exist.
        #
        # (This method is called flashobject_tag instead of flashobject_tag
        # because it returns a *sequence* of HTML tags: a +div+, followed by
        # a +script+.)
        def flashobject_tag source, options={}
          verify_file_exists = options.fetch(:verify_file_exists, ENV['RAILS_ENV'] == 'development')
          if verify_file_exists and not File.exists? File.join(RAILS_ROOT, 'public', source)
            return "<div><strong>Warning:</strong> The file <code>#{File.join('public', source)}</code> does not exist.  Did you forget to execute <tt>rake applets</tt>?</div>"
          end
          div_id = options[:div_id] || "flashcontent_#{rand(1_100)}"
          flash_id = options[:flash_id] || File.basename(source, '.swf') + "_#{rand(1_100)}"
          width, height = (options[:size]||'100%x100%').scan(/^(\d*%?)x(\d*%?)$/).first
          background_color = options[:background_color] || '#ffffff'
          flash_version = options[:flash_version] || 7
          variables = options.fetch(:variables, {:lzproxied => false})
          parameters = options.fetch(:parameters, {:scale => 'noscale'})
          fallback_html = options[:fallback_html] || %q{<p>Requires the Flash plugin.  If the plugin is already installed, click <a href="?detectflash=false">here</a>.</p>}
          if options.fetch(:check_for_javascript_include, ENV['RAILS_ENV'] == 'development')
            check_for_javascript ="if (typeof FlashObject == 'undefined') document.getElementById('#{div_id}').innerHTML = '<strong>Warning:</strong> FlashObject is undefined.  Did you forget to execute <tt>rake update_javascripts</tt>, or to include <tt>&lt;%= javascript_include_tag :defaults %></tt> in your view file?';"
          end
          return <<-"EOF"
          <div id="#{div_id}" style="height: #{height}">
            #{fallback_html}
          </div>
          <script type="text/javascript">//<![CDATA[
            #{check_for_javascript}
            var fo = new FlashObject("#{source}", "#{flash_id}", "#{width}", "#{height}", "#{flash_version}", "#{background_color}");
          #{parameters.map{|k,v|%Q[fo.addParam("#{k}", "#{v}");]}.join("\n")}
          #{variables.map{|k,v|%Q[fo.addVariable("#{k}", "#{v}");]}.join("\n")}
          fo.write("#{div_id}");
          //]]>
          </script>
EOF
        end
      end
    end
  end
end

ActionView::Base.class_eval do
  include ActionView::Helpers::FlashObjectHelper
end

ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'flashobject'