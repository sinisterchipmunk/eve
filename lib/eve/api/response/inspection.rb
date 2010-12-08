module Eve
  class API
    class Response
      module Inspection
        def protected_instance_variables
          (respond_to?(:content) && !content.blank? ? [] : ["@content"]) +
          #(respond_to?(:rowsets) && !rowsets.empty? ? rowsets.collect { |r| "@#{r.name}" } : []) +
          [:@rowsets, :@options, :@xml, :@columns, :@row, :@name]
        end

        def inspected_name
          respond_to?(:name) ? self.name : "(Response)"
        end

        def inspected_rowsets
          return nil unless respond_to?(:rowsets) && !rowsets.empty?
          "[#{rowsets.collect { |r| r.inspect }.join(", ")}]"
        end

        def inspected_elements
          return nil unless respond_to?(:empty?) && !empty?
          "[#{self.collect { |i| i.inspect }.join(", ")}]"
        end

        def inspected_instance_variables
          return nil if (ivars = instance_variables - protected_instance_variables).empty?

          ivars.sort! do |a, b|
            original = a <=> b
            a = instance_variable_get(a)
            b = instance_variable_get(b)
            a_rowset = a.kind_of?(Rowset)
            b_rowset = b.kind_of?(Rowset)

            if a_rowset && b_rowset then a.name <=> b.name
            elsif a_rowset && !b_rowset then 1
            elsif !a_rowset && b_rowset then -1
            else original
            end
          end

          "#{ivars.map do |ivar|
            v = instance_variable_get(ivar)
            if v.kind_of?(Rowset)
              v.inspect
            else
              "#{ivar[1..-1]}=>#{instance_variable_get(ivar).inspect}"
            end
          end.join(" ")}"
        end

        def inspect
          r = "#<#{inspected_name}"
          r.concat " #{inspected_instance_variables}" if !inspected_instance_variables.nil?
          r.concat ">"
          r.concat "#{inspected_elements}" if !inspected_elements.nil?
          return r
        end
      end
    end
  end
end
