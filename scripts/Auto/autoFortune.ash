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
}