# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # 改行コードを含む文字列を出力するための変換メソッド
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end

  def template_error_messages_for (object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    return nil unless object
    unless object.errors.empty?
      render :partial=>"layouts/error_messages_for",
        :locals=>{:messages=>object.errors.full_messages, :object=>object}
    end
  end
end
