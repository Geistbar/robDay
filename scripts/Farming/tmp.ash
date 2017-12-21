void main()
{
	while (my_adventures() > 0)
	{	
		if (have_effect($effect[everything looks yellow]) == 0)
			cli_execute("robYellowRay.ash");
		adventure(1,$location[Barf Mountain]);
	}
}