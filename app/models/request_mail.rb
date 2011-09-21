require 'nkf'

class RequestMail < ActionMailer::Base
  def request_mail(tenji_request, user)
    setup_email(tenji_request, user)
    #@body[:url] = ICT4E_BRAILLE_URL+"tenji_request/braille_datafile/#{tenji_request.id}/#{File::basename(tenji_request.braille_datafile)}"
    @body[:url1] = ICT4E_BRAILLE_URL+"tenji_request/braille_datafile1/#{tenji_request.braille_datafile1_relative_path}"

    if !tenji_request.print_name2.blank? && !tenji_request.braille_datafile2.blank?
      @body[:url2] = ICT4E_BRAILLE_URL+"tenji_request/braille_datafile2/#{tenji_request.braille_datafile2_relative_path}"
    end
    if !tenji_request.print_name3.blank? && !tenji_request.braille_datafile3.blank?
      @body[:url3] = ICT4E_BRAILLE_URL+"tenji_request/braille_datafile3/#{tenji_request.braille_datafile3_relative_path}"
    end
  end

  protected
    def setup_email(tenji_request, user)
      @sent_on    = Time.now
      @body[:office] = 'braille_office@ict4everyone.jp'
      @body[:ict4everyone_name] = 'http://www.ict4everyone.jp'
      @recipients  = REQUEST_MAILADDRESS
      @from        = 'braille-request@ict4everyone.jp'
      @subject     = "【みんなのICT】点字印刷依頼受付完了のお知らせ "
      @body[:request] = tenji_request
      @body[:user] = user
    end
end
