#singleinstance,off
Fillers:
	Filler0=I met this really cute girl and I really don't know if she likes me. So,
	Filler1= It didn't really mean anything though. Anyway,
	Filler2=But friends do that kind of thing too, right? Also,
	Filler3=It definitely could have been in a platonic way though.
	Filler4=I mean, I can't be sure she's into me. Ok, so
	Filler5=I guess that might have been an accident. I mean,
	Filler6=If she liked me the signs would be clearer I think. Anyway, after that,
	Filler7=and,
	Filler8=and,
	Filler9=and,
	Filler10=and,
	Filler11=and,
	Filler12=and,
	Filler13=and,
	Filler14=and,
	Filler15=and,
	Filler16=and,
	Filler17=and,
	Filler18=and,
	Fillerx= But I mean I really can't tell if she likes me or what.

;-----------------------------------------Autorun section--------------------------------
Finish0:
	Gui, gui0:new
	Gui, gui0:default
	Gui, add, Text,, Start by rating how much you think she likes you.
	Gui, add, Text, vfriends, she thinks we're just friends
	Gui, add, Text, vmates, she clearly knows we're soulmates
	Gui, add, Slider, vPerceivedLove section x150 w200 Buddy1friends Buddy2mates, 50
	Gui, add, Button, gFinish1 Default, Submit
	Gui, show, center autosize
	return 


Finish1:
	Gui, gui0:Submit
	Gui, gui1:new,
	Gui, gui1:default
	Gui, add, Text,, In complete sentences, describe your lesbian encounter. Use one box per sentence. `nThen`, rate how that made you feel.
	Gui, add, Text,vdidntcare,Didn't Care
	Gui, add, Text,vgonnamelt, Gonna Melt
	CurrentControl = 0
	Gui, add, Button, Section Default gAddSentence, Add new sentence
	Gui, add, Button, ys gFinish2, Submit
	Gui, gui0:cancel
	gosub, AddSentence
	return
	
	
AddSentence:
	CurrentControl :=1+CurrentControl
	Gui, add, edit, xs Section -WantEnter w300 vSentence%CurrentControl%
	Gui, add, slider, vRating%CurrentControl% ys xs400 Buddy1didntcare Buddy2gonnamelt, 50
	Gui, show, AutoSize Center
	return



Finish2:
	Gui, gui1:submit
	TheParagraph = %Filler0%
	PreAverageRating := 0
	loop,
	{
		WorkingSentence := Sentence%a_index%
		WorkingFiller := Filler%a_index%
		TheParagraph = %TheParagraph% %WorkingSentence%. %WorkingFiller%
		
		
		PrePreAverageRating := Rating%a_index%
		PreAverageRating := (PreAverageRating + PrePreAverageRating)
		
		If (a_index = CurrentControl)
		break
	}
	TheParagraph = %TheParagraph% %Fillerx%
	AverageRating := (PreAverageRating/CurrentControl)	
	Gui, Gui2:new
	Gui, Gui2:default
	Gui, add, text,, Listen to the this audio then give yourself an honest rating on how useless you sound.
	Gui, add, Button, vListentoaudio gListentoaudio, Listen to audio
	Gui, add, text, vknowwhatsup, I know what's up
	Gui, add, text, vsouseless, Wow I sound so stereotypically useless
	Gui, add, Slider, x100 vPerceivedUselessness Buddy2souseless Buddy1knowwhatsup w300, 70
	Gui, add, Button, gFinish3, Submit
	Gui, show, Center autosize
	return
	
Listentoaudio:
	guicontrol, disable, Listentoaudio
	runwait, nircmd.exe speak text "%TheParagraph%"
	guicontrol, enable, Listentoaudio
	return
	
Finish3:
	Gui, Gui2:Submit
	AntiPerceivedLove := 100 - PerceivedLove
	;msgbox, help1 %AntiPerceivedLove% help %AverageRating% help %PerceivedUselessness%
	
	FinalScore := AverageRating + AntiPerceivedLove + PerceivedUselessness
	;msgbox, help %FinalScore%
	FinalScore := FinalScore/3
	;msgbox, help %FinalScore%
	If (FinalScore < 0)
	{
		FinalScore = 0
	}
	If (FinalScore > 100)
	{
		FinalScore = 100
	}
	FinalScore := Round(FinalScore)
	gui, submit
	gui, gui3:new
	gui, gui3:default
	Gui, font, s30
	Gui, add, text,, You are %FinalScore% percent useless.
	Gui, show, Center, AutoSize
	Gui, add, Button, gCloseit, Close
	return

Closeit:
	exitapp
	return

;---------------------Gui Button Actions---------------




Gui0GuiClose:
Gui1GuiClose:
Gui2GuiClose:
Gui3GuiClose:
GuiClose: 
	ExitApp
	return