script "autoDinsey.ash"
notify Giestbar;
import <zlib.ash>

/*******************************************************
*	autoDinsey.ash
*	r10
*	
*	Will retrieve and automatically adventure to finish
*	the daily quest at Dinseylandfill. Various user-defined
*	variables are made available to allow more optimal
*	operation.
*
*	The user can define: outfit, familiar, and autoattack
*	to use with each quest; whether to use "How to Avoid Scams"
*	at Barf Mountain; whether to buy toxic globules; and 
*	the order of priority for each quest.
*
*	You will NEED to set a CCS or combat macro in order to
*	successfully complete the sustenance quest!
*
*	Special thanks to both SKF and MasterSilex for helping!
/*******************************************************/

/*******************************************************
*			USER DEFINED VARIABLES START
/*******************************************************/

// For restoring at the end of the script, if desired
string restoreMood					= "";
string restoreAutoAttack 			= "beach";

/*******************************************************
*		Toggle Variables
*
*	- buyGlobules: When set to TRUE this will automatically
*	buy toxic globules to complete the electrical
*	maintenance quest, if possible. If you are in ronin
*	or HC, this setting should not matter.
*
*	- useScams: When set to TRUE, this will use a
*	How to Avoid Scams to get the +meat buff for quests
*	at Barf Mountain. If you are out of ronin/HC, it will
*	it will buy a copy of the item for you if necessary.
*
*	- shrugOlfaction: When set to TRUE, this will shrug 
*	On The Trail at the start of any quest that benefits
*	from the user having a combat macro or CCS that uses
*	olfaction.
*	
*	- disposeGarbage: When set to TRUE, the script will
*	try to visit the maintenance tunnels and dispose of
*	garbage. The script will buy garbage for you if you
*	are out of ronin/HC and don't have any.
*
*	leaveRapidPassDisabled: When set to TRUE, the script
*	will disable Rapid-Pass at Barf Mountain after
*	completion of the track maintenance script. Otherwise
*	it will leave Rapid-Pass enabled.
/*******************************************************/
boolean buyGlobules				= TRUE;
boolean useScams				= TRUE;
boolean shrugOlfaction			= TRUE;
boolean disposeGarbage			= TRUE;
boolean leaveRapidPassDisabled	= TRUE;

/*******************************************************
*			Outfit, familiar, and autoattacks
*	Enter the names of your outfits auto attacks,
*	and familiars.
*
*	- Outfit: the name of the outfit to use for that quest.
*	If left blank, only necessary equipment will be equipped.
*	Necessary equipment will be equipped automatically: your
*	outfit does not need to include them. Required accessories
*	will be equipped in slot 3. If left blank, only necessary
*	equipment will be equipped.
*	
*	- AutoAttack: for user created combat macros. 
*	If left blank, it will default to mafia's standard behavior.
*
*	- Familiar: the proper/official name of the familiar to use.
*	If left blank, your familiar will not be changed.
*
*	- Mood: the name of the mood you want to use.
*	If left blank, your mood will not be changed.
/*******************************************************/

// Racism Reduction -- ??
string racismOutfit 				= "Beach4";
string racismAutoAttack 			= "Beach";
string racismFamiliar 				= "Stocking Mimic";
string racismMood					= "";

// Waterway Debris Removal -- Stench resistance?
string waterwayOutfit 				= "Beach4";
string waterwayAutoAttack 			= "Beach";
string waterwayFamiliar 			= "Stocking Mimic";
string waterwayMood					= "";

// Compulsory Fun -- ??
string funOutfit 					= "Beach4";
string funAutoAttack 				= "Beach";
string funFamiliar 					= "Stocking Mimic";
string funMood						= "";

// Bear Removal -- Olfact "nasty bear"
string bearOutfit 					= "Beach4";
string bearAutoAttack 				= "dinseyBears";
string bearFamiliar 				= "Stocking Mimic";
string bearMood						= "";

// Electrical Maintenance -- item % or the mall
string electricalOutfit 			= "Beach4";
string electricalAutoAttack 		= "Beach";
string electricalFamiliar 			= "Stocking Mimic";
string electricalMood				= "";

// Track Maintenance -- make the non-combat more likely at maintenance tunnels
string trackOutfit 					= "Meat1";
string trackAutoAttack 				= "Beach";
string trackFamiliar 				= "Adventurous Spelunker";
string trackMood					= "";

// Sexism Reduction -- ??
string sexismOutfit 				= "Beach4";
string sexismAutoAttack 			= "Beach";
string sexismFamiliar 				= "Stocking Mimic";
string sexismMood					= "";

// Guest Sustenance Assurance -- Autoattack/ccs that olfacts garbage or angry tourist, and uses refreshments item on garbage or angry tourists
string sustenanceOutfit 			= "Meat1";
string sustenanceAutoAttack 		= "dinseySustenance";
string sustenanceFamiliar 			= "Adventurous Spelunker";
string sustenanceMood				= "";

/*******************************************************
*					Priority list
*	Assigns a priority to each quest for retrieval.
*	Leave blank to allow the script to work with the
*	default priority.
*
*	If you wish to modify, change the order of the numbers
*	but ensure that each number is dilineated with a single
*	comma. Do not use the same number more than once. Ensure
*	each number is used. Lower numbers are higher priority.
*	
*	Order of entries:
*	1. Racism Reduction
*	2. Waterway Debris Removal
*	3. Compulsory Fun
*	4. Bear Removal
*	5. Electrical Maintenance
*	6. Track Maintenance
*	7. Sexism Reduction
*	8. Guest Sustenance Assurance
*
*	For example, if you wished for "Sexism Reduction" to be
*	the highest priority quest you would change the seventh
*	number listed to be "1".
/*******************************************************/
string priority = "5,8,4,3,1,2,6,7";

/*******************************************************
*			USER DEFINED VARIABLES END
*		PLEASE DO NOT MODIFY VARIABLES BELOW
/*******************************************************/

// Split up priority for indexing
string[int] prioritySplit = split_string(priority,","); 

// Quest names
string racism = "Racism Reduction";
string waterway = "Waterway Debris Removal";
string fun = "Compulsory Fun";
string bear = "Bear Removal";
string electrical = "Electrical Maintenance";
string track = "Track Maintenance";
string sexism = "Sexism Reduction";
string sustenance = "Guest Sustenance Assurance";

// URL strings to make code more readable
string kiosk = "place.php?whichplace=airport_stench&action=airport3_kiosk";
string questLog = "questlog.php?which=1";

// For restoring equipment
item [slot] equipment;
familiar fam;

/*******************************************************
*					saveSetup()
*	Saves your familiar and equipment at the start of
*	the script to revert back to them afterwards.
/*******************************************************/
void saveSetup()
{
	fam = my_familiar();
	foreach eqSlot in $slots[]
		equipment[eqSlot] = equipped_item(eqSlot);
}

/*******************************************************
*					restoreSetup()
*	Restores your familiar and equipment after execution
*	of the script to the state they were in at the
*	beginning. Also restores default mood and
*	autoattack if those are set.
/*******************************************************/
void restoreSetup()
{
	use_familiar(fam);
	foreach eqSlot in $slots[]
	{
		if (equipped_item(eqSlot) != equipment[eqSlot])
			equip(eqSlot, equipment[eqSlot]);
	}
	if (restoreAutoAttack != "")
		cli_execute("autoattack " + restoreAutoAttack);
	if (restoreMood != "")
		cli_execute("mood " + restoreMood);
}

/*******************************************************
*					changeSetup()
*	Changes familiar, outfit, mood and autoattack for
*	quest, based on user defined variables.
/*******************************************************/
void changeSetup(string fam, string gear, string aa, string mood)
{
	if (gear != "")
		outfit(gear);
	if (fam != "")
		cli_execute("familiar " + fam);
	if (aa != "")
		cli_execute("autoattack " + aa);
	if (mood != "")
		cli_execute("mood " + mood);
}

/*******************************************************
*					enableRapidPass()
*	Changes the setting for barf mountain to rapid-pass
*	to speed up the non-combat.
/*******************************************************/
void enableRapidPass()
{
	visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
	string text = visit_url("choice.php?pwd&option=1&whichchoice=1067");
	if (contains_text(text, "Enable Rapid-Pass System"))
		visit_url("choice.php?pwd&option=2&whichchoice=1068");
	visit_url("choice.php?pwd&option=6&whichchoice=1068");
	visit_url("choice.php?pwd&option=7&whichchoice=1067");
}

/*******************************************************
*					disableRapidPass()
*	Changes the setting for barf mountain to rapid-pass
*	to speed up the non-combat.
/*******************************************************/
void disableRapidPass()
{
	visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels"); // Tunnels
	string text = visit_url("choice.php?pwd&option=1&whichchoice=1067");
	if (contains_text(text, "Disable Rapid-Pass System"))
		visit_url("choice.php?pwd&option=2&whichchoice=1068");
	visit_url("choice.php?pwd&option=6&whichchoice=1068");
	visit_url("choice.php?pwd&option=7&whichchoice=1067");
}

/*******************************************************
*					firstQuest()
*	Figures out which quest is first. Returns it
*	as a string.
/*******************************************************/
string firstQuest(string text)
{
	string output = excise(text,"width=250><center><b>","</b>");
	return output;
}

/*******************************************************
*					secondQuest()
*	Figures out which quest is second. Returns it
*	as a string.
/*******************************************************/
string secondQuest(string text)
{
	string output = excise(text,"<input type=hidden name=option value=1><input class=button type=submit value='Accept Assignment'></form></center></td><td valign=top style='border: 1px solid black;' width=250><center><b>","</b>");
	return output;
}

/*******************************************************
*					index()
*	Returns the value of the index to retrieve the
*	priority of each quest.
/*******************************************************/
int index(string quest)
{
	int output;
	if (quest == racism)
		output = 0;
	else if (quest == waterway)
		output = 1;
	else if (quest == fun)
		output = 2;
	else if (quest == bear)
		output = 3;
	else if (quest == electrical)
		output = 4;
	else if (quest == track)
		output = 5;
	else if (quest == sexism)
		output = 6;
	else if (quest == sustenance)
		output = 7;
	return output;
}

/*******************************************************
*					grabQuest()
*	Goes to the Kiosk to get a quest, determined by
*	which of your two potential quests has priority.
*	Uses the kiosk html as input.
/*******************************************************/
void grabQuest(string text)
{
	string first = firstQuest(text);
	string second = secondQuest(text);

	int val1 = index(first);
	int val2 = index(second);

	if (prioritySplit[val1].to_int() < prioritySplit[val2].to_int())
	{
		visit_url("place.php?whichplace=airport_stench&action=airport3_kiosk");
		visit_url("choice.php?pwd&option=1&whichchoice=1066");
	}
	else
	{
		visit_url("place.php?whichplace=airport_stench&action=airport3_kiosk");
		visit_url("choice.php?pwd&option=2&whichchoice=1066");
	}
}

/*******************************************************
*					hasQuest()
*	Checks your questlog to see if you have a Dinsey
*	quest already. Returns TRUE if you do; FALSE
*	otherwise.
/*******************************************************/
boolean hasQuest()
{
	string text = visit_url(questLog);
	foreach qName in $strings[Social Justice Adventurer II, Teach a Man to Fish Trash, Whistling Zippity-Doo-Dah, Nasty\, Nasty Bears, Give Me Fuel, Super Luber, Social Justice Adventurer I, Will Work With Food]
	{
		if(contains_text(text,qName))
			return TRUE;
	}
	return FALSE;
}

/*******************************************************
*					parseQuest()
*	Checks your questlog to figure out which Dinsey
*	quest you have. Returns the questlog name of
*	the quest.
/*******************************************************/
string parseQuest()
{
	string text = visit_url(questLog);
	string output;
	foreach qName in $strings[Social Justice Adventurer I, Teach a Man to Fish Trash, Whistling Zippity-Doo-Dah, Nasty\, Nasty Bears, Give Me Fuel, Super Luber, Social Justice Adventurer II, Will Work With Food]
	{
		if(contains_text(text,qName))
			output = qName;
	}
	return output;
}

/*******************************************************
*					convertQuest()
*	Takes a questlog name of a Dinsey quest as input
*	and convers that quest to the kiosk name of the quest
*	so that other functions can use process that quest
*	name.
/*******************************************************/
string convertQuest(string quest)
{
	string output;
	
	if(quest == "Social Justice Adventurer II")
		output = racism;
	else if(quest == "Teach a Man to Fish Trash")
		output = waterway;
	else if(quest == "Whistling Zippity-Doo-Dah")
		output = fun;
	else if(quest == "Nasty, Nasty Bears")
		output = bear;
	else if(quest == "Give Me Fuel")
		output = electrical;
	else if(quest == "Super Luber")
		output = track;
	else if(quest == "Social Justice Adventurer I")
		output = sexism;
	else if(quest == "Will Work With Food")
		output = sustenance;
	return output;
}

/*******************************************************
*					finishQuest()
*	Adventures at the input location until the quest
*	is determined to be finished according to the
*	questlog entry.
/*******************************************************/
void finishQuest(location place)
{
	while(!contains_text(visit_url(questlog),"<b>Kiosk</b>") && !contains_text(visit_url(questlog),"(You have 20/20)"))
		adventure(1,place);
}

// Actually put all the functions together to make this work.
void main()
{
	try
	{
		// Save equipment and familiar state
		saveSetup();
		// Handle the garbage part
		if(disposeGarbage)
		{
			if (item_amount($item[bag of park garbage]) == 0 && can_interact())
				buy(1,$item[bag of park garbage]);
			visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
			visit_url("choice.php?pwd&option=6&whichchoice=1067");
		}

		if(!hasQuest()) // Only go to the kiosk if you don't have a quest yet
			grabQuest(visit_url(kiosk));
		string quest = convertQuest(parseQuest()); // Grab the quest from questlog

		// Gear up for and do quest, according to which quest it is
		if(quest == racism)
		{
			changeSetup(racismFamiliar, racismOutfit, racismAutoAttack, racismMood);
			finishQuest($location[Uncle Gator's Country Fun-Time Liquid Waste Sluice]);
		}
		else if(quest == waterway)
		{
			changeSetup(waterwayFamiliar, waterwayOutfit, waterwayAutoAttack, waterwayMood);
			if (item_amount($item[trash net]) > 0)
				equip($item[trash net]);
			finishQuest($location[Pirates of the Garbage Barges]);
		}
		else if(quest == fun)
		{
			changeSetup(funFamiliar, funOutfit, funAutoAttack, funMood);
			if (item_amount($item[Dinsey mascot mask]) > 0)
				equip($item[Dinsey mascot mask]);
			finishQuest($location[The Toxic Teacups]);
		}
		else if(quest == bear)
		{
			if (shrugOlfaction)
				cli_execute("shrug on the trail");
			changeSetup(bearFamiliar, bearOutfit, bearAutoAttack, bearMood);
			finishQuest($location[Uncle Gator's Country Fun-Time Liquid Waste Sluice]);
		}
		else if(quest == electrical)
		{
			if (buyGlobules && can_interact())
			{
				if(item_amount($item[toxic globule]) < 20)
					buy(20-item_amount($item[toxic globule]),$item[toxic globule]);
			}
			else
			{
				changeSetup(electricalFamiliar, electricalOutfit, electricalAutoAttack, electricalMood);
				finishQuest($location[The Toxic Teacups]);
			}
		}
		else if(quest == track)
		{
			if (item_amount($item[How to Avoid Scams]) == 0 && useScams)
				buy(1,$item[How to Avoid Scams]);
			if (useScams)
				use(1,$item[How to Avoid Scams]);
			changeSetup(trackFamiliar, trackOutfit, trackAutoAttack, trackMood);
			if (item_amount($item[Lube-shoes]) > 0)
				equip($slot[acc3],$item[Lube-shoes]);
			enableRapidPass();
			finishQuest($location[Barf Mountain]);
			if (leaveRapidPassDisabled)
				disableRapidPass();
		}
		else if(quest == sexism)
		{
			changeSetup(sexismFamiliar, sexismOutfit, sexismAutoAttack, sexismMood);
			finishQuest($location[Pirates of the Garbage Barges]);
		}
		else if(quest == sustenance)
		{
			if (item_amount($item[How to Avoid Scams]) == 0 && useScams)
				buy(1,$item[How to Avoid Scams]);
			if (useScams)
				use(1,$item[How to Avoid Scams]);
			if (shrugOlfaction)
				cli_execute("shrug on the trail");
			changeSetup(sustenanceFamiliar, sustenanceOutfit, sustenanceAutoAttack, sustenanceMood);
			finishQuest($location[Barf Mountain]);
		}
		else
			print("I can't figure out what your quest is! :(,","red");

		// Turn quest in
		visit_url(kiosk);
		visit_url("choice.php?pwd&option=3&whichchoice=1066");
	}
	finally
		restoreSetup();
}