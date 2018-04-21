if (!can_interact())
	cli_execute("clanhop.ash (Intelligent Storage Inc.)");
if (!can_interact() && (my_inebriety() > inebriety_limit()))
	cli_execute("buy artificial skylight");