/*====================================================================================================
//////////////////////////////////////////////////////////////////////////////////////////////////////

 author : http://www.yomotsu.net
 thanks : http://css-happylife.com
 created: 2008/02/23
 update : 2009/01/06
 
 public domain
 
 入力されたテキストを自動で指定の形式(半角,全角,ひらがな,全角カタカナ)に変換する JavaScript。
 自動で指定の形式に変換したい input 要素、または textarea 要素の class 属性に
 この JS 内の conf で設定した内容を指定すると動作します。

//////////////////////////////////////////////////////////////////////////////////////////////////////
====================================================================================================*/

var valueConvertor = {
	
	conf : {
		asciiClass        : "ascii",
		multibyteClass    : "multibyte",
		hiraganaClass     : "hiragana",
		katakanaClass     : "katakana",
		fullwidthKanaClass: "fullwidth-kana",
		halfwidthKanaClass: "halfwidth-kana"
	},
	

	main : function (){
		var i;
		var input    = document.getElementsByTagName("input");
		var textarea = document.getElementsByTagName("textarea");
		
		for ( i in valueConvertor.conf ){
			valueConvertor.conf[i] = new RegExp("\\b"+valueConvertor.conf[i]+"\\b");
		}
		
		for(i=0;i<input.length;i++)	{
			try {
				input[i].addEventListener('blur', valueConvertor.convert, false);
			} catch (e) {
				input[i].attachEvent('onblur', (function(el){return function(){valueConvertor.convert.call(el);};})(input[i])); 
			}
		}
		for(i=0;i<textarea.length;i++){
			try {	
				textarea[i].addEventListener('blur', valueConvertor.convert, false);
			} catch (e) {
				textarea[i].attachEvent('onblur', (function(el){return function(){valueConvertor.convert.call(el);};})(textarea[i])); 
			}
		}
	},

	convert : function(){
		
		if (this.className.match(valueConvertor.conf.asciiClass))
			this.value = valueConvertor.toAsciiCase(this.value);
		else if (this.className.match(valueConvertor.conf.multibyteClass))
			this.value = valueConvertor.toMultibyteCase(this.value);
			
		if (this.className.match(valueConvertor.conf.hiraganaClass)){
			this.value = valueConvertor.toZenkanaCase(this.value);
			this.value = valueConvertor.toHiraganaCase(this.value);
			this.value = valueConvertor.toPaddingCase(this.value);
		}
		else if (this.className.match(valueConvertor.conf.katakanaClass)){
			this.value = valueConvertor.toZenkanaCase(this.value);
			this.value = valueConvertor.toKatakanaCase(this.value);
			this.value = valueConvertor.toPaddingCase(this.value);
		}
		
		if(this.className.match(valueConvertor.conf.fullwidthKanaClass)){
			this.value = valueConvertor.toZenkanaCase(this.value);
			this.value = valueConvertor.toPaddingCase(this.value);
		}
		else if(this.className.match(valueConvertor.conf.halfwidthKanaClass)){
			this.value = valueConvertor.toHankanaCase(this.value);
		}
	},
	
	toAsciiCase : function(text){
		var i, charCode, charArray = [];
		for(i=text.length-1;0<=i;i--) {
			charCode = charArray[i] = text.charCodeAt(i);
			switch(true) {
				case (charCode <= 0xff5e && 0xff01 <= charCode):
					charArray[i] -= 0xfee0;
					break;
				case (charCode == 0x3000):
					charArray[i] = 0x0020;
					break;
				case (charCode == 0x30FC):
					charArray[i] = 0x002D;
					break;
			}
		}
		return String.fromCharCode.apply(null, charArray);
	},
	
	toMultibyteCase : function(text){
		var i, charCode, charArray = [];
		for(i=text.length-1;0<=i;i--)
		{
			charCode = charArray[i] = text.charCodeAt(i);
			switch(true) {
				case (charCode <= 0x007E && 0x0021 <= charCode):
					charArray[i] += 0xFEE0;
					break;
				case (charCode == 0x0020):
					charArray[i] = 0x3000;
					break;
			}
		}
		return String.fromCharCode.apply(null, charArray);	
	},
	
	toZenkanaCase : function(text){
		var i, charCode, m, charArray = [];
		m =
		{
			0xFF66:0x30F2, 0xFF67:0x30A1, 0xFF68:0x30A3, 0xFF69:0x30A5, 0xFF6A:0x30A7,
			0xFF6B:0x30A9, 0xff6c:0x30e3, 0xff6d:0x30e5, 0xff6e:0x30e7, 0xff6f:0x30c3,
			0xFF70:0x30FC, 0xFF71:0x30A2, 0xFF72:0x30A4, 0xFF73:0x30A6, 0xFF74:0x30A8,
			0xFF75:0x30AA, 0xFF76:0x30AB, 0xFF77:0x30AD, 0xFF78:0x30AF, 0xFF79:0x30B1,
			0xFF7A:0x30B3, 0xFF7B:0x30B5, 0xFF7C:0x30B7, 0xFF7D:0x30B9, 0xFF7E:0x30BB,
			0xFF7F:0x30BD, 0xFF80:0x30BF, 0xFF81:0x30C1, 0xFF82:0x30C4, 0xFF83:0x30C6,
			0xFF84:0x30C8, 0xFF85:0x30CA, 0xFF86:0x30CB, 0xFF87:0x30CC, 0xFF88:0x30CD,
			0xFF89:0x30CE, 0xFF8A:0x30CF, 0xFF8B:0x30D2, 0xFF8C:0x30D5, 0xFF8D:0x30D8,
			0xFF8E:0x30DB, 0xFF8F:0x30DE, 0xFF90:0x30DF, 0xFF91:0x30E0, 0xFF92:0x30E1,
			0xFF93:0x30E2, 0xFF94:0x30E4, 0xFF95:0x30E6, 0xFF96:0x30E8, 0xFF97:0x30E9,
			0xFF98:0x30EA, 0xFF99:0x30EB, 0xFF9A:0x30EC, 0xFF9B:0x30ED, 0xFF9C:0x30EF,
			0xFF9D:0x30F3, 0xFF9E:0x309B, 0xFF9F:0x309C
		};
		
		for(i=text.length-1;0<=i;i--){
			charCode = text.charCodeAt(i);
			if (m[charCode]){
				charArray[i] = m[charCode];
			}
			else{
				charArray[i] = charCode;
			}
		}
		
		return String.fromCharCode.apply(null, charArray);
	},
	
	toHankanaCase : function(text){
		var i, charCode, m, charArray = [];
		m =
		{
			0x30A1:0xFF67, 0x30A3:0xFF68, 0x30A5:0xFF69, 0x30A7:0xFF6A, 0x30A9:0xFF6B,
			0x30e3:0xff6c, 0x30e5:0xff6d, 0x30e7:0xff6e, 0x30c3:0xff6f, 0x30FC:0xFF70,
			0x30A2:0xFF71, 0x30A4:0xFF72, 0x30A6:0xFF73, 0x30A8:0xFF74, 0x30AA:0xFF75,
			0x30AB:0xFF76, 0x30AD:0xFF77, 0x30AF:0xFF78, 0x30B1:0xFF79, 0x30B3:0xFF7A,
			0x30B5:0xFF7B, 0x30B7:0xFF7C, 0x30B9:0xFF7D, 0x30BB:0xFF7E, 0x30BD:0xFF7F,
			0x30BF:0xFF80, 0x30C1:0xFF81, 0x30C4:0xFF82, 0x30C6:0xFF83, 0x30C8:0xFF84,
			0x30CA:0xFF85, 0x30CB:0xFF86, 0x30CC:0xFF87, 0x30CD:0xFF88, 0x30CE:0xFF89,
			0x30CF:0xFF8A, 0x30D2:0xFF8B, 0x30D5:0xFF8C, 0x30D8:0xFF8D, 0x30DB:0xFF8E,
			0x30DE:0xFF8F, 0x30DF:0xFF90, 0x30E0:0xFF91, 0x30E1:0xFF92, 0x30E2:0xFF93,
			0x30E4:0xFF94, 0x30E6:0xFF95, 0x30E8:0xFF96, 0x30E9:0xFF97, 0x30EA:0xFF98,
			0x30EB:0xFF99, 0x30EC:0xFF9A, 0x30ED:0xFF9B, 0x30EF:0xFF9C, 0x30F3:0xFF9D,
			0x309B:0xFF9E, 0x309C:0xFF9F, 0x30F2:0xFF66
		};
		for(i=0;i<text.length;i++) {
			charCode = text.charCodeAt(i);
			switch(true) {
				case (charCode in m):
					charArray.push(m[charCode]);
					break;
				case (0x30AB <= charCode && charCode <= 0x30C9):
					charArray.push(m[charCode-1], 0xFF9E);
					break;
				case (0x30CF <= charCode && charCode <= 0x30DD):
					charArray.push(m[charCode-charCode%3], [0xFF9E,0xFF9F][charCode%3-1]);
					break;
				case (0x30f4 == charCode):
					charArray.push(0xff73, 0xFF9E);
					break;
				default:
					charArray.push(charCode);
					break;
			}
		}
		return String.fromCharCode.apply(null, charArray);
	},
	
	toHiraganaCase : function(text){
		var i, charCode, charArray = [];
		for(i=text.length-1;0<=i;i--){
			charCode = text.charCodeAt(i);
			charArray[i] = (0x30A1 <= charCode && charCode <= 0x30F6) ? charCode - 0x0060 : charCode;
		}
		return String.fromCharCode.apply(null, charArray);
	},
	
	toKatakanaCase : function(text){
		var i, charCode, m, charArray = [];
		for(i=text.length-1;0<=i;i--){
			charCode = text.charCodeAt(i);
			if(0x3041 <= charCode && charCode <= 0x3096){
				charArray[i] = charCode + 0x0060 ;
			}
			else{
				charArray[i] = charCode;
			}
		}
		return String.fromCharCode.apply(null, charArray);
	},
		
	//半角の濁点、半角の半濁点の処理
	toPaddingCase : function(text){
		var i, charCode, charArray = [];
		for(i=0;i<text.length;i++)
		{
			charCode = text.charCodeAt(i);
			switch(true)
			{
				case (0x304B <= charCode && charCode <= 0x3062 && (charCode % 2 == 1)):
				case (0x30AB <= charCode && charCode <= 0x30C2 && (charCode % 2 == 1)):
				case (0x3064 <= charCode && charCode <= 0x3069 && (charCode % 2 == 0)):
				case (0x30C4 <= charCode && charCode <= 0x30C9 && (charCode % 2 == 0)):
					charArray.push(charCode + ({0x309B:1}[text.charCodeAt(i+1)] || 0));
					if(charArray[charArray.length-1] != charCode){ i++; };
					break;
				case (0x306F <= charCode && charCode <= 0x307F && (charCode % 3 == 0)):
				case (0x30CF <= charCode && charCode <= 0x30DD && (charCode % 3 == 0)):
					charArray.push(charCode + ({0x309B:1,0x309C:2}[text.charCodeAt(i+1)] || 0));
					if(charArray[charArray.length-1] != charCode){ i++; };
					break;
				case (0x3046 == charCode || 0x30a6 == charCode):
					charArray.push(charCode + ({0x309B:78}[text.charCodeAt(i+1)] || 0));
					if(charArray[charArray.length-1] != charCode){ i++; };
					break;
				default:
					charArray.push(charCode);
					break;
				}
		}
		return String.fromCharCode.apply(null, charArray);
	},
	
	addEvent : function(){
		try {
			window.addEventListener('load', this.main, false);
		} catch (e) {
			window.attachEvent('onload', this.main);
		}
	}
	
}

valueConvertor.addEvent();