			LOADA #0
			LOADSI #1
			LOADDIADRSI
			DECDI
			JMPNZ palindrome
boucle 		LOADAADRSI 
			LOADBADRDI 
			CMPBA
			JMPPZ fin
			CMPSIA
			JMPNZ fin
			INCSI
			DECDI
			CMPBA
			JMPNZ boucle
palindrome	LOADA #1
fin			JMP fin