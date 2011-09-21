class TenjiRequest < ActiveRecord::Base
  belongs_to :user
  file_column :braille_datafile1
  file_column :braille_datafile2
  file_column :braille_datafile3
  
  attr_accessor :to_type, :entry

  UPLOAD_ERR_MSG = 'は、Wordデータ（.doc又は.docxファイル）もしくは点字データ(.base、bse、besファイル)を選択してください。'
  EXT_NAME_LIST = ['.doc', '.docx', '.base', '.bes', '.bse']
  
  # 依頼人）名前の値検証
  # 入力必須をチェック
  validates_presence_of :from_user_name
  # 文字列の最大長さ（50文字以下）をチェック
  validates_length_of :from_user_name,:maximum => 50

  # 依頼人）郵便番号の値検証
  # 入力必須をチェック
  validates_presence_of :from_zip_code
  # 文字列の最大長さ（8文字以下）をチェック
  validates_length_of :from_zip_code,:maximum => 8

  # 依頼人）住所の値検証
  # 入力必須をチェック
  validates_presence_of :from_user_address1
  # 文字列の最大長さ（100文字以下）をチェック
  validates_length_of :from_user_address1,:maximum => 100

  # 依頼人）ビル・マンション名の値検証
  # 文字列の最大長さ（100文字以下）をチェック
  validates_length_of :from_user_address2,:maximum => 100

  # 依頼人）電話番号の値検証
  # 文字列の最大長さ（15文字以下）をチェック
  validates_length_of :from_phone_number,:maximum => 15

  # 依頼人）所属の値検証
  # 文字列の最大長さ（50文字以下）をチェック
  validates_length_of :from_user_affiliation,:maximum => 50

  # 届け先）名前の値検証
  # 『別の住所に送る』場合、入力必須をチェック
  validates_presence_of :to_user_name,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}
  # 『別の住所に送る』場合、文字列の最大長さ（50文字以下）をチェック
  validates_length_of :to_user_name,:maximum => 50,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 届け先）郵便番号の値検証
  # 『別の住所に送る』場合、入力必須をチェック
  validates_presence_of :to_zip_code,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}
  # 『別の住所に送る』場合、文字列の最大長さ（8文字以下）をチェック
  validates_length_of :to_zip_code,:maximum => 8,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 届け先）住所の値検証
  # 『別の住所に送る』場合、入力必須をチェック
  validates_presence_of :to_user_address1,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}
  # 『別の住所に送る』場合、文字列の最大長さ（100文字以下）をチェック
  validates_length_of :to_user_address1,:maximum => 100,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 届け先）ビル・マンション名の値検証
  # 『別の住所に送る』場合、文字列の最大長さ（100文字以下）をチェック
  validates_length_of :to_user_address2,:maximum => 100,
    :unless => Proc.new {|p| p.to_type == 'to_type_same'}

  # 印刷依頼データ）タイトル
  # 入力必須をチェック
  validates_presence_of :print_name1
  validates_presence_of :print_name2,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile2.blank?}
  validates_presence_of :print_name3,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile3.blank?}
  
  #文字列の最大長さ（100文字以下）をチェック
  validates_length_of :print_name1,:maximum => 100
  validates_length_of :print_name2,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile3.blank?}
  validates_length_of :print_name3,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile3.blank?}
  
  # 印刷依頼データ）サブタイトル1
  # 『テキスト入力』の場合、文字列の最大長さ（100文字以下）をチェック
  validates_length_of :print_title1,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_text'}

  # 印刷依頼データ）内容1
  # 『テキスト入力』の場合、入力必須をチェック
  validates_presence_of :print_contents1,
    :if => Proc.new {|p| p.data_type == 'data_type_text'}

  # 印刷依頼データ）サブタイトル2
  # 『テキスト入力』の場合、文字列の最大長さ（100文字以下）をチェック
  validates_length_of :print_title2,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_text'}

  # 印刷依頼データ）サブタイトル3
  # 『テキスト入力』の場合、文字列の最大長さ（100文字以下）をチェック
  validates_length_of :print_title3,:maximum => 100,
    :if => Proc.new {|p| p.data_type == 'data_type_text'}

  # 印刷依頼データ）添付ファイル
  # 『添付ファイル』の場合、入力必須をチェック
  validates_presence_of :braille_datafile1,
    :if => Proc.new {|p| p.data_type == 'data_type_file'}
  
  # 『添付ファイル』の場合、ファイルフォーマットをチェック
  validate :validate_upload1,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile1.blank?}
  validate :validate_upload2,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile2.blank?}
  validate :validate_upload3,
    :if => Proc.new {|p| p.data_type == 'data_type_file' && !p.braille_datafile3.blank?}

  protected 
    def validate_upload1
      extname = File::extname(braille_datafile1).downcase
      if !(extname == '.doc' || extname == '.docx' || extname == '.base' || extname == '.bes' || extname == '.bse')
        errors.add(:braille_datafile1, UPLOAD_ERR_MSG)
      end
    end

    def validate_upload2
      extname = File::extname(braille_datafile2).downcase
      if !(extname == '.doc' || extname == '.docx' || extname == '.base' || extname == '.bes' || extname == '.bse')
        errors.add(:braille_datafile2, UPLOAD_ERR_MSG)
      end
    end

    def validate_upload3
      extname = File::extname(braille_datafile3).downcase
      if !(extname == '.doc' || extname == '.docx' || extname == '.base' || extname == '.bes' || extname == '.bse')
        errors.add(:braille_datafile3, UPLOAD_ERR_MSG)
      end
    end
end
