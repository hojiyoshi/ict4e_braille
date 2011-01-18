class TenjiRequest < ActiveRecord::Base
  belongs_to :user
  file_column :braille_datafile
  
  attr_accessor :to_type, :attached_file, :braille_xmlfile
  
  # 依頼人）名前の値検証
  validates_presence_of :from_user_name
  validates_length_of :from_user_name,:maximum => 50

  # 依頼人）郵便番号の値検証
  validates_presence_of :from_zip_code
  validates_length_of :from_zip_code,:maximum => 8

  # 依頼人）住所の値検証
  validates_presence_of :from_user_address1
  validates_length_of :from_user_address1,:maximum => 100

  # 依頼人）ビル・マンション名の値検証
  validates_length_of :from_user_address2,:maximum => 100

  # 依頼人）電話番号の値検証
  validates_length_of :from_phone_number,:maximum => 15

  # 依頼人）所属の値検証
  validates_length_of :from_user_affiliation,:maximum => 50

  # 届け先）名前の値検証
  validates_presence_of :to_user_name,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}
  validates_length_of :to_user_name,:maximum => 50,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 届け先）郵便番号の値検証
  validates_presence_of :to_zip_code,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}
  validates_length_of :to_zip_code,:maximum => 8,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 届け先）住所の値検証
  validates_presence_of :to_user_address1,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}
  validates_length_of :to_user_address1,:maximum => 100,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 届け先）ビル・マンション名の値検証
  validates_length_of :to_user_address2,:maximum => 100,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 印刷依頼データ）タイトル
  validates_presence_of :print_name
  validates_length_of :print_name,:maximum => 100,
    :if => Proc.new {|p| p.print_name != nil}
  
  # 印刷依頼データ）サブタイトル1
  validates_length_of :print_title1,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_text' && p.print_title1 != nil}

  # 印刷依頼データ）内容1
  validates_presence_of :print_contents1,
    :if => Proc.new {|p| p.data_type == 'data_type_text'}

  # 印刷依頼データ）サブタイトル2
  validates_length_of :print_title2,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_text' && p.print_title2 != nil}

  # 印刷依頼データ）サブタイトル3
  validates_length_of :print_title3,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_text' && p.print_title3 != nil}

  # 印刷依頼データ）添付ファイル
  #validates_presence_of :braille_datafile,
  #  :if => Proc.new {|p| p.data_type == 'data_type_file'}

  validate :validate_upload,
    :if => Proc.new {|p| p.data_type == 'data_type_file'}

  protected    
    def before_save
      if self.braille_datafile.blank?
        self.braille_datafile = Time.now.strftime("%Y%m%d%H%M%S") + '.txt'
      end
    end

    def after_save
      
    end

    def validate_upload
     #extname = File::extname(attached_file.original_filename).downcase
     # if !(extname == '.doc' || extname == '.docx' || extname == '.base' || extname == '.bes' || extname == '.txt')
     #   errors.add(:attached_file,'依頼データはWordデータ（.doc又は.docxファイル）もしくは点字データ(.Base又は.Besファイル)を選択してください。')
     # end
      #self.attached_file = attached_file.original_filename
    end
end
