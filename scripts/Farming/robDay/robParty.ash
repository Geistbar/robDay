script "robParty.ash"

/*******************************************************
*					robParty()
*		Gets 10 free adventures in at the Neverending Party and
*		makes use of the free MP restore.
/*******************************************************/

void main()
{
	use_familiar($familiar[fist turkey]);
	cli_execute("outfitMeat1.ash");
	int count = 0;
	while (count < 8)
	{
		count+=1;
		adv1($location[the neverending party],-1,"");
	}
	cli_execute("outfitMP.ash");
	adv1($location[the neverending party],-1,"");
	cli_execute("cast * dice"); cli_execute("outfitMeat1.ash");
	adv1($location[the neverending party],-1,"");
	adv1($location[the neverending party],-1,"");
}