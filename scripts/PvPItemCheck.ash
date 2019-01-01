int expensiveValue = 50000;

boolean is_pvpable( item thing )
{
	return is_tradeable( thing ) && is_displayable( thing ) && is_giftable( thing ) && autosell_price( thing ) > 0;
}

void main()
{
	int[item] inventory = get_inventory();
	batch_open();
	foreach it in inventory
	{
		if( is_pvpable( it ) && historical_price( it ) > expensiveValue )
		{
			print( it + ": " + historical_price( it ) );
			put_closet( item_amount( it ), it);
		}
	}
	batch_close();
}