class UserFormBuilder < ActionView::Helpers::FormBuilder
  def pick_errors(attribute)
    return nil if @object.nil? || (messages = @object.errors.messages[attribute]).nil?
    lis = messages.collect do |message|
      %{<li>#{@object.errors.full_message(attribute, message)}</li>}
    end.join

    %{<ul class="error_messages">#{lis}</ul>}.html_safe
  end

  def text_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def email_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def password_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end

  def select_field(attribute, options={})
    return super if options[:no_errors]
    super + pick_errors(attribute)
  end
end