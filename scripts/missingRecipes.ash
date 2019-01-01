script "missingRecipes.ash";
notify turing;

#ver 1.0: Initial Release
#ver 1.1: Fix issue with italics.

boolean[string] recipes;
boolean[string] foods;
boolean[string] equips;
boolean[string] booze;
//boolean[string] jewels;
boolean[string] misc;
int[string] newRecipes;

string thisver = "1.1";

//CheckVersion by Bale.
string CheckVersion() {
	string soft = "missingRecipes";
	string prop = "_version_MissingRecipes";
	int thread = 12090;
	int w; string page;
	boolean sameornewer(string local, string server) {
		if (local == server) return true;
		string[int] loc = split_string(local,"\\.");
		string[int] ser = split_string(server,"\\.");
		for i from 0 to max(count(loc)-1,count(ser)-1) {
			if (i+1 > count(loc)) return false;
			if (i+1 > count(ser)) return true;
			if (loc[i].to_int() < ser[i].to_int()) return false;
			if (loc[i].to_int() > ser[i].to_int()) return true;
		}
		return local == server;
	}
	switch(get_property(prop)) {
	case thisver: return "";
	case "":
		print("Checking for updates (running "+soft+" ver. "+thisver+")...");
		page = visit_url("http://kolmafia.us/showthread.php?t="+thread);
		matcher find_ver = create_matcher("<b>"+soft+" (.+?)</b>",page);
		if (!find_ver.find()) {
			print("Unable to load current version info.", "red");
			set_property(prop,thisver);
			return "";
		}
		w=19;
		set_property(prop,find_ver.group(1));
		default:
		if(sameornewer(thisver,get_property(prop))) {
			set_property(prop,thisver);
			print("You have a current version of "+soft+".");
			return "";
		}
		string msg = "<big><font color=red><b>New Version of "+soft+" Available: "+get_property(prop)+"</b></font></big>"+
		"<br><a href='http://kolmafia.us/showthread.php?t="+thread+"' target='_blank'><u>Upgrade from "+thisver+" to "+get_property(prop)+" here!</u></a><br>"+
		"<small>Think you are getting this message in error?  Force a re-check by typing \"set "+prop+" =\" in the CLI.</small><br>";
		find_ver = create_matcher("\\[requires revision (.+?)\\]",page);
		if (find_ver.find() && find_ver.group(1).to_int() > get_revision())
		msg += " (Note: you will also need to <a href='http://builds.kolmafia.us/' target='_blank'>update mafia to r"+find_ver.group(1)+" or higher</a> to use this update.)";
		print_html(msg);
		if(w > 0) wait(w);
		return "<div class='versioninfo'>"+msg+"</div>";
	}
	return "";
}

string fixString(string input)
{
	matcher entry_matcher1 = create_matcher("&[^;]*;", input);
	input = replace_all(entry_matcher1, "_");

	matcher entry_matcher2 = create_matcher("[^A-Za-z0-9\\(\\) \\+=-]", input);
	return replace_all(entry_matcher2, "_");
}

boolean isObtainable(string name)
{
	if (contains_text(name, "lit cigar =")) return false;
	if (contains_text(name, "Mighty Bjorn action figure =")) return false;
	if (contains_text(name, "plate of franks and beans =")) return false;
	if (contains_text(name, "flask of peppermint schnapps =")) return false;
	if (contains_text(name, "rainbow pearl")) return false;
	return true;
}

void loadRecipePage(string url, boolean[string] list, boolean isMisc)
{
	string page = visit_url(url);
	page = replace_string(page, "<i>", "");
	page = replace_string(page, "</i>", "");

	if (isMisc)
	{
		matcher entry_matcher = create_matcher( "<td style=\"vertical-align: top;\"><b><a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a></b><br /><span style=\"font-size: x-small;\"> [^<]* x <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a> </span>", page );
		while ( entry_matcher.find() )
		{
			string entry = entry_matcher.group( 0 );

			matcher text_matcher = create_matcher( "title=\"[^\"]*\">([^<]*)</a></b><br /><span style=\"font-size: x-small;\"> ([^<]*) x <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">([^<]*)</a> </span>", entry);
			if ( !text_matcher.find() )
				continue;

			string name = fixString(text_matcher.group( 1 ) + " = " + text_matcher.group( 2 ) + " x " + text_matcher.group( 3 ));

			if (isObtainable(name))
				list[name] = false;

		}
	}
	else
	{
		matcher entry_matcher = create_matcher( "<td style=\"vertical-align: top;\"><b><a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a></b><br /><span style=\"font-size: x-small;\">  <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a> \\+ <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a></span>", page );
		while (entry_matcher.find())
		{
			string entry = entry_matcher.group( 0 );

			matcher text_matcher = create_matcher( "title=\"[^\"]*\">([^<]*)</a></b><br /><span style=\"font-size: x-small;\">  <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">([^<]*)</a> \\+ <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">([^<]*)</a></span>", entry);
			if ( !text_matcher.find() )
				continue;

			string name = fixString(text_matcher.group( 1 ) + " = "+ text_matcher.group( 2 ) + " + " + text_matcher.group( 3 ));

			if (isObtainable(name))
				list[name] = false;
		}
		entry_matcher = create_matcher( "<td style=\"vertical-align: top;\"><b><a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a></b><br /><span style=\"font-size: x-small;\">  <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">[^<]*</a> </span>", page );
		while (entry_matcher.find())
		{
			string entry = entry_matcher.group( 0 );

			matcher text_matcher = create_matcher( "title=\"[^\"]*\">([^<]*)</a></b><br /><span style=\"font-size: x-small;\">  <a href=\"/thekolwiki/index.php/[^\"]*\" title=\"[^\"]*\">([^<]*)</a> </span>", entry);
			if ( !text_matcher.find() )
				continue;
			string name = fixString(text_matcher.group( 1 ) + " = "+ text_matcher.group( 2 ));

			if (isObtainable(name))
				list[name] = false;
		}

	}
}

void loadRecipes()
{
	print("Checking the Wiki for Meat-Pasting Discoveries...");
	loadRecipePage("http://kol.coldfront.net/thekolwiki/index.php/Meat-Pasting_Discoveries", recipes, false);
	print("Checking the Wiki for Cooking Discoveries...");
	loadRecipePage("http://kol.coldfront.net/thekolwiki/index.php/Cooking_Discoveries", foods, false);
	print("Checking the Wiki for Meatsmithing Discoveries...");
	loadRecipePage("http://kol.coldfront.net/thekolwiki/index.php/Meatsmithing_Discoveries", equips, false);
	print("Checking the Wiki for Cocktailcrafting Discoveries...");
	loadRecipePage("http://kol.coldfront.net/thekolwiki/index.php/Cocktailcrafting_Discoveries", booze, false);
	// print("Checking the Wiki for Jewelrycrafting Discoveries...");
	// loadRecipePage("http://kol.coldfront.net/thekolwiki/index.php/Jewelry_Discoveries", jewels, false);
	print("Checking the Wiki for Miscellaneous Discoveries...");
	loadRecipePage("http://kol.coldfront.net/thekolwiki/index.php/Miscellaneous_Discoveries", misc, true);
	print("");
}

void parseRecipes(string URL, boolean[string] recipeList, string type)
{
	string page = visit_url(URL);
	page = replace_string(page, "<i>", "");
	page = replace_string(page, "</i>", "");

	matcher entry_matcher = create_matcher( "<b>[^<]*?</b> <font size=1>(<font size=2>\\[[^\\]]*\\]&nbsp;\\[[^\\]]*\\]</font>)?(<font size=2>\\[[^\\]]*\\]</font>)?<br/>[^<]*</font></td>", page );
	while ( entry_matcher.find() )
	{
		string entry = entry_matcher.group( 0 );

		if (contains_text(type, "Miscellaneous"))
		{
			matcher text_matcher = create_matcher( "<b>([^<]*?)</b> <font size=1>.*<br/>(.*?) \\(.*\\)</font></td>", entry);
			if ( !text_matcher.find() )
				continue;

			string name = fixString(text_matcher.group( 1 ) + " = "+ text_matcher.group( 2 ));

			if (recipeList contains name)
			{
				recipeList[name] = true;
			}
			else
			{
				newRecipes["(" + type + ") " + name] = 0;
			}
		}
		else
		{
			matcher text_matcher = create_matcher( "<b>([^<]*?)</b> <font size=1>.*<br/>(.*?) \\([^\\)]*\\) \\+ (.*?) \\([^\\)]*\\)</font></td>", entry);
			string name1;
			string name2;
			if ( !text_matcher.find() )
			{
				text_matcher = create_matcher( "<b>([^<]*?)</b> <font size=1>.*<br/>(.*?) \\([^\\)]*\\)</font></td>", entry);
				if ( !text_matcher.find() )
					continue;

				name1 = fixString(text_matcher.group( 1 ) + " = "+ text_matcher.group( 2 ));
				name2 = name1;
			}
			else
			{
				name1 = fixString(text_matcher.group( 1 ) + " = "+ text_matcher.group( 2 ) + " + " + text_matcher.group( 3 ));
				name2 = fixString(text_matcher.group( 1 ) + " = "+ text_matcher.group( 3 ) + " + " + text_matcher.group( 2 ));
			}


			if (recipeList contains name1)
			{
				recipeList[name1] = true;
			}
			else if (recipeList contains name2)
			{
				recipeList[name2] = true;
			}
			else
			{
				newRecipes["(" + type + ") " + name1] = 0;
			}
		}

	}
}

int grandTotal;
int grandCount;

void printList(string type, boolean[string] recipeList)
{
	int count, total;
	print ("You are missing the following " + type + " recipes:", "blue");
	foreach r in recipeList
	{
		if (!recipeList[r])
		{
			print(r);
			count = count + 1;
		}
	}
	total = count(recipeList);
	if (count == total) print("None!  You have them all!", "blue");
	print((total - count) + "/" + total, "blue");
	grandCount = grandCount + count;
	grandTotal = grandTotal + total;
	print("");
}

void parseall()
{
	parseRecipes("craft.php?mode=discoveries&what=combine", recipes, "Meat-Pasting");
	printList("meatpasting", recipes);
	parseRecipes("craft.php?mode=discoveries&what=cook", foods, "Cooking");
	printList("cooking", foods);
	parseRecipes("craft.php?mode=discoveries&what=smith", equips, "Smithing");
	printList("smithing", equips);
	parseRecipes("craft.php?mode=discoveries&what=cocktail", booze, "Cocktailcrafting");
	printList("cocktailcrafting", booze);
	//parseRecipes("craft.php?mode=discoveries&what=jewelry", jewels, "Jewelrycrafting");
	//printList("jewelrycrafting", jewels);
	parseRecipes("craft.php?mode=discoveries&what=multi", misc, "Miscellaneous");
	printList("miscellaneous", misc);
	print("");
	print("Grand Total: " + (grandTotal - grandCount) + "/" + grandTotal, "blue");
}

void main ()
{
	CheckVersion();
	loadRecipes();
	parseAll();
	if (count(newRecipes) > 0)
	{
		print ("You have recipes that are not on the wiki yet! Please add them.", "red");
		foreach rr in newRecipes
		{
			print(rr);
		}
	}
	print("Done!");

}
