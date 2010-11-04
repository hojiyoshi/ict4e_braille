/*====================================================================================================
//////////////////////////////////////////////////////////////////////////////////////////////////////

 Author : http://www.yomotsu.net
 created: 2007/11/20
 Licensed under the GNU Lesser General Public License version 2.1
 
 入力されたテキストを自動で半角に変換するスクリプト。
 自動で半角に変換したいinput要素、またはtextarea要素のclass属性に「ascii」を入れてくださぃ。

//////////////////////////////////////////////////////////////////////////////////////////////////////
====================================================================================================*/


var yomotsuReplaceChar = {

	conf : {
		asciiChar : ["!","&quot;","#","$","%","&amp;","\'","(",")","*","+",",","-",".","/","0","1","2","3","4","5","6","7","8","9",":",";","&gt;","=","&lt;","?","@","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","[","\\","]","^","_","`","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","{","|","}","~"],
		multibyteChar : ["！","”","＃","＄","％","＆","’","（","）","＊","＋","，","－","．","／","０","１","２","３","４","５","６","７","８","９","：","；","＞","＝","＜","？","＠","Ａ","Ｂ","Ｃ","Ｄ","Ｅ","Ｆ","Ｇ","Ｈ","Ｉ","Ｊ","Ｋ","Ｌ","Ｍ","Ｎ","Ｏ","Ｐ","Ｑ","Ｒ","Ｓ","Ｔ","Ｕ","Ｖ","Ｗ","Ｘ","Ｙ","Ｚ","［","￥","］","＾","＿","｀","ａ","ｂ","ｃ","ｄ","ｅ","ｆ","ｇ","ｈ","ｉ","ｊ","ｋ","ｌ","ｍ","ｎ","ｏ","ｐ","ｑ","ｒ","ｓ","ｔ","ｕ","ｖ","ｗ","ｘ","ｙ","ｚ","｛","｜","｝","￣"]
	},

	main : function (){
		input = document.getElementsByTagName("input");
		for(i=0;i<input.length;i++){
			yomotsuReplaceChar.replacing(input[i])
		}
		
		textarea = document.getElementsByTagName("textarea");
		for(i=0;i<textarea.length;i++){
			yomotsuReplaceChar.replacing(textarea[i])
		}
	},

	replacing : function (element){
		asciiChar = yomotsuReplaceChar.conf.asciiChar;
		multibyteChar = yomotsuReplaceChar.conf.multibyteChar;
		if(element.className.match(/\bascii/)){
			element.onblur = function(){
				for(i=0;i<asciiChar.length;i++){
					re = new RegExp(multibyteChar[i],"g");
					this.value = this.value.replace(re,asciiChar[i]);
				}
			}
		}
	},
	
	addEvent : function(){
			try {
			window.addEventListener('load', yomotsuReplaceChar.main, false);
		} catch (e) {
			window.attachEvent('onload', yomotsuReplaceChar.main);
		}
	}
	
}

yomotsuReplaceChar.addEvent();