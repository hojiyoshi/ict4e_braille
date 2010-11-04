class TenjiUser < ActiveRecord::Base
  has_many :tenji_requests, :foreign_key => 'req_id'
  belongs_to :user
  
  attr_accessor :zip_code1,:zip_code2

  # 名前の値検証
  validates_presence_of     :firstname_kanji
  validates_length_of       :firstname_kanji,:maximum => 64

  # ふりがなの値検証
  validates_length_of       :firstname_kana,:maximum => 64

  # 会社名の値検証
  validates_length_of       :lastname_kanji,:maximum => 64

  # 部署名の値検証
  validates_length_of       :lastname_kana,:maximum => 64

  # 郵便番号の値検証
  validates_presence_of     :zip_code1,
    :if => :zip_code_required?
  validates_format_of       :zip_code1, :with => /^[0-9]{3}$/,
    :unless => Proc.new {|p| p.zip_code1.blank?}
  validates_presence_of     :zip_code2,
    :if => :zip_code_required?
  validates_format_of       :zip_code2, :with => /^[0-9]{4}$/,
    :unless => Proc.new {|p| p.zip_code2.blank?}

  # 住所の値検証
  validates_length_of       :user_address1,:maximum => 16
  validates_length_of       :user_address2,:maximum => 255
  validates_length_of       :user_address3,:maximum => 255
  validates_length_of       :user_address4,:maximum => 255
  validates_length_of       :user_address5,:maximum => 255

  # 電話番号の値検証
  validates_presence_of     :phone_number1,
    :if => :phone_number_required?
  validates_length_of       :phone_number1,:maximum => 4
  validates_format_of       :phone_number1, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.phone_number1.blank?}
  validates_presence_of     :phone_number2,
    :if => :phone_number_required?
  validates_length_of       :phone_number2,:maximum => 4
  validates_format_of       :phone_number2, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.phone_number2.blank?}
  validates_presence_of     :phone_number3,
    :if => :phone_number_required?
  validates_length_of       :phone_number3,:maximum => 4
  validates_format_of       :phone_number3, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.phone_number3.blank?}

  # FAX番号の値検証
  validates_presence_of     :fax_number1,
    :if => :fax_number_required?
  validates_length_of       :fax_number1,:maximum => 4
  validates_format_of       :fax_number1, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.fax_number1.blank?}
  validates_presence_of     :fax_number2,
    :if => :fax_number_required?
  validates_length_of       :fax_number2,:maximum => 4
  validates_format_of       :fax_number2, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.fax_number2.blank?}
  validates_presence_of     :fax_number3,
    :if => :fax_number_required?
  validates_length_of       :fax_number3,:maximum => 4
  validates_format_of       :fax_number3, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.fax_number3.blank?}

  # 携帯番号の値検証
  validates_presence_of     :cellphone_number1,
    :if => :cellphone_number_required?
  validates_length_of       :cellphone_number1,:maximum => 4
  validates_format_of       :cellphone_number1, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.cellphone_number1.blank?}
  validates_presence_of     :cellphone_number2,
    :if => :cellphone_number_required?
  validates_length_of       :cellphone_number2,:maximum => 4
  validates_format_of       :cellphone_number2, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.cellphone_number2.blank?}
  validates_presence_of     :cellphone_number3,
    :if => :cellphone_number_required?
  validates_length_of       :cellphone_number3,:maximum => 4
  validates_format_of       :cellphone_number3, :with => /^([0-9]+$)/,
    :unless => Proc.new {|p| p.cellphone_number3.blank?}

  # 携帯電話メールアドレスの値検証
  validates_format_of       :cellphone_email, :with => /^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)+$/,
    :unless => Proc.new {|p| p.cellphone_email.blank?}

  protected
    def zip_code_required?
      !(zip_code1.blank? && zip_code2.blank?)
    end

    def phone_number_required?
      !(phone_number1.blank? && phone_number2.blank? && phone_number3.blank?)
    end

    def fax_number_required?
      !(fax_number1.blank? && fax_number2.blank? && fax_number3.blank?)
    end

    def cellphone_number_required?
      !(cellphone_number1.blank? && cellphone_number2.blank? && cellphone_number3.blank?)
    end

    def before_save
      self.zip_code = zip_code1 + '-' + zip_code2
      self.req_id = current_user.tenji_user.id
      self.download_name = Time.now.strftime("%Y%m%d%H%M%S") + '.xml'
    end
end
