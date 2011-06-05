require 'nkf'

class RequestMail < ActionMailer::Base
  def request_mail(tenji_request)
    setup_email(tenji_request)
    #@body[:url] = ICT4E_BRAILLE_URL+"tenji_request/braille_datafile/#{tenji_request.id}/#{File::basename(tenji_request.braille_datafile)}"
    @body[:url] = ICT4E_BRAILLE_URL+"tenji_request/braille_datafile/#{tenji_request.braille_datafile_relative_path}"
  end

  protected
    def setup_email(tenji_request)
      @sent_on    = Time.now
      @body[:office] = 'braille_request@ict4everyone.jp' 
      @body[:ict4everyone_name] = 'http://www.ict4everyone.jp'
      @recipients  = REQUEST_MAILADDRESS
      @from        = 'braille_request@ict4everyone.jp'
      @subject     = "【みんなのICT】点字印刷依頼受付完了のお知らせ "
      @body[:request] = tenji_request
    end
end
