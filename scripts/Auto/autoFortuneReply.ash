script "Test.ash"

int fortune()
{
	string page = visit_url("clan_viplounge.php?preaction=lovetester");
	matcher fortunetest = create_matcher("(?<=&testlove=)\\d+",page);
	if (find(fortunetest))
		return group(fortunetest).to_int();
	else
		return 0;
}

void main()
{	
	int id;
	while (fortune() > 0)
	{
		id = fortune();
		visit_url("clan_viplounge.php?preaction=lovetester");
		visit_url("clan_viplounge.php?preaction=testlove&testlove=" + id);
		visit_url("clan_viplounge.php?q1=salt&q2=batman&q3=thick&preaction=dotestlove&testlove=" + id);
	}
	print("done!");
}