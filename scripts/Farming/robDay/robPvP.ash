script "robPvP.ash"

/*******************************************************
*					robPvP()
*	Runs daily PvP fights.
/*******************************************************/
string winMessage = "Hi!";
string loseMessage = "Hi!";
int stance = 7;
string hitfor = "lootwhatever";
//string hitfor = "fame";
//string hitfor = "flowers";

void PvPFights()
{
	//visit_url("monkeycastle.php?who=4&action=mombuff&whichbuff=2");
	//cli_execute("use 1 lynyrd snare");
	//cli_execute("familiar none");
 	
	cli_execute("familiar none");
	cli_execute("/outfit naked");
	cli_execute("outfit PvP");
	use_familiar($familiar[Exotic Parrot]);
	
	string attackURL = "peevpee.php?action=fight&place=fight&attacktype=" + hitFor + "&ranked=1" + "&stance=" + stance + "&who=" + "&losemessage=" + loseMessage + "&winmessage=" + winMessage;
	while (pvp_attacks_left() > 0)
		visit_url(attackURL); 
}

void main()
{
	PvPFights();
}