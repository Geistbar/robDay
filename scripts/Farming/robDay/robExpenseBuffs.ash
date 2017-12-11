script "robExpenseBuffs.ash"

/*******************************************************
*					robExpenseBuffs()
*	Uses once off buffs that consume an item or meat.
/*******************************************************/

void expenseBuffs()
{
	getUse(1,$item[red snowcone]);
	getUse(1,$item[Gene Tonic: Constellation]);
	getUse(1,$item[pink candy heart]);
	getUse(1,$item[Knob Goblin pet-buffing spray]);
	getUse(1,$item[Knob Goblin nasal spray]);
	getUse(1,$item[resolution: be wealthier]);
	getUse(1,$item[resolution: be kinder]);
	use(5,$item[Meat-inflating powder]);
	use(1,$item[papier-m&acirc;ch&eacute; toothpicks]);
	getUse(1,$item[recording of The Ballad of Richie Thingfinder]); 
	if (item_amount($item[thin black candle]) < 3)
		cli_execute("buy " + (3-item_amount($item[thin black candle])) + " thin black candle");
	if (item_amount($item[tattered scrap of paper]) < 1)
		cli_execute("buy " + 1 + " tattered scrap of paper");
	if (item_amount($item[inkwell]) < 1)
		cli_execute("buy " + 1 + " inkwell");
	cli_execute("summon 2");
	cli_execute("hatter 22");
}

void main()
{
	expenseBuffs();
}