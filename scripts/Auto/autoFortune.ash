script "autoFortune.ash"

void fortune(string name, string a1, string a2, string a3)
{
	visit_url("clan_viplounge.php?preaction=lovetester");
	string str = "choice.php?pwd&whichchoice=1278&option=1&which=1&whichid=" + name + "&q1=" + a1 + "&q2=" + a2 + "&q3=" + a3;
	visit_url(str);
}

void cheesefax()
{	
	cli_execute("/whitelist Bonus Adventures From Hell");
	
	fortune("cheesefax","pizza","batman","thick");
	waitq(15);
	fortune("cheesefax","pizza","batman","thick");
	waitq(15);
	fortune("cheesefax","pizza","batman","thick");
	
	cli_execute("/whitelist The Clan of Intelligent People");
}

void main()
{	
	cheesefax();
	
	put_shop(0,0,$item[How To Get Bigger Without Really Trying]);
	put_shop(0,0,$item[Illustrated Mating Rituals of the Gallapagos]);
	put_shop(0,0,$item[Convincing People You Can See The Future]);
	put_shop(0,0,$item[Love Potions and the Wizards who Mix Them]);
	put_shop(0,0,$item[They'll Love You In Rhinestones]);
	put_shop(0,0,$item[Silly Little Love Song]);
}